package view;

import java.awt.*;
import java.sql.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.util.ArrayList;
import java.util.List;
import model.*;
import util.*;
import Jogo.*;
import dao.*;
import controller.*;

public class Menu extends JFrame implements ActionListener {
	
	private JMenuBar menubar = new JMenuBar();
	private JPanel pane;
	private JPanel pane2;
	private CardLayout cardLayout;
	public final Conexao conm = new Conexao();
	
	private DefaultTableModel tablemodel;
	private JTable tabela;
	
	private JTextArea area;
	private JScrollPane scroll;
	private CadastroEst cad;
	private DisciplinaDao discip = new DisciplinaDao();
	private DelegacaoDao delegacao = new DelegacaoDao();
	private FaculdadeDao faculdade = new FaculdadeDao();
	private GrupoDAO grupo = new GrupoDAO();
	private LocalidadeDAO locale = new LocalidadeDAO();
	private CursoDao curso = new CursoDao();
	private SalaDAO salas = new SalaDAO();
	private SalaCandidatoDAO salaCandidatoDAO = new SalaCandidatoDAO();
	private CandidatoDao dt = new CandidatoDao();
	private DistribuicaoCandidatos distribuicaoCandidatos = new DistribuicaoCandidatos();
	private Maulate jogo;
	private JButton bt;
	private Login lg;
	private RelatorioPDF pdf = new RelatorioPDF();
	private RelatorioEstatisticasPDF relatorioEstatisticas = new RelatorioEstatisticasPDF();
	private JMenuItem[] itens = new JMenuItem[100];
	private JMenu[] menu = new JMenu[100];
	private String exameR = "RelaExame";
	private String[] word = {"Candidato", "Relatorios", "Sobre", "Sair", "Cadastrar", "Visualizar", "Buscar", "Jogo", "TabelasBasicas", "DistribuirCandidatos"};
	private String[] colunas = {"ID", "NrCandidato", "Nome", "Apelido", "BI", "Genero", "Pais", "Prov_Nasc", "Prov_Resi", "Nacionalidade", "EstadoCivil", "Data_Nascimento", "Regime", "Delegacao", "EscPU", "Opcao1", "Opcao2", "TipoEst"};
	private String[] colunasC = {"Sequencia", "Codigo", "Activo", "Descricao", "Regime_id", "Faculdade", "CodigoGerado"};
	private String[] colunasSalaCandidato = {"ID", "Provincia", "NrCandidato", "Nome", "Opcao1", "Opcao2", "Disciplina", "Local", "Sala", "Data"};
	private String[] colunaDisci = {"ID", "CodDisc", "Designacao", "Data", "Hora", "HoraEntrada", "Ord", "Subj"};
	private String[] colunaLocal = {"Provincia ID", "Designacao"};
	private String[] colunaDeleg = {"Delegacao ID", "Designacao", "Abreviatura"};
	private String[] colunaFacul = {"Codigo", "Designacao", "Abreviatura"};
	private String[] colunaGr = {"Grupo", "CodGrupo", "Designacao"};
	private String[] colunaSala = {"SalaID", "Local", "NrSala", "Provincia", "Prioridade", "Ordem", "Capacidade", "NrVigilante", "EmUSO"};
	
	private String[] tabelasBasicas = {
			"curso",
			"delegacao",
			"disciplinas",
			"escolapreu",
			"faculdade",
			"grupos",
			"localidade",
			"regime",
			"sala_estrutura",
			"sala_candidato"
	};

	public Menu(Login lg) {
		this.lg = lg;
		setTitle("Tela Menu Administrador");
		setSize(400, 300);
		setDefaultCloseOperation(0);
		setLocationRelativeTo(null);
		setLayout(null);
		
		menu[0] = new JMenu(word[0]);
		menu[1] = new JMenu(word[1]);
		menu[2] = new JMenu(word[2]);
		
		itens[0] = new JMenuItem(word[3]);
		itens[4] = new JMenuItem(word[7]);
		
		itens[1] = new JMenuItem(word[4]);
		itens[2] = new JMenuItem(word[5]);
		itens[3] = new JMenuItem(word[6]);
		
		menu[0].add(itens[1]);
		menu[0].add(itens[3]);
		
		menubar.add(menu[0]);
		menubar.add(menu[1]);
		menubar.add(menu[2]);
		menubar.add(itens[0]);
		menubar.add(itens[4]);
		
		setJMenuBar(menubar);
		itens[0].addActionListener(this);
		itens[1].addActionListener(this);
		itens[3].addActionListener(this);
		itens[4].addActionListener(this);
		setVisible(true);
	}
	
