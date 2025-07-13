package dao;

import java.sql.*;
import java.util.*;
import util.Conexao;
import model.*;

public class LocalidadeDAO {
    private final Conexao conexao = new Conexao();

    public Map<String, Integer> buscarDesignacaoParaLocalID() {
        Map<String, Integer> designacaoParaLocalID = new HashMap<>();
        String sql = "SELECT provid, designacao FROM localidade";
        try {
        
        		Connection conn = conexao.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                int localID = rs.getInt("provid");
                String designacao = rs.getString("designacao");
                if (designacao != null) {
                    designacaoParaLocalID.put(designacao.trim().toLowerCase(), localID);
                    System.out.println("Localidade carregada: localID=" + localID + ", designacao=" + designacao);
                }
            }
        conexao.fechar();
        } catch (SQLException e) {
            conexao.fechar();
            throw new RuntimeException("Erro blablablal: " + e.getMessage(), e);
        }
        return designacaoParaLocalID;
    }
    
    
    public List<Localidade> buscar() throws SQLException {
    	Connection conm = conexao.getConnection();
    	List<Localidade> locale = new ArrayList<>();
    	String sql = "select * from localidade";
    	
    	PreparedStatement stmt = conm.prepareStatement(sql);
    	ResultSet rs = stmt.executeQuery();
    	while(rs.next()){
    		Localidade local = new Localidade();
    		local.setId(rs.getInt("provid"));
    		local.setDesignacao(rs.getString("designacao"));
    		locale.add(local);
    	}
    	conexao.fechar();
    	return locale;
    }
}
