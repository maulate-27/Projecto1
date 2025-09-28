package util;

import java.sql.*;
import java.util.*;
import java.io.*;


public class Conexao {
	private static final String url ="jdbc:postgresql://localhost:5432/sigexames";
	private static final String user = "maulate";
	private static final String password = "maulass@27";
	
	private static Connection conex;
	
	public static Connection getConnection(){
		if(conex == null){
			try {
				
				Class.forName("org.postgresql.Driver");
				conex = DriverManager.getConnection(url,user,password);
				
			}catch(Exception e){
				throw new RuntimeException("Erro ao tentar conectar a base de dados");
				//String texto = "Erro ao tentar conectar!!";
			}
		}
		return conex;
	}
	
	public static void fechar(){
		if(conex!=null){
			try{
				conex.close();
				conex = null;
			}catch (SQLException e){
				System.err.println("Erro ao fechar a base de dados");
			}
		}
	}
}
