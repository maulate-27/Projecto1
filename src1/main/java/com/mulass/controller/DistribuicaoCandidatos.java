package controller;

import java.util.*;
import java.util.List;
import model.*;
import dao.*;
import util.*;
import java.sql.*;
import javax.swing.*;
import java.awt.*;

public class DistribuicaoCandidatos {
    private SalaDAO salaEstruturaDAO = new SalaDAO();
    private SalaCandidatoDAO salaCandidatoDAO = new SalaCandidatoDAO();
    private LocalidadeDAO localidadeDAO = new LocalidadeDAO();
    private DisciplinaDao disciplinaDAO = new DisciplinaDao();
    private EscolaPreUniversitarioDAO escolaDAO = new EscolaPreUniversitarioDAO();
    private CandidatoDao candidatoDao = new CandidatoDao();

    public void distribuirPorSelecao(String provinciaSelecionada, String disciplinaSelecionada) throws SQLException {
    System.out.println("Iniciando distribuição por seleção. Província: " + provinciaSelecionada + ", Disciplina: " + disciplinaSelecionada);
    
    int provinciaId = localidadeDAO.buscarIdPorNome(provinciaSelecionada);
    if (provinciaId == -1) {
        System.out.println("ID da província não encontrado: " + provinciaSelecionada);
        return;
    }

    List<GerenciarCandidato> candidatos = candidatoDao.buscarPorProvincia(provinciaSelecionada);
    if (candidatos.isEmpty()) {
        JOptionPane.showMessageDialog(null,"Nenhum candidato encontrado para a província selecionada.", "Informacao", JOptionPane.INFORMATION_MESSAGE);
        return;
    }

    Disciplina disciplina = disciplinaDAO.buscarPorCodigo(disciplinaSelecionada);
    if (disciplina == null) {
        System.out.println("Disciplina não encontrada: " + disciplinaSelecionada);
        return;
    }

    List<EscolaPreUniversitario> escolas = escolaDAO.buscarPorProvincia(provinciaId);
    if (escolas.isEmpty()) {
        JOptionPane.showMessageDialog(null,"Desculpe ainda nao cadastrei a sala nessa Provincia", "Informacao", JOptionPane.INFORMATION_MESSAGE);
        return;
    }

    for (GerenciarCandidato candidato : candidatos) {
        List<String> disciplinasCurso = disciplinaDAO.buscarDisciplinasPorCurso(candidato.getOpcao1());
        if (!disciplinasCurso.contains(disciplinaSelecionada)) {
            System.out.println("Candidato " + candidato.getNome() + " não realiza a disciplina " + disciplinaSelecionada);
            continue;
        }

        if (salaCandidatoDAO.jaAlocado(candidato.getNrCandidato(), disciplinaSelecionada)) {
            System.out.println("Candidato " + candidato.getNome() + " já está alocado na disciplina " + disciplinaSelecionada);
            continue;
        }

        boolean alocado = false;
        for (EscolaPreUniversitario escola : escolas) {
            List<SalaEstrutura> salas = salaEstruturaDAO.buscarPorEscola(escola.getDesignacao());
            for (SalaEstrutura sala : salas) {
            	//verifica as saalas ocupadas 
                int ocupados = salaEstruturaDAO.contarCandidatosNaSalaPorDataEHora(sala.getNrSala(), disciplina.getData(), disciplina.getHora());
                if (ocupados < sala.getCapacidade()) {
                    Sala alocacao = new Sala();
                    alocacao.setNrCandidato(candidato.getNrCandidato());
                    alocacao.setNome(candidato.getNome());
                    alocacao.setOpcao1(String.valueOf(candidato.getOpcao1()));
                    alocacao.setOpcao2(String.valueOf(candidato.getOpcao2()));
                    alocacao.setDisciplina(disciplina.getCodDisc());
                    alocacao.setSala(sala.getNrSala());
                    alocacao.setLocal(sala.getLocal());
                    alocacao.setProvincia(provinciaSelecionada);
                    alocacao.setData(disciplina.getData());
											
                    try {
                        salaCandidatoDAO.salvar(alocacao,sala);
                        System.out.println("Alocado: " + candidato.getNome() + " → " + disciplinaSelecionada + " na sala " + sala.getNrSala() + " Data: " + disciplina.getData() + " Local ==> " + sala.getLocal());
                        alocado = true;
                        break;
                    } catch (Exception e) {
                        System.err.println("Erro ao alocar candidato: " + e.getMessage());
                    }
                }
            }
            if (alocado) break;
        }

        if (!alocado) {
            System.out.println("Não foi possível alocar " + candidato.getNome() + " na disciplina " + disciplinaSelecionada);
        }
    }

   JOptionPane.showMessageDialog(null,"Destribuicao finalizada com sucesso: Clique em TabelasBasicas ---> sala_candidato para visualizar", "Informacao", JOptionPane.INFORMATION_MESSAGE);
	}

	// metodo usar na classe DistribuicaoFame.java
	public void mostrarDialogoDistribuicao() {
    try {
        List<String> provincias = candidatoDao.buscarProvinciasDistintas();
        List<String> disciplinas = disciplinaDAO.buscarCodigosExistentes();

        JComboBox<String> comboProvincia = new JComboBox<>(provincias.toArray(new String[0]));
        JComboBox<String> comboDisciplina = new JComboBox<>(disciplinas.toArray(new String[0]));

        JPanel panel = new JPanel();
        panel.setLayout(new GridLayout(2, 2));
        panel.add(new JLabel("Província:"));
        panel.add(comboProvincia);
        panel.add(new JLabel("Disciplina:"));
        panel.add(comboDisciplina);

        int result = JOptionPane.showConfirmDialog(null, panel, "Distribuição Personalizada", JOptionPane.OK_CANCEL_OPTION);
        if (result == JOptionPane.OK_OPTION) {
            String provinciaSelecionada = (String) comboProvincia.getSelectedItem();
            String disciplinaSelecionada = (String) comboDisciplina.getSelectedItem();
            distribuirPorSelecao(provinciaSelecionada, disciplinaSelecionada);
        }
    } catch (Exception e) {
        JOptionPane.showMessageDialog(null, "Erro ao carregar opções: " + e.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
    }
	}
}
