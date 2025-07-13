package model;

import java.util.*;
import javax.swing.*;
import java.io.*;
import java.nio.*;
import java.nio.file.*;

public class Ficheiro extends JFrame{
	private String file = "Candidatos.txt";

	public void escrever(String dados){
		try{
			FileWriter frw = new FileWriter(file,true);
			frw.write(dados);
			frw.close();
			JOptionPane.showMessageDialog(null,"Dados Cadastrados com sucesso","Informacao", JOptionPane.INFORMATION_MESSAGE);
		}catch(IOException e){
			JOptionPane.showMessageDialog(null,"Erro ao cadastrar estudante ","Erro", JOptionPane.ERROR_MESSAGE);
		}
	}
	
	public ArrayList<String> ler(){
		ArrayList<String> conteudo = new ArrayList<>();
		try{
			List<String> candidato = Files.readAllLines(Paths.get(file));
			conteudo.addAll(candidato);
		}catch(IOException e){
			JOptionPane.showMessageDialog(null,"Erro ao tentar ler arquivo","Errro!", JOptionPane.ERROR_MESSAGE);
		}
		return conteudo;
	}
}
