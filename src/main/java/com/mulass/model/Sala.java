package model;

import java.time.*;

public class Sala {
    private int id; 
    private String provincia;
    private int nrCandidato;
    private String nome;
    private String opcao1;
    private String opcao2;
    private String disciplina;
    private String local;
    private String sala;
    private LocalDate data; 

  
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public int getNrCandidato() {
        return nrCandidato;
    }

    public void setNrCandidato(int nrCandidato) {
        this.nrCandidato = nrCandidato;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getOpcao1() {
        return opcao1;
    }

    public void setOpcao1(String opcao1) {
        this.opcao1 = opcao1;
    }

    public String getOpcao2() {
        return opcao2;
    }

    public void setOpcao2(String opcao2) {
        this.opcao2 = opcao2;
    }
    
    public String getDisciplina(){
    	return disciplina;
    }
    
    public void setDisciplina(String disciplina){
    	this.disciplina = disciplina;
    }
    
    public String getLocal(){
    	return local;
    }
    
    public void setLocal(String Local){
    	this.local = local;
    }

    public String getSala() {
        return sala;
    }

    public void setSala(String sala) {
        this.sala = sala;
    }
    
    public void setData(LocalDate data){
    	this.data = data;
    }
    
    public LocalDate getData(){
    	return data;
    }
}
