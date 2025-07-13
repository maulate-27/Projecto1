package dao;

import model.*;
import util.Conexao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;

public class SalaDAO {
    private final Conexao conexao = new Conexao();

    public void criarTabela() {
        String sql = "CREATE TABLE IF NOT EXISTS salas (" +
                "SalaID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, " +
                "Local VARCHAR(100) NOT NULL, " +
                "NrSala VARCHAR(50) NOT NULL, " +
                "Provincia VARCHAR(100), " +
                "prioridade INT DEFAULT 0, " +
                "Ordem INT DEFAULT 0, " +
                "capacidade INT NOT NULL CHECK (capacidade >= 0), " +
                "NrVigilante INT DEFAULT 0, " +
                "EmUso BOOLEAN DEFAULT FALSE" +
                ")";
        
        try {
        		Connection conn = conexao.getConnection();
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            conexao.fechar();
        } catch (SQLException e) {
            
            throw new RuntimeException("Erro ao criar tabela salas: " + e.getMessage(), e);
        }
    }

    public void salvar(SalaEstrutura sala) {
    try{
   			Connection conn = conexao.getConnection();
        String sql = sala.getSalaID() == 0 ?
                "INSERT INTO salas (Local, NrSala, Provincia, prioridade, Ordem, capacidade, NrVigilante, EmUso) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)" :
                "UPDATE salas SET Local=?, NrSala=?, Provincia=?, prioridade=?, Ordem=?, capacidade=?, NrVigilante=?, EmUso=? " +
                "WHERE SalaID=?";

            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, sala.getLocal());
            stmt.setString(2, sala.getNrSala());
            stmt.setInt(3, sala.getProvincia());
            stmt.setInt(4, sala.getPrioridade());
            stmt.setInt(5, sala.getOrdem());
            stmt.setInt(6, sala.getCapacidade());
            stmt.setInt(7, calcularNrVigilante(sala.getCapacidade()));
            stmt.setBoolean(8, sala.isEmUso());

            if (sala.getSalaID() != 0) {
                stmt.setInt(9, sala.getSalaID());
            }

            stmt.executeUpdate();

            if (sala.getSalaID() == 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        sala.setSalaID(rs.getInt(1));
                    }
                }
            }
            conexao.fechar();
        } catch (SQLException e) {
            conexao.fechar();
            throw new RuntimeException("Erro ao salvar sala: " + e.getMessage(), e);
        }
    }

    public List<SalaEstrutura> buscarTodas() {
     List<SalaEstrutura> salas = new ArrayList<>();
     String sql = "SELECT SalaID, local, NrSala, Provincia, prioridade, Ordem, capacidade, NrVigilante, EmUso " +
                     "FROM salas ORDER BY Ordem, prioridade DESC";
    	try{
    		Connection conn = conexao.getConnection();
       
      
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                SalaEstrutura sala = new SalaEstrutura();
                sala.setSalaID(rs.getInt("SalaID"));
                sala.setLocal(rs.getString("Local"));
                sala.setNrSala(rs.getString("NrSala"));
                sala.setProvincia(rs.getInt("Provincia"));
                sala.setPrioridade(rs.getInt("prioridade"));
                sala.setOrdem(rs.getInt("Ordem"));
                sala.setCapacidade(rs.getInt("capacidade"));
                sala.setNrVigilante(rs.getInt("NrVigilante"));
                sala.setEmUso(rs.getBoolean("EmUso"));
                salas.add(sala);
            }
            conexao.fechar(); 
        } catch (SQLException e) {
            conexao.fechar();
            throw new RuntimeException("Erro ao buscar salas: " + e.getMessage(), e);
        }
       
        return salas;
        
    }

	   // Conta candidatos alocados na mesma sala, data e hora
		public int contarCandidatosNaSalaPorDataEHora(String nrSala, LocalDate data, String hora) {
	    String sql = "SELECT COUNT(*) FROM sala_candidato WHERE sala = ? AND data = ? AND hora = ?";
	    try {
	    		Connection conn = conexao.getConnection();
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, nrSala);
        	stmt.setDate(2, Date.valueOf(data));
        	stmt.setString(3, hora);
        	ResultSet rs = stmt.executeQuery();
        	if (rs.next()) {
            return rs.getInt(1);
        	}
        	conexao.fechar();
    	}catch(SQLException e){
    		conexao.fechar();
    	}

    	return 0;
		}

    
    // Retorna todas as salas de uma escola
		public List<SalaEstrutura> buscarPorEscola(String escolaId){
    List<SalaEstrutura> salas = new ArrayList<>();
    String sql = "SELECT * FROM salas WHERE local = ?";	

    try{
    	Connection conn = conexao.getConnection();
      PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, escolaId);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            SalaEstrutura s = new SalaEstrutura();
            		s.setSalaID(rs.getInt("SalaID"));
                s.setLocal(rs.getString("Local"));
                s.setNrSala(rs.getString("NrSala"));
                s.setProvincia(rs.getInt("Provincia"));
                s.setPrioridade(rs.getInt("prioridade"));
                s.setOrdem(rs.getInt("Ordem"));
                s.setCapacidade(rs.getInt("capacidade"));
                s.setNrVigilante(rs.getInt("NrVigilante"));
                s.setEmUso(rs.getBoolean("EmUso"));
            salas.add(s);
        }
        conexao.fechar();
    }catch(SQLException e){
    	conexao.fechar();
    	throw new RuntimeException("Erro nas salas " + e.getMessage());
    }

    return salas;
	}


    private int calcularNrVigilante(int capacidade) {
        if (capacidade == 30) {
            return 1;
        } else if (capacidade > 30 && capacidade <= 60) {
            return 2;
        }
        return 0; // Para capacidades fora do intervalo especificado
    }
}
