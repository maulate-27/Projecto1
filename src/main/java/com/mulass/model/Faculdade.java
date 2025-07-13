package model;

public class Faculdade {

	private int cod;
	private String designacao;
	private String abrev;
	
	public Faculdade(int cod, String designacao, String abrev){
		this.cod = cod;
		this.designacao = designacao;
		this.abrev = abrev;
	}
	
	public Faculdade(){}
	
	public void setCod(int cod){
		this.cod = cod;
	}
	
	public int getCod(){
		return cod;
	}
	
	public void setDesignacao(String designacao){
		this.designacao = designacao;
	}
	
	public String getDesignacao(){
		return designacao;
	}
	
	public void setAbrev(String abrev){
		this.abrev = abrev;
	}
	
	public String getAbrev(){
		return abrev;	
	}	
}
