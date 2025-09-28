package dao;

import java.sql.*;
import java.util.*;
import util.*;
import model.*;

public class GrupoDAO {
	private final Conexao conexao = new Conexao();
	
	public List<Grupo> buscar() throws SQLException {
		Connection conm = conexao.getConnection();
		List<Grupo> gr = new ArrayList<>();
		String sql = "select * from grupos";
		
		PreparedStatement stmt = conm.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
			Grupo grup = new Grupo();
			grup.setGrupo(rs.getInt("gr"));
			grup.setCodGrupo(rs.getInt("codgr"));
			grup.setDesignacao(rs.getString("designacao"));
			gr.add(grup);
		}
		conexao.fechar();
		return gr;
	}
}
