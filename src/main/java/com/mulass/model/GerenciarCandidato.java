package model;

import java.io.*;
import java.util.Date;
import java.text.*;

public  class GerenciarCandidato {

		private int id;
    private String nome;
    private String BI;
    private String apelido;
    private int nrCandidato;
    private String genero;
    private String pais;
    private String prov_Nasc;
    private String prov_Resi;
    private String nacionalidade;
    private String estCivil;
    private Date data_nasc;
    private String regime;
    private String delegacao;
    private String escoPU;
    private int opcao1;
    private int opcao2;
    private String tipoEst;
    
    public GerenciarCandidato(){}
    public GerenciarCandidato(
    	int id, String nome, String apelido, int nrCandidato, String genero, String pais, String prov_Nasc, String prov_Resi, String nacionalidade, String estCivil, Date data_nasc, String regime, String delegacao, String escoPU, int opcao1, int opcao2, String tipoEst
    ){
    	this.id = id;
    	this.nome = nome;
    	this.apelido = apelido;
    	this.nrCandidato = nrCandidato;
    	this.genero = genero;
    	this.pais = pais;
    	this.prov_Nasc = prov_Nasc;
    	this.prov_Resi = prov_Resi;
    	this.nacionalidade = nacionalidade;
    	this.estCivil = estCivil;
    	this.data_nasc = data_nasc;
    	this.regime = regime;
    	this.delegacao = delegacao;
    	this.escoPU = escoPU;
    	this.opcao1 = opcao1;
    	this.opcao2 = opcao2;
    	this.tipoEst = tipoEst;
    	
    }
    
    public void setId(int id){
    	this.id = id;
    }
    
    public int getId(){
    	return id;
    }
    
    public void setNome(String nome){
    	this.nome = nome;
    }
    
    public String getNome(){
    	return nome;
    }
    
    public void setApelido(String apelido){
    	this.apelido = apelido;
    }
    
    public String getApelido(){
    	return apelido;
    }
    
    public void setBI(String BI){
    
    	if(BI == null || BI.length() != 13){
    		throw new IllegalArgumentException("O codigo do BI deve ter exatamente 9 caracteres.");
    	}
    	
    	for(int i=0; i<12; i++){
    		if(!Character.isDigit(BI.charAt(i))){
        	throw new IllegalArgumentException("Os primeiros 12 caracteres devem ser numeros.");
    		}
    	}
    			
    	if(!Character.isLetter(BI.charAt(12))){
    		throw new IllegalArgumentException("O ultimo caractere deve ser uma letra.");
    	}
    	
    	this.BI = BI;	
  	}
    
    public String getBI(){
    	return BI;
    }
    
    public void setNrCandidato(int nrCandidato){
    	this.nrCandidato = nrCandidato;
    }
    
    public int getNrCandidato(){
    	return nrCandidato;
    }
    
    public void setGenero(String genero){
    	this.genero = genero;
    }
    
    public String getGenero(){
    	return genero;
    }
    
    public void setPais(String pais){
    	this.pais = pais;
    }
    
    public String getPais(){
    	return pais;
    }
    
    public void setProv_Nasc(String prov_Nasc){
    	this.prov_Nasc = prov_Nasc;
    }
    
    public String getProv_Nasc(){
    	return prov_Nasc;
    }
    
    public void setProv_Resi(String prov_Resi){
    	this.prov_Resi = prov_Resi;
    }
    
    public String getProv_Resi(){
    	return prov_Resi;
    }
    
    public void setNacionalidade(String nacionalidade){
    	this.nacionalidade = nacionalidade;
    }
    
    public String getNacionalidade(){
    	return nacionalidade;
    }
    
    public void setEstCivil(String estCivil){
    	this.estCivil = estCivil;
    }
    
    public String getEstCivil(){
    	return estCivil;
    }
    
    public void setData_nasc(Date data_nasc){
    	
    	try{
    		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    		Date data = sdf.parse("01/06/2008");
    		if(data_nasc.after(data)){
    			throw new IllegalArgumentException("Nao adimitimos criancas");
    		}
    		
    		this.data_nasc = data_nasc;
    	}catch(ParseException e){
    		throw new RuntimeException("Erro de conversao de data");
    	}
    }
    
    public Date getData_nasc(){
    	return data_nasc;
    }
    
    public void setRegime(String regime){
    	this.regime = regime;
    }
    
    public String getRegime(){
    	return regime;
    }
    
    public void setDelegacao(String delegacao){
    	this.delegacao = delegacao;
    }
    
    public String getDelegacao(){
    	return delegacao;
    }
    
    public void setEscoPU(String escoPU){
    	this.escoPU = escoPU;
    }
    
    public String getEscoPU(){
    	return escoPU;
    }
    
    public void setOpcao1(int opcao1){
    	this.opcao1 = opcao1;
    }
    
    public int getOpcao1(){
    	return opcao1;
    }
    
    public void setOpcao2(int opcao2){
    	this.opcao2 = opcao2;
    }
    
    public int getOpcao2(){
    	return opcao2;
    }
    
    public void setTipoEst(String tipoEst){
    	this.tipoEst = tipoEst;
    }
    
    public String getTipoEst(){
    	return tipoEst;
    }
       
    public String  Dados(){
    	return nome + " " + apelido + " " + opcao1;
    }
}
