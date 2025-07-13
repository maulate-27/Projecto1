package dao;

import java.util.*;
import model.*;
import util.*;
import java.sql.*;

public class SalaCandidatoDAO {
    private final Conexao conexao = new Conexao();

    public void criarTabela() {
        String sql = "CREATE TABLE IF NOT EXISTS sala_candidato (" +
                "id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, " +
                "provincia VARCHAR(100), " +
                "nrCandidato INT NOT NULL, " +
                "nome VARCHAR(100), " +
                "opcao1 VARCHAR(100), " +
                "opcao2 VARCHAR(100), " +
                "disciplina VARCHAR(100), " +
                "local VARCHAR(100), " +
                "sala VARCHAR(50) NOT NULL" +
                ")";
        
        try (Connection conn = conexao.getConnection();
            Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
        } catch (SQLException e) {
            conexao.fechar();
            throw new RuntimeException("Erro ao criar tabela sala_candidato: " + e.getMessage(), e);
        }
    }

    public void salvar(Sala salaCandidato, SalaEstrutura salla) {
    try {
    		Connection conn = conexao.getConnection();
        String sql = salaCandidato.getId() == 0 ? "INSERT INTO sala_candidato (provincia, nrCandidato, nome, opcao1, opcao2, disciplina, local, sala, data) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)" :
                     "UPDATE sala_candidato set provincia = ?, nrCandidato = ?, nome = ?, opcao1 = ?, opcao2 = ?, disciplina = ?, local = ?, sala = ?, data =?" +
                     "Where id = ?";
                     
                     System.out.println("Salvando alocação: Candidato " + salaCandidato.getNrCandidato() + ", Sala: " + salaCandidato.getSala()); 

        
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
             
             if(conn.isClosed()){
             	throw new SQLException("Conexao foi fechada antes mesmo de salvar o candidato");
             }
            // conn.setAutoCommit(false);
            stmt.setString(1, salaCandidato.getProvincia());
            stmt.setInt(2, salaCandidato.getNrCandidato());
            stmt.setString(3, salaCandidato.getNome());
            stmt.setString(4, salaCandidato.getOpcao1());
            stmt.setString(5, salaCandidato.getOpcao2());
            stmt.setString(6, salaCandidato.getDisciplina());
            stmt.setString(7, salla.getLocal());
            stmt.setString(8, salaCandidato.getSala());
            stmt.setDate(9, java.sql.Date.valueOf(salaCandidato.getData()));

						
						if (salaCandidato.getId() != 0) {
                stmt.setInt(10, salaCandidato.getId());
            }
          	int linhasAfectadas = stmt.executeUpdate();
						System.out.println("Linhas afetadas: " + linhasAfectadas);
						
						if(salaCandidato.getId() == 0){
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    salaCandidato.setId(rs.getInt(1));
                }
            }
            }
            //conn.commit();
            conexao.fechar();
        } catch (SQLException e) {
           System.err.println("Erro ao salvar alocação: " + e.getMessage());
            throw new RuntimeException("Erro ao salvar sala_candidato: " + e.getMessage(), e);
        }
    }
    
    public List<Sala> buscar() {
     List<Sala> alocacoes = new ArrayList<>();
     String sql = "SELECT  * FROM sala_candidato order by nrcandidato, data, disciplina";
    	try {
    		Connection conn = conexao.getConnection();
       
        
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Sala salaCandidato = new Sala();
                salaCandidato.setId(rs.getInt("id"));
                salaCandidato.setProvincia(rs.getString("provincia"));
                salaCandidato.setNrCandidato(rs.getInt("nrCandidato"));
                salaCandidato.setNome(rs.getString("nome"));
                salaCandidato.setOpcao1(rs.getString("opcao1"));
                salaCandidato.setOpcao2(rs.getString("opcao2"));
                salaCandidato.setDisciplina(rs.getString("disciplina"));
                salaCandidato.setLocal(rs.getString("local"));
                salaCandidato.setSala(rs.getString("sala"));
                salaCandidato.setData(rs.getDate("data").toLocalDate());
                alocacoes.add(salaCandidato);
            }
             conexao.fechar();
            
       } catch (SQLException e) {
        		conexao.fechar();
            throw new RuntimeException("Erro2" + e.getMessage(), e);
       }
       
        return alocacoes;
        
    }

    public List<Sala> buscarPorProvincia(String provincia)  {
    List<Sala> alocacoes = new ArrayList<>();
    String sql = "SELECT * FROM sala_candidato WHERE provincia = ? order by nrcandidato, data, disciplina";
    try {
    		Connection conn = conexao.getConnection();
        
             PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, provincia);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Sala salaCandidato = new Sala();
                    salaCandidato.setId(rs.getInt("id"));
                    salaCandidato.setProvincia(rs.getString("provincia"));
                    salaCandidato.setNrCandidato(rs.getInt("nrCandidato"));
                    salaCandidato.setNome(rs.getString("nome"));
                    salaCandidato.setOpcao1(rs.getString("opcao1"));
                    salaCandidato.setOpcao2(rs.getString("opcao2"));
                    salaCandidato.setDisciplina(rs.getString("disciplina"));
		                salaCandidato.setLocal(rs.getString("local"));
                    salaCandidato.setSala(rs.getString("sala"));
                    salaCandidato.setData(rs.getDate("data").toLocalDate());
                    alocacoes.add(salaCandidato);
                }
            }
          conexao.fechar();
       }catch (SQLException e) {
        		conexao.fechar();
            throw new RuntimeException("Erro1 " + e.getMessage(), e);
        }
         
        return alocacoes;
        
    }
    
    // verificar se ao candidato esta na sala ou nao
		public boolean jaAlocado(int nrCandidato, String disciplina) {
    String sql = "SELECT COUNT(*) FROM sala_candidato WHERE nrcandidato = ? AND disciplina = ?";
    try {
    	Connection conn = conexao.getConnection();
      PreparedStatement stmt = conn.prepareStatement(sql);
      	stmt.setInt(1, nrCandidato);
        stmt.setString(2, disciplina);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
        conexao.fechar();
    }catch(SQLException e){
    	conexao.fechar();
    	throw new RuntimeException("Erro ao verificar alocacao");
    }
    return false;
	}

    
     public void excluirTudo() {
     try {
     		Connection conn = conexao.getConnection();
        String sql = "DELETE FROM sala_candidato";
        
             Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            conexao.fechar();
        } catch (SQLException e) {
        		conexao.fechar();
            throw new RuntimeException("Erro ao excluir alocações: " + e.getMessage(), e);
        }
    }
}
