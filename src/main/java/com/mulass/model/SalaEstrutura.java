package model;

public class SalaEstrutura {
    private int SalaID;
    private String Local;
    private String NrSala;
    private int Provincia;
    private int prioridade;
    private int Ordem;
    private int capacidade;
    private int NrVigilante;
    private boolean EmUso;

    // Getters and Setters
    public int getSalaID() {
        return SalaID;
    }

    public void setSalaID(int SalaID) {
        this.SalaID = SalaID;
    }

    public String getLocal() {
        return Local;
    }

    public void setLocal(String Local) {
        this.Local = Local;
    }

    public String getNrSala() {
        return NrSala;
    }

    public void setNrSala(String NrSala) {
        this.NrSala = NrSala;
    }

    public int getProvincia() {
        return Provincia;
    }

    public void setProvincia(int Provincia) {
        this.Provincia = Provincia;
    }

    public int getPrioridade() {
        return prioridade;
    }

    public void setPrioridade(int prioridade) {
        this.prioridade = prioridade;
    }

    public int getOrdem() {
        return Ordem;
    }

    public void setOrdem(int Ordem) {
        this.Ordem = Ordem;
    }

    public int getCapacidade() {
        return capacidade;
    }

    public void setCapacidade(int capacidade) {
        this.capacidade = capacidade;
    }

    public int getNrVigilante() {
        return NrVigilante;
    }

    public void setNrVigilante(int NrVigilante) {
        this.NrVigilante = NrVigilante;
    }

    public boolean isEmUso() {
        return EmUso;
    }

    public void setEmUso(boolean EmUso) {
        this.EmUso = EmUso;
    }
}
