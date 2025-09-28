package dao;

import model.*;
import util.*;
import java.sql.*;
import java.util.*;

public class CursoDao {
    
    public final Conexao conexao = new Conexao();
    
   
    
    public List<String> buscarExtensoes() throws SQLException {
    		Connection conm = conexao.getConnection();
        List<String> extensoes = new ArrayList<>();
        String sql = "SELECT designacao FROM Delegacao ORDER BY designacao";
        
        
        			PreparedStatement stmt = conm.prepareStatement(sql);
             	ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                extensoes.add(rs.getString("designacao"));
            }
            
            //stmt.close();
            //rs.close();
        /*}catch(SQLException e){
        	throw new RuntimeException("Algum erro ao buscar");
        }*/
        conexao.fechar();
        return extensoes;
        
    }
    
    public List<String> buscarCursos() throws SQLException {
    		Connection conm = conexao.getConnection();
        List<String> cursos = new ArrayList<>();
        String sql = "SELECT descricao FROM Curso";
        
        
        			PreparedStatement stmt = conm.prepareStatement(sql);
             	ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                cursos.add(rs.getString("descricao"));
            }
            
            //stmt.close();
            //rs.close();
        /*}catch(SQLException e){
        		throw new RuntimeException("Algum erro ao buscar");
        }*/
         conexao.fechar();
        return cursos;
       
    }
    
    public List<String> buscarCursos(String a) throws SQLException {
    		Connection conm = conexao.getConnection();
        List<String> cursos = new ArrayList<>();
        String sql = "SELECT * FROM Curso";
        
        
        			PreparedStatement stmt = conm.prepareStatement(sql);
	            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                cursos.add(rs.getInt("seq") +
                 "," + rs.getString("codigo") + 
                 "," + rs.getString("ativo") + 
                 "," + rs.getString("descricao") + 
                 "," + rs.getInt("regime_id") + 
                 "," + rs.getInt("faculcod") + 
                 "," + rs.getInt("codgr"));
            }
            
            //stmt.close();
            //rs.close();
        /*}catch(SQLException e){
        		throw new RuntimeException("Algum erro ao buscar");
        }*/
        conexao.fechar();
        return cursos;
        
    }
    
    public List<String> buscarRegimes() throws SQLException {
    		Connection conm = conexao.getConnection();
        List<String> regimes = new ArrayList<>();
        String sql = "SELECT nome FROM Regime";
        
        
        			PreparedStatement stmt = conm.prepareStatement(sql);
             	ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                regimes.add(rs.getString("nome"));
            }
            
            //stmt.close();
            //rs.close();
        /*}catch(SQLException e){
        	throw new RuntimeException("Algum erro ao buscar");
        }*/
        conexao.fechar();
        return regimes;
        
    }
    
    public List<String> buscarProvincia() throws SQLException {
	    Connection conm = conexao.getConnection();
    	List<String> provincia = new ArrayList<>();
    	String sql = "SELECT designacao FROM localidade order  by designacao asc";
    	
    	
    			PreparedStatement stmt = conm.prepareStatement(sql);
    			ResultSet rs = stmt.executeQuery();
    					
    		while(rs.next()){
    			provincia.add(rs.getString("designacao"));
    		}
    		
    		//stmt.close();
        //rs.close();
    	/*}catch(SQLException e){
    		throw new RuntimeException("Somethings went wrong");
    	}*/
    	conexao.fechar();
    	return provincia;
    	
    }
    
    public List<String> buscarEscola() throws SQLException {
    	Connection conm = conexao.getConnection();
    	List<String> escola = new ArrayList<>();
    	String sql = "SELECT designacao FROM escolapreu order by designacao asc";
    	
    	
    			PreparedStatement stmt = conm.prepareStatement(sql);
    			ResultSet rs = stmt.executeQuery();
    			while(rs.next()){
    				escola.add(rs.getString("designacao"));
    			}
    			
    			//stmt.close();
          //rs.close();
    		/*}catch(SQLException e){
    			throw new RuntimeException("Something was bad");
    		}*/
    		conexao.fechar();	
    		return escola;   
    }
}
