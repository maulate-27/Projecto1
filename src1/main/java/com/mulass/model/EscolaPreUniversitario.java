package model;

public class EscolaPreUniversitario {
    private int codesc;
    private String designacao;
    private int provinciaId;

    public int getCodEsc() {
        return codesc;
    }

    public void setCodEsc(int codesc) {
        this.codesc = codesc;
    }

    public String getDesignacao() {
        return designacao;
    }

    public void setDesignacao(String designacao) {
        this.designacao = designacao;
    }

    public int getProvinciaId() {
        return provinciaId;
    }

    public void setProvinciaId(int provinciaId) {
        this.provinciaId = provinciaId;
    }
}

