package view;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;
import java.util.List;
import dao.*;
import model.*;
import controller.*;
import util.*;

public class DistribuicaoFrame extends JFrame implements ActionListener {
    private Menu menu;
    private CandidatoDao candidatoDao = new CandidatoDao();
    private SalaDAO salaEstruturaDAO = new SalaDAO();
    private SalaCandidatoDAO salaCandidatoDAO = new SalaCandidatoDAO();
    private DistribuicaoCandidatos distribuicaoCandidatos = new DistribuicaoCandidatos();
    private final Conexao conm = new Conexao();

    private JPanel mainPanel;
    private CardLayout cardLayout;
    private JPanel candidatoPanel, salaPanel, resultadoPanel, filtroPanel;
    private JTable candidatoTable, salaTable, resultadoTable;
    private DefaultTableModel candidatoModel, salaModel, resultadoModel;
    private JButton btnDistribuir, btnLimpar, btnVoltar, btnFiltrar, btnExcluirAlocacoes;
    private JTextField txtFiltroProvincia;
    private JScrollPane candidatoScroll, salaScroll, resultadoScroll;

    private String[] colunasCandidato = {"ID", "NrCandidato", "Nome", "Provincia", "Opcao1", "Opcao2"};
    private String[] colunasSala = {"ID", "Provincia", "Nome Sala", "Capacidade", "Local"};
    private String[] colunasResultado = {"ID", "Provincia", "NrCandidato", "Nome", "Opcao1", "Opcao2", "Disciplina", "Local", "Sala"};

    public DistribuicaoFrame(Menu menu){
        this.menu = menu;
        setTitle("Distribuição de Candidatos às Salas");
        setSize(1200, 700);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);

        mainPanel = new JPanel();
        cardLayout = new CardLayout();
        mainPanel.setLayout(cardLayout);

        // Painel de Candidatos
        candidatoPanel = new JPanel(new BorderLayout());
        candidatoModel = new DefaultTableModel(colunasCandidato, 0);
        candidatoTable = new JTable(candidatoModel);
        candidatoScroll = new JScrollPane(candidatoTable);
        candidatoPanel.add(new JLabel("Candidatos Disponíveis", JLabel.CENTER), BorderLayout.NORTH);
        candidatoPanel.add(candidatoScroll, BorderLayout.CENTER);

        // Painel de Salas
        salaPanel = new JPanel(new BorderLayout());
        salaModel = new DefaultTableModel(colunasSala, 0);
        salaTable = new JTable(salaModel);
        salaScroll = new JScrollPane(salaTable);
        salaPanel.add(new JLabel("Salas Disponíveis", JLabel.CENTER), BorderLayout.NORTH);
        salaPanel.add(salaScroll, BorderLayout.CENTER);

        // Painel de Resultados
        resultadoPanel = new JPanel(new BorderLayout());
        filtroPanel = new JPanel();
        txtFiltroProvincia = new JTextField(20);
        btnFiltrar = new JButton("Filtrar por Província");
        filtroPanel.add(new JLabel("Província:"));
        filtroPanel.add(txtFiltroProvincia);
        filtroPanel.add(btnFiltrar);
        btnFiltrar.addActionListener(this);

        resultadoModel = new DefaultTableModel(colunasResultado, 0);
        resultadoTable = new JTable(resultadoModel);
        resultadoScroll = new JScrollPane(resultadoTable);
        resultadoPanel.add(filtroPanel, BorderLayout.NORTH);
        resultadoPanel.add(resultadoScroll, BorderLayout.CENTER);

        // Painel de Botões
        JPanel buttonPanel = new JPanel();
        btnDistribuir = new JButton("Distribuir");
        btnLimpar = new JButton("Limpar");
        btnExcluirAlocacoes = new JButton("Excluir Alocacoes");
        btnVoltar = new JButton("Voltar");
        buttonPanel.add(btnDistribuir);
        buttonPanel.add(btnLimpar);
        buttonPanel.add(btnExcluirAlocacoes);
        buttonPanel.add(btnVoltar);

        btnDistribuir.addActionListener(this);
        btnLimpar.addActionListener(this);
        btnExcluirAlocacoes.addActionListener(this);
        btnVoltar.addActionListener(this);

        // Adicionar painéis ao CardLayout
        mainPanel.add(candidatoPanel, "Candidatos");
        mainPanel.add(salaPanel, "Salas");
        mainPanel.add(resultadoPanel, "Resultados");
        add(mainPanel, BorderLayout.CENTER);
        add(buttonPanel, BorderLayout.SOUTH);