	public Menu(Login lf, String nam) {
		this.lg = lf;
		setTitle("Tela Menu Gestor");
		setSize(1500, 1000);
		setDefaultCloseOperation(0);
		setLocationRelativeTo(null);
		setLayout(new BorderLayout());
		
		pane = new JPanel();
		pane.setLayout(new BorderLayout());
		pane.setPreferredSize(new Dimension(200, 300));
		
		cardLayout = new CardLayout();
		pane2 = new JPanel(cardLayout);
		
		menu[0] = new JMenu(word[0]);
		menu[1] = new JMenu(word[1]);
		menu[2] = new JMenu(word[2]);
		menu[3] = new JMenu(word[8]);
		
		itens[0] = new JMenuItem(word[3]);
		itens[4] = new JMenuItem(word[7]);
		itens[9] = new JMenuItem(word[9]);
		
		for (int i = 0; i < tabelasBasicas.length; i++) {
			itens[i + 10] = new JMenuItem(tabelasBasicas[i]);
			menu[3].add(itens[i + 10]);
			itens[i + 10].addActionListener(this);
		}
		
		itens[21] = new JMenuItem("Relatório Estatístico Geral");
		itens[21].addActionListener(this);

		
		itens[2] = new JMenuItem(word[5]);
		itens[3] = new JMenuItem(word[6]);
		itens[20] = new JMenuItem(exameR);
		menu[1].add(itens[20]);
		menu[1].add(itens[21]);
		
		menu[0].add(itens[2]);
		menu[0].add(itens[3]);
		
		menubar.add(menu[0]);
		menubar.add(menu[1]);
		menubar.add(menu[2]);
		menubar.add(menu[3]);
		menubar.add(itens[0]);
		menubar.add(itens[9]);
		menubar.add(itens[4]);
		
		pane.add(menubar);
		add(pane2, BorderLayout.CENTER);
		setJMenuBar(menubar);
		
		itens[0].addActionListener(this);
		itens[2].addActionListener(this);
		itens[3].addActionListener(this);
		itens[4].addActionListener(this);
		itens[9].addActionListener(this);
		//itens[15].addActionListener(this);
		//itens[11].addActionListener(this);
		//itens[12].addActionListener(this);
		itens[20].addActionListener(this);
		//itens[16].addActionListener(this);
		setVisible(true);
	}
	
	public void close(JFrame ft) {
		ft.setVisible(false);
	}
	
	public void open(JFrame ft) {
		ft.setVisible(true);
	}
	
