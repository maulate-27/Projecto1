package dao;

import util.*;
import java.util.*;
import model.*;
import java.sql.*;

public class DelegacaoDao {
	private final Conexao conexao = new Conexao();
	public void criarTabela(){
		String sql = "CREATE TABLE IF NOT EXISTS delegacao(" +
		"delegId INT GENERATED ALWAYS AS IDENTITY," +
		"designacao VARCHAR(100) NOT NULL ," +
		"abrev VARCHAR(100)," + 
		"CONSTRAINT pk_delegacao PRIMARY KEY(delegId)" +
		")";
		
		try(Connection conv = Conexao.getConnection(); 
					Statement stmt = conv.createStatement()) {
							stmt.executeUpdate(sql);
		}catch(SQLException e){
			throw new RuntimeException("Qualquer erro",e);
		}
	}
	
	public List<Delegacao> buscar() throws SQLException {
		Connection conm = conexao.getConnection();
		List<Delegacao> delega = new ArrayList<>();
		String sql = "select * from delegacao";
		
		PreparedStatement stmt = conm.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
			Delegacao deleg = new Delegacao();
			deleg.setDelegId(rs.getInt("delegid"));
			deleg.setDesignacao(rs.getString("designacao"));
			deleg.setAbrev(rs.getString("abrev"));
			delega.add(deleg);
		}
		conexao.fechar();
		return delega;
	}
}