        carregarDados();
        cardLayout.show(mainPanel, "Candidatos");
        setVisible(true);
    }

    private void carregarDados() {
        atualizarTabelaCandidatos();
        atualizarTabelaSalas();
        atualizarTabelaResultados();
    }

    private void atualizarTabelaCandidatos() {
        candidatoModel.setRowCount(0);
        try {
            List<GerenciarCandidato> candidatos = candidatoDao.buscar();
            for (GerenciarCandidato candidato : candidatos) {
                candidatoModel.addRow(new Object[]{
                        candidato.getId(),
                        candidato.getNrCandidato(),
                        candidato.getNome(),
                        candidato.getProv_Nasc(),
                        candidato.getOpcao1(),
                        candidato.getOpcao2()
                });
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Erro ao carregar candidatos: " + e.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void atualizarTabelaSalas() {
        salaModel.setRowCount(0);
        try{
            List<SalaEstrutura> salas = salaEstruturaDAO.buscarTodas();
            for (SalaEstrutura sala : salas) {
                salaModel.addRow(new Object[]{
                        sala.getSalaID(),
                        sala.getProvincia(),
                        sala.getNrSala(),
                        sala.getCapacidade(),
                        sala.getLocal()
                });
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Erro ao carregar saloide: " + e.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void atualizarTabelaResultados() {
        resultadoModel.setRowCount(0);
        try {
            List<Sala> alocacoes;
            String provincia = txtFiltroProvincia.getText().trim();
            if (provincia.isEmpty()) {
                alocacoes = salaCandidatoDAO.buscar();
            } else {
                alocacoes = salaCandidatoDAO.buscarPorProvincia(provincia);
            }
            for (Sala alocacao : alocacoes) {
                resultadoModel.addRow(new Object[]{
                        alocacao.getId(),
                        alocacao.getProvincia(),
                        alocacao.getNrCandidato(),
                        alocacao.getNome(),
                        alocacao.getOpcao1(),
                        alocacao.getOpcao2(),
                        alocacao.getDisciplina(),
                        alocacao.getLocal(),
                        alocacao.getSala()
                });
            }
            cardLayout.show(mainPanel, "Resultados");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Erro ao carregar resultados: " + e.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void distribuirCandidatos() {
        try {
            List<GerenciarCandidato> candidatos = candidatoDao.buscar();
            List<SalaEstrutura> salas = salaEstruturaDAO.buscarTodas();
            if (candidatos.isEmpty()) {
                JOptionPane.showMessageDialog(this, "Nenhum candidato disponível!", "Erro", JOptionPane.ERROR_MESSAGE);
                return;
            }
            if (salas.isEmpty()) {
                JOptionPane.showMessageDialog(this, "Nenhuma sala disponível!", "Erro", JOptionPane.ERROR_MESSAGE);
                return;
            }

            distribuicaoCandidatos.distribuir(candidatos);
            txtFiltroProvincia.setText(""); // Limpar filtro após nova distribuição
            atualizarTabelaResultados();
            cardLayout.show(mainPanel, "Resultados");
            JOptionPane.showMessageDialog(this, "Distribuição concluída com sucesso!", "Sucesso", JOptionPane.INFORMATION_MESSAGE);
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Erro ao distribuir candidatos: " + e.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
        } catch (RuntimeException e) {
            JOptionPane.showMessageDialog(this, "Erro qualquer de processamento: " + e.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void limparTabelas() {
        candidatoModel.setRowCount(0);
        salaModel.setRowCount(0);
        resultadoModel.setRowCount(0);
        txtFiltroProvincia.setText("");
        carregarDados();
        cardLayout.show(mainPanel, "Candidatos");
    }
    
    public void excluirAlocacoes(){
    	try {
    		int confirma = JOptionPane.showConfirmDialog(this,"Deseja excluir todas alocacoes de candidatos?", "Confirmar Exclusao", JOptionPane.YES_NO_OPTION);
    		if(confirma == JOptionPane.YES_OPTION){
    			salaCandidatoDAO.excluirTudo();
    			atualizarTabelaResultados();
    			JOptionPane.showMessageDialog(this,"Todas alocacoes foram exclidas!","SUCESSO", JOptionPane.INFORMATION_MESSAGE);
    		}
    	}catch(Exception e){
    		JOptionPane.showMessageDialog(this, "Erro ao excluir alocações: " + e.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
    	}
    }


    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == btnDistribuir) {
            distribuirCandidatos();
        } else if (e.getSource() == btnLimpar) {
            limparTabelas();
        }else if(e.getSource() == btnExcluirAlocacoes){
        		excluirAlocacoes();
        } else if (e.getSource() == btnVoltar) {
            dispose();
            menu.setVisible(true);
        } else if (e.getSource() == btnFiltrar) {
            atualizarTabelaResultados();
        }
    }
}
