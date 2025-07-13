package dao;

import model.*;
import util.*;
import java.sql.*;
import java.util.*;


public class DisciplinaDao {
	private final Conexao conexao = new Conexao();
	public void criarTabela(){
		String sql = "CREATE TABLE IF NOT EXISTS disciplinas("+
				"id INT GENERATED ALWAYS AS IDENTITY," +
				"codDisc INT," +
				"designacao VARCHAR(100)," +
				"data DATE,"+
				"hora VARCHAR(10),"+
				"horaEntrada VARCHAR(10),"+
				"ord INT,"+
				"subj VARCHAR(10)," +
				"CONSTRAINT PK_disc PRIMARY KEY(id,codDisc)"+
				")";
				
			try(Connection con = Conexao.getConnection();
				Statement stm = con.createStatement()){
				stm.executeUpdate(sql);
			}catch(SQLException e){
				throw new RuntimeException("Qualquer erro");
			}
	}
	
	public List<Disciplina> buscar() throws SQLException {
		Connection conm = conexao.getConnection(); 
		List<Disciplina> disciplina = new ArrayList<>();
		String sql = "select * from disciplinas";
		
		PreparedStatement stmt = conm.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
		Disciplina disci = new Disciplina();
			disci.setId(rs.getInt("id"));
			disci.setCodDisc(rs.getString("coddisc"));
			disci.setDesignacao(rs.getString("designacao"));
			disci.setData(rs.getDate("data").toLocalDate());
			disci.setHora(rs.getString("hora"));
			disci.setHoraEntrada(rs.getString("horaentrada"));
			disci.setOrd(rs.getInt("ordem"));
			disci.setSubj(rs.getString("subj"));
			disciplina.add(disci);
		}
		conexao.fechar();
		return disciplina;
	}
	
	public List<String> buscarDisciplinasPorCurso(int cursoID) throws SQLException {
		Connection conm = conexao.getConnection();
    List<String> disciplinas = new ArrayList<>();
    String sql = "SELECT d.coddisc FROM curso_disciplinas cd JOIN disciplinas d ON cd.disciplina_id = d.id WHERE cd.curso_id = ?";

    PreparedStatement stmt = conm.prepareStatement(sql);
    stmt.setInt(1, cursoID);
    ResultSet rs = stmt.executeQuery();
    while (rs.next()) {
    	disciplinas.add(rs.getString("coddisc"));
    }
    conexao.fechar();
    return disciplinas;
	}
	
		// Retorna todos os códigos de disciplinas cadastradas
	public List<String> buscarCodigosExistentes() throws SQLException {
    List<String> codigos = new ArrayList<>();
    String sql = "SELECT coddisc FROM disciplinas ORDER BY coddisc";

    	try {
    		Connection conn = conexao.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            codigos.add(rs.getString("coddisc"));
        }
        conexao.fechar();
    }catch(SQLException e){
    	conexao.fechar();
    	throw new RuntimeException("ERRo com os codigos disciplina " + e.getMessage());
    }

    return codigos;
	}

		// Retorna uma disciplina completa com código, data e hora
		public Disciplina buscarPorCodigo(String codigo) throws SQLException {
    String sql = "SELECT * FROM disciplinas WHERE coddisc = ?";
    try {
    	Connection conn = conexao.getConnection();
      PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, codigo);

        try (ResultSet rs = stmt.executeQuery()){
        	
            if (rs.next()) {
                Disciplina d = new Disciplina();
                d.setCodDisc(rs.getString("coddisc"));
                d.setDesignacao(rs.getString("designacao"));
                d.setData(rs.getDate("data").toLocalDate());
                d.setHora(rs.getString("hora"));
                return d;
            }
        }
        conexao.fechar();
    }catch(SQLException e){
    	conexao.fechar();
    	throw new RuntimeException("Erroo: disciplinas e sua data e hora " + e.getMessage());
    }

    return null;
	}

}
