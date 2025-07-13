package model;

import java.util.*;
import java.time.*;

public class  Disciplina {
	private int id;
	private String codDisc;
	private String designacao;
	private LocalDate data;
	private String hora;
	private String horaEntrada;
	private int ord;
	private String subj;
	
	public Disciplina(int id, String codDisc, String designacao, LocalDate data, String hora, String horaEntrada, int ord, String subj){
	
		this.id = id;
		this.codDisc = codDisc;
		this.designacao = designacao;
		this.data = data;
		this.hora = hora;
		this.horaEntrada = horaEntrada;
		this.ord = ord;
		this.subj = subj;
	}
	
	public Disciplina(){}
	
	public void setId(int id){
		this.id = id;
	}
	
	public int getId(){
		return id;
	}
	
	public void setCodDisc(String codDisc){
		this.codDisc = codDisc;
	}
	
	public String getCodDisc(){
		return codDisc;
	}
	
	public void setDesignacao(String designacao){
		this.designacao = designacao;
	}
	
	public String getDesignacao(){
		return designacao;
	}
	
	public void setData(LocalDate data){
		this.data = data;
	}
	
	public LocalDate getData(){
		return data;
	}
	
	public void setHora(String hora){
		this.hora = hora;
	}
	
	public String getHora(){
		return hora;
	}
	
	public void setHoraEntrada(String horaEntrada){
		this.horaEntrada = horaEntrada;
	}
	
	public String getHoraEntrada(){
		return horaEntrada;
	}
	
	public void setOrd(int ord){
		this.ord = ord;
	}
	
	public int getOrd(){
		return ord;
	}
	
	public void setSubj(String subj){
		this.subj = subj;
	}
	
	public String getSubj(){
		return subj;
	}
}
