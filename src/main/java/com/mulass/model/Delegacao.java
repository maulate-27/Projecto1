package model;

public class Delegacao {

	private int delegId;
	private String designacao;
	private String abrev;
	
	public Delegacao(String designacao, String abrev){
		this.designacao = designacao;
		this.abrev = abrev;
	}
	
	public Delegacao(){}
	
	public void setDelegId(int delegId){
		this.delegId = delegId;
	} 
	
	public int getDelegId(){
		return delegId;
	}
	
	public void setAbrev(String abrev){
		this.abrev = abrev;
	}
	
	public String getAbrev(){
		return abrev;
	}
	
	public void setDesignacao(String designacao){
		this.designacao = designacao;
	}
	
	public String getDesignacao(){
		return designacao;
	}
} 
