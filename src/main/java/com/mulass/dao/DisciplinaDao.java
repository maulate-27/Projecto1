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
			disci.setData(rs.getDate("data"));
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
}
