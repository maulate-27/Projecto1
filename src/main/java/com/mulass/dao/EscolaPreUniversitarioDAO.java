package dao;

import java.sql.*;
import java.util.*;
import model.*;
import util.Conexao;

public class EscolaPreUniversitarioDAO {
    private final Conexao conexao = new Conexao();

    public List<EscolaPreUniversitario> buscarPorProvincia(int provinciaId){
        List<EscolaPreUniversitario> escolas = new ArrayList<>();
        String sql = "SELECT * FROM escolapreu WHERE provid = ?";

        try {
        	Connection conn = conexao.getConnection();
	      	PreparedStatement stmt = conn.prepareStatement(sql);
          stmt.setInt(1, provinciaId);
          try (ResultSet rs = stmt.executeQuery()) {
          	while (rs.next()) {
            	EscolaPreUniversitario escola = new EscolaPreUniversitario();
              escola.setCodEsc(rs.getInt("codesc"));
              escola.setDesignacao(rs.getString("designacao"));
              escola.setProvinciaId(rs.getInt("provid"));
              escolas.add(escola);
           	}
        	}
        	conexao.fechar();
        }catch(SQLException e){
        	conexao.fechar();
        	throw new RuntimeException("Algum eroo sobre escola " + e.getMessage()); 
        }

        return escolas;
    }
}

