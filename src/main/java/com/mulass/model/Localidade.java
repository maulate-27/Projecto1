package model;


public class Localidade {
	private int id;
	private String designacao;
	
	public void setId(int id){
		this.id = id;
	}	
	
	public int getId(){
		return id;
	}
	
	public void setDesignacao(String designacao){
		this.designacao = designacao;
	}
	
	public String getDesignacao(){
		return designacao;
	}
}
