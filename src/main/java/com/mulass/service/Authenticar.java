package service;

import java.sql.*;
import util.*;

public class Authenticar {
	public static boolean login(String user, String password){
		try(Connection conx = Conexao.getConnection(user,password)){
			return true;
		}catch(Exception e){
			return false;
		}
	}
}
