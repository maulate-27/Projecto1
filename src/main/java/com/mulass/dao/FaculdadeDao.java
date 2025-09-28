package dao;

import model.*;
import java.util.*;
import util.*;
import java.sql.*;

public class FaculdadeDao{
	public final Conexao conexao = new Conexao();

	public void criarTabela() throws SQLException {
	Connection conex = conexao.getConnection();

		String sql = "CREATE TABLE IF NOT EXISTS faculdade("+
									"cod serial," +
									"designacao VARCHAR(100)," +
									"abrev VARCHAR(100),"+
									"CONSTRAINT pk_facul PRIMARY KEY(cod)"+
									")";
	
					Statement stmt = conex.createStatement();
				stmt.executeUpdate(sql);
				conexao.fechar();
		/*}catch(SQLException e){
			conm.fechar();
			throw new RuntimeException("Houve qualquer erro");
		}*/
	}
	
	public List<Faculdade> buscar() throws SQLException {
		Connection conm = conexao.getConnection();
		String sql = "select * from faculdade";
		List<Faculdade> facul = new ArrayList<>();
		
		PreparedStatement stmt = conm.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
			Faculdade fac = new Faculdade();
			fac.setCod(rs.getInt("cod"));
			fac.setDesignacao(rs.getString("designacao"));
			fac.setAbrev(rs.getString("abrev"));
			facul.add(fac);
		}
		conexao.fechar();
		return facul;
	}
}