	public void actionPerformed(ActionEvent e) {
		try {
			if (e.getSource() == itens[0]) {
				dispose();
				lg.setVisible(true);
			} else if (e.getSource() == itens[20]) {
				String caminho = "/home/maulate/Transferências/Projecto1/src/main/java/com/Relatorio.pdf";
				pdf.gerarRelatorio(caminho);
				RelatorioPDF.abrirPDF(caminho);
			} else if (e.getSource() == itens[21]) {
    		String caminho = "estatisticas_gerais.pdf";
    		relatorioEstatisticas.gerar(caminho);
    		RelatorioEstatisticasPDF.abrirPDF(caminho);
			} else if (e.getSource() == itens[1]) {
				cad = new CadastroEst(this, this instanceof Menu && getTitle().equals("Tela Menu Administrador"));
				try {
					Connection cone = conm.getConnection();
					JOptionPane.showMessageDialog(this, "Conectado a base de Dados!!", "Informacao", JOptionPane.INFORMATION_MESSAGE);
					close(this);
				} catch (Exception eq) {
					JOptionPane.showMessageDialog(this, "Qualquer erro!!", "Erro!!", JOptionPane.ERROR_MESSAGE);
				}
			} else if (e.getSource() == itens[2]) {
				tablemodel = new DefaultTableModel(colunas, 0);
				tabela = new JTable(tablemodel);
				JScrollPane scroll = new JScrollPane(tabela);
				pane2.add(scroll, "candidato");
				actualizarTable();
				cardLayout.show(pane2, "candidato");
			} else if (e.getSource() == itens[3]) {
				if (this instanceof Menu && getTitle().equals("Tela Menu Administrador")) {
					JOptionPane.showMessageDialog(this, "Administradores não têm permissão para buscar candidatos!", "Erro", JOptionPane.ERROR_MESSAGE);
				} else {
					cad = new CadastroEst(this, false);
					close(this);
				}
			} else if (e.getSource() == itens[4]) {
				jogo = new Maulate();
			} else if (e.getSource() == itens[9]) {
				/*List<GerenciarCandidato> candidatos = dt.buscar();
				distribuicaoCandidatos.distribuir(candidatos);
				JOptionPane.showMessageDialog(this, "Distribuição de candidatos concluída!", "Sucesso", JOptionPane.INFORMATION_MESSAGE);
				*/
				new DistribuicaoFrame(this);
			} else if (e.getSource() == itens[10]) {
				tablemodel = new DefaultTableModel(colunasC, 0);
				tabela = new JTable(tablemodel);
				JScrollPane scroll = new JScrollPane(tabela);
				pane2.add(scroll, "curso");
				CursoF();
				cardLayout.show(pane2, "curso");
			}else if(e.getSource() == itens[11]){
				tablemodel = new DefaultTableModel(colunaDeleg, 0);
				tabela = new JTable(tablemodel);
				JScrollPane scroll = new JScrollPane(tabela);
				pane2.add(scroll, "Delegacao");
				delegacao();
				cardLayout.show(pane2, "Delegacao");
			}else if(e.getSource() == itens[12]){
				tablemodel = new DefaultTableModel(colunaDisci, 0);
				tabela = new JTable(tablemodel);
				JScrollPane scrool = new JScrollPane(tabela);
				pane2.add(scrool, "Disciplinas");
				disciplina();
				cardLayout.show(pane2, "Disciplinas");
			}else if(e.getSource() == itens[14]){
				tablemodel = new DefaultTableModel(colunaFacul, 0);
				tabela = new JTable(tablemodel);
				JScrollPane scroll = new JScrollPane(tabela);
				pane2.add(scroll, "Faculdade");
				faculdade();
				cardLayout.show(pane2, "Faculdade");
			}else if(e.getSource() == itens[15]){
				tablemodel = new DefaultTableModel(colunaGr, 0);
				tabela = new JTable(tablemodel);
				JScrollPane scroll = new JScrollPane(tabela);
				pane2.add(scroll, "Grupo");
				grupo();
				cardLayout.show(pane2, "Grupo");
			} else if(e.getSource() == itens[16]){
				tablemodel = new DefaultTableModel(colunaLocal, 0);
				tabela = new JTable(tablemodel);
				JScrollPane scroll = new JScrollPane(tabela);
				pane2.add(scroll, "Localidade");
				localidade();
				cardLayout.show(pane2, "Localidade");
			}else if(e.getSource() == itens[18]){
				tablemodel = new DefaultTableModel(colunaSala, 0);
				tabela = new JTable(tablemodel);
				JScrollPane scroll = new JScrollPane(tabela);
				pane2.add(scroll, "Salas");
				salas();
				cardLayout.show(pane2,"Salas");
			} else if (e.getSource() == itens[19]) {
				tablemodel = new DefaultTableModel(colunasSalaCandidato, 0);
				tabela = new JTable(tablemodel);
				JScrollPane scroll = new JScrollPane(tabela);
				pane2.add(scroll, "sala_candidato");
				actualizarSalaCandidatoTable();
				cardLayout.show(pane2, "sala_candidato");
			}
			//conm.fechar();
		} catch (Exception ep) {
			lg.Som();
			//conm.fechar();
			JOptionPane.showMessageDialog(this, "Menu error!! " + ep, "Error", JOptionPane.ERROR_MESSAGE);
			
		}
	}
	
	public void disciplina() {
		tablemodel.setRowCount(0);
		try {
			List<Disciplina> disc = discip.buscar();
			for(Disciplina discipli : disc){
				tablemodel.addRow(new Object[]{
					discipli.getId(),
					discipli.getCodDisc(),
					discipli.getDesignacao(),
					discipli.getData(),
					discipli.getHora(),
					discipli.getHoraEntrada(),
					discipli.getOrd(),
					discipli.getSubj()
				});
			}
		}catch(SQLException e){
			lg.Som();
			throw new RuntimeException("Houve um erro " + e.getMessage());
		}
	}
	
	public void grupo(){
		tablemodel.setRowCount(0);
		try{
			List<Grupo> grup = grupo.buscar();
			for(Grupo gr : grup){
				tablemodel.addRow(new Object[]{
					gr.getGrupo(),
					gr.getCodGrupo(),
					gr.getDesignacao()
				});
			}
		}catch(SQLException e){
			lg.Som();
			throw new RuntimeException("MAIs UM ERRRRROOOOO " + e.getMessage());
		}
	}
	
