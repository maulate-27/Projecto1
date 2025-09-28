package com.mulass;
import view.*;

class Admisao{
	public static void main(String[] ar){
		try{
			Thread.sleep(2000);
			new Login();
		}catch(Exception e){
			throw new RuntimeException("Erro ao processar");
		}
	}
}
