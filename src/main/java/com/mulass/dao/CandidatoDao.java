package dao;

import javax.swing.*;
import model.*;
import util.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidatoDao {

	public final Conexao conm = new Conexao();
		
	public  void criarTabela(){
	
		String sql = "CREATE TABLE IF NOT EXISTS candidato("+
								"id INT GENERATED ALWAYS AS IDENTITY,"+
								"nrCandidato INT,"+
								"nome VARCHAR(100),"+
								"apelido VARCHAR(100),"+
								"genero CHAR(1) CHECK(genero IN('M','F')),"+
								"pais VARCHAR(100),"+
								"prov_Nasc VARCHAR(100),"+
								"prov_Resi VARCHAR(100),"+
								"nacionalidade VARCHAR(100),"+
								"estCivil VARCHAR(20),"+
								"data_nasc DATE,"+
								"regime VARCHAR(100),"+
								"delegacao VARCHAR(100),"+
								"escoPU VARCHAR(100),"+
								"opcao1 VARCHAR(100),"+
								"opcao2 VARCHAR(100),"+
								"tipoEst VARCHAR(100),"+
								"CONSTRAINT pk_Cand PRIMARY KEY(id,nrCandidato)"+
								")";	
								
		try{
			Connection conexao = conm.getConnection();
			Statement stmt = conexao.createStatement();
				stmt.executeUpdate(sql);
				conm.fechar();
		}catch(SQLException e){
		conm.fechar();
			throw  new RuntimeException("Erro ao criar tabela!!", e);
		}
	}
	
	public void salvar(GerenciarCandidato candidato){
		String sql = candidato.getId() == 0 ? 
			"INSERT INTO candidato (nome, apelido, nrCandidato, genero, pais, " +
      "prov_Nasc, prov_Resi, nacionalidade, estCivil, data_nasc, regime, " +
      "delegacao, escoPU, opcao1, opcao2, tipoEst, bi) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)" :
      "UPDATE candidato SET nome=?, apelido=?, nrCandidato=?, genero=?, " +
      "pais=?, prov_Nasc=?, prov_Resi=?, nacionalidade=?, estCivil=?, " +
     	"data_nasc=?, regime=?, delegacao=?, escoPU=?, opcao1=?, opcao2=?, " +
      "tipoEst=?, bi=? WHERE id=?";
            
            
    try{
    	Connection cones = conm.getConnection();
    	PreparedStatement stmt = cones.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
      //System.out.println("1 ");
      stmt.setString(1, candidato.getNome());
      stmt.setString(2, candidato.getApelido());
      stmt.setInt(3, candidato.getNrCandidato());
      stmt.setString(4, candidato.getGenero());
      stmt.setString(5, candidato.getPais());
      stmt.setString(6, candidato.getProv_Nasc());
      stmt.setString(7, candidato.getProv_Resi());
      stmt.setString(8, candidato.getNacionalidade());
    	stmt.setString(9, candidato.getEstCivil());
    	stmt.setDate(10, new java.sql.Date(candidato.getData_nasc().getTime()));
    	stmt.setString(11, candidato.getRegime());
    	stmt.setString(12, candidato.getDelegacao());
    	stmt.setString(13, candidato.getEscoPU());
    	stmt.setInt(14, candidato.getOpcao1());
    	stmt.setInt(15, candidato.getOpcao2());
    	stmt.setString(16, candidato.getTipoEst());
    	stmt.setString(17, candidato.getBI());
    	
    	if(candidato.getId() != 0){
    		stmt.setInt(18,candidato.getId());
    	}
    	stmt.executeUpdate();
    
    	if(candidato.getId() == 0){
    		try(ResultSet rs = stmt.getGeneratedKeys()){
    			if(rs.next()){
    				candidato.setId(rs.getInt(1));
    			}
    		}
    	}
    	conm.fechar();
		}catch(Exception e){
			conm.fechar();
				throw new RuntimeException("Erro ao salvar candidato!!" + e.getMessage(), e);			
		}
	}
	
	 public List<GerenciarCandidato> buscar() throws SQLException {
        List<GerenciarCandidato> candit = new ArrayList<>();
        String sql = "SELECT * FROM candidato";
        try{
        		Connection conesd = conm.getConnection();
            Statement stmt = conesd.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                GerenciarCandidato candidato = new GerenciarCandidato();
                candidato.setId(rs.getInt("id"));
                candidato.setBI(rs.getString("bi"));
                candidato.setNrCandidato(rs.getInt("nrCandidato"));
                candidato.setNome(rs.getString("nome"));
                candidato.setApelido(rs.getString("apelido"));
                candidato.setGenero(rs.getString("genero"));
                candidato.setPais(rs.getString("pais"));
                candidato.setProv_Nasc(rs.getString("prov_Nasc"));
                candidato.setProv_Resi(rs.getString("prov_Resi"));
                candidato.setNacionalidade(rs.getString("nacionalidade"));
                candidato.setEstCivil(rs.getString("estCivil"));
                candidato.setData_nasc(rs.getDate("data_nasc"));
                candidato.setRegime(rs.getString("regime"));
                candidato.setDelegacao(rs.getString("delegacao"));
                candidato.setEscoPU(rs.getString("escoPU"));
                candidato.setOpcao1(rs.getInt("opcao1"));
                candidato.setOpcao2(rs.getInt("opcao2"));
                candidato.setTipoEst(rs.getString("tipoEst"));
                candit.add(candidato);
            }
            conm.fechar();
        } catch (SQLException e) {
            conm.fechar();
            throw new RuntimeException("Erro ao buscar candidato: " + e.getMessage(), e);
        }
        return candit;
    }
    
        public GerenciarCandidato buscarPorNrCandidato(int nrCandidato) throws SQLException {
        String sql = "SELECT * FROM candidato WHERE nrCandidato = ?";
        try{
        		Connection conn = conm.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, nrCandidato);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    GerenciarCandidato candidato = new GerenciarCandidato();
                    candidato.setId(rs.getInt("id"));
                    candidato.setBI(rs.getString("bi"));
                    candidato.setNrCandidato(rs.getInt("nrCandidato"));
                    candidato.setNome(rs.getString("nome"));
                    candidato.setApelido(rs.getString("apelido"));
                    candidato.setGenero(rs.getString("genero"));
                    candidato.setPais(rs.getString("pais"));
                    candidato.setProv_Nasc(rs.getString("prov_Nasc"));
                    candidato.setProv_Resi(rs.getString("prov_Resi"));
                    candidato.setNacionalidade(rs.getString("nacionalidade"));
                    candidato.setEstCivil(rs.getString("estCivil"));
                    candidato.setData_nasc(rs.getDate("data_nasc"));
                    candidato.setRegime(rs.getString("regime"));
                    candidato.setDelegacao(rs.getString("delegacao"));
                    candidato.setEscoPU(rs.getString("escoPU"));
                    candidato.setOpcao1(rs.getInt("opcao1"));
                    candidato.setOpcao2(rs.getInt("opcao2"));
                    candidato.setTipoEst(rs.getString("tipoEst"));
                    return candidato;
                }
            }
            conm.fechar();
        } catch (SQLException e) {
            conm.fechar();
            throw new RuntimeException("Erro ao buscar candidato por nrCandidato: " + e.getMessage(), e);
        }
        return null;
    }
    
    
    // Retorna todas as províncias distintas da tabela de candidatos
		public List<String> buscarProvinciasDistintas() throws SQLException {
    List<String> provincias = new ArrayList<>();
    String sql = "SELECT DISTINCT prov_resi FROM candidato ORDER BY prov_resi";

    try {
    	Connection conn = conm.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            provincias.add(rs.getString("prov_resi"));
        }
        conm.fechar();
    }catch(SQLException e){
    	conm.fechar();
    	throw new RuntimeException("Erro distincy " + e.getMessage());
    }

    return provincias;
	}

		// Retorna todos os candidatos de uma província específica
		public List<GerenciarCandidato> buscarPorProvincia(String provincia) throws SQLException {
    List<GerenciarCandidato> candidatos = new ArrayList<>();
    String sql = "SELECT id, nrcandidato, nome, opcao1, opcao2, prov_resi FROM candidato WHERE prov_resi = ?";

    try {
    		Connection conn = conm.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, provincia);

        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                GerenciarCandidato c = new GerenciarCandidato();
                c.setId(rs.getInt("id"));
                c.setNrCandidato(rs.getInt("nrcandidato"));
                c.setNome(rs.getString("nome"));
                c.setOpcao1(rs.getInt("opcao1"));
                c.setOpcao2(rs.getInt("opcao2"));
                c.setProv_Resi(rs.getString("prov_resi"));
                candidatos.add(c);
            }
        }
        conm.fechar();
    }catch(SQLException e){
    	conm.fechar();
    	throw new RuntimeException("Errro candidato especificando a provincia " + e.getMessage());
    }

    return candidatos;
	}

	
}