	public void localidade(){
		tablemodel.setRowCount(0);
		try{
			List<Localidade> local = locale.buscar();
			for(Localidade loca : local){
				tablemodel.addRow(new Object[]{
					loca.getId(),
					loca.getDesignacao()
				});
			}
		}catch(SQLException e){
			lg.Som();
			throw new RuntimeException("Houve um erro loc " + e.getMessage());
		}
	}
	
	public void delegacao(){
		tablemodel.setRowCount(0);
		try{
			List<Delegacao> del = delegacao.buscar();
			for(Delegacao dele : del){
				tablemodel.addRow(new Object[]{
					dele.getDelegId(),
					dele.getDesignacao(),
					dele.getAbrev()
				});
			}
		}catch(SQLException e){
			lg.Som();
			throw new RuntimeException("ERROOOOO " + e.getMessage());
		}
	}
	
	public void faculdade(){
		tablemodel.setRowCount(0);
		try{
			List<Faculdade> facul = faculdade.buscar();
			for(Faculdade fac : facul){
				tablemodel.addRow(new Object[]{
					fac.getCod(),
					fac.getDesignacao(),
					fac.getAbrev()
				});
			}
		}catch(SQLException e){
			lg.Som();
			throw new RuntimeException("Outro ERRROOOOO " + e.getMessage());
		}
	}
	
	public void salas(){
		tablemodel.setRowCount(0);
		try{
			String sql = "SELECT SalaID, Local, NrSala, Provincia, prioridade, Ordem, capacidade, NrVigilante, EmUso " +
                     "FROM salas ORDER BY Ordem, prioridade DESC";
			Connection conn = conm.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()){
				tablemodel.addRow(new Object[]{
					rs.getInt("salaid"),
					rs.getString("local"),
					rs.getString("nrsala"),
					rs.getString("provincia"),
					rs.getInt("prioridade"),
					rs.getInt("ordem"),
					rs.getInt("capacidade"),
					rs.getInt("nrvigilante"),
					rs.getBoolean("emuso")
				});
			}
		}catch(SQLException e){
			lg.Som();
			throw new RuntimeException("Mais Um Errrrrroooooo " + e.getMessage());
		}
	}
	
	public void actualizarTable() {
		tablemodel.setRowCount(0);
		try {
			List<GerenciarCandidato> candidatos = dt.buscar();
			for (GerenciarCandidato candidato : candidatos) {
				tablemodel.addRow(new Object[]{
						candidato.getId(),
						candidato.getNrCandidato(),
						candidato.getNome(),
						candidato.getApelido(),
						candidato.getBI(),
						candidato.getGenero(),
						candidato.getPais(),
						candidato.getProv_Nasc(),
						candidato.getProv_Resi(),
						candidato.getNacionalidade(),
						candidato.getEstCivil(),
						candidato.getData_nasc(),
						candidato.getRegime(),
						candidato.getDelegacao(),
						candidato.getEscoPU(),
						candidato.getOpcao1(),
						candidato.getOpcao2(),
						candidato.getTipoEst()
				});
			}
		} catch (SQLException e) {
			lg.Som();
			throw new RuntimeException("Ocorreu um erro!! " + e);
		}
	}
	
	public void CursoF() {
		tablemodel.setRowCount(0);
		try {
			List<String> dados = curso.buscarCursos("Completo");
			for (String var : dados) {
				if (!var.trim().isEmpty()) {
					String[] valores = var.split(",");
					if (valores.length == colunasC.length) {
						tablemodel.addRow(valores);
					}
				}
			}
		} catch (SQLException e) {
			lg.Som();
			throw new RuntimeException("Ocorreu um erro!! " + e);
		}
	}
	
	public void actualizarSalaCandidatoTable() {
		tablemodel.setRowCount(0);
		try {
			String sql = "SELECT id, provincia, nrCandidato, nome, opcao1, opcao2, disciplina, local, sala, data FROM sala_candidato";
				Connection conn = conm.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql);
				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					tablemodel.addRow(new Object[]{
							rs.getInt("id"),
							rs.getString("provincia"),
							rs.getInt("nrCandidato"),
							rs.getString("nome"),
							rs.getString("opcao1"),
							rs.getString("opcao2"),
							rs.getString("disciplina"),
							rs.getString("local"),
							rs.getString("sala"),
							rs.getDate("data")
					});
				}
			
		} catch (SQLException e) {
			lg.Som();
			throw new RuntimeException("Ocorreu um erro ao buscar sala_candidato!! " + e);
		}
	}
}
