package view;

import javax.swing.*;
import java.awt.*;
import java.sql.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import com.toedter.calendar.JDateChooser;
import dao.*;
import model.*;
import java.util.*;
import java.util.List;
import util.*;
import java.util.concurrent.atomic.*;
import java.util.Date;
import java.text.*;

public class CadastroEst extends JFrame implements ActionListener {

	
    private JLabel[] labelP = new JLabel[100];
    private JLabel[] labelC = new JLabel[100];
    private JLabel[] labelI = new JLabel[100];
    private JLabel labelBuscar;

    private CandidatoDao candao;
    private DisciplinaDao dis;
    private DelegacaoDao deleg;
    private CursoDao cursoDao;
    private FaculdadeDao facuDao;
    private Menu menu;
    private Conexao conexao = new Conexao();
    private Login lg = new Login("Maulate");

    private JTextField[] textP = new JTextField[100];
    private JTextField[] textI = new JTextField[100];
    private JTextField textBuscar;
    
/*
	@SuppressWarnings("unchecked")
    private JComboBox<String>[] comboP =(JComboBox<String>[]) new JComboBox<?>[100];
    @SuppressWarnings("unchecked")
    private JComboBox<String>[] comboC =(JComboBox<String>[]) new JComboBox<?>[100];
    @SuppressWarnings("unchecked")
    private JComboBox<String>[] comboI =(JComboBox<String>[]) new JComboBox<?>[100];
*/
		private List<JComboBox<String>> comboP = new ArrayList<>();
		private List<JComboBox<String>> comboI = new ArrayList<>();
		private List<JComboBox<String>> comboC = new ArrayList<>();
    private JDateChooser dateChooser;

    private JButton[] bt = new JButton[100];
    private Ficheiro fich = new Ficheiro();

    private int Py = 20;
    private JPanel menuPainel;
    private JScrollPane scroll;
    private boolean isAdmin; // Indica se é administrador
    private GerenciarCandidato candidatoAtual; // Usado apenas pelo gestor

    private String[] dadosPessoais = {"Nome", "Apelido", "Sexo", "BI", "EstadoCivil", "Data de Nascimento", "Pais", "Provincia", "Distrito", "Bairro"};
    private String[] dados_do_Curso = {"Extensao", "Curso", "Regime"};
    private String[] dados_de_ingresso = {"Habilitacao de Ingresso", "Provincia", "Distrito", "Escola", "Area de Formacao", "Ano de Conclusao"};

    public CadastroEst(Menu menu, boolean isAdmin) {
        this.menu = menu;
        this.isAdmin = isAdmin;
        setTitle("Cadastro de Estudantes");
        setSize(1200, isAdmin ? 690 : 720); // Ajusta tamanho para campo de busca
        setDefaultCloseOperation(0);
        setLocationRelativeTo(null);

        menuPainel = new JPanel();
        menuPainel.setLayout(null);
        menuPainel.setPreferredSize(new Dimension(750, isAdmin ? 1000 : 1100));

        scroll = new JScrollPane(menuPainel);
        scroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
        add(scroll);

        this.candao = new CandidatoDao();
        this.dis = new DisciplinaDao();
        this.deleg = new DelegacaoDao();
        this.cursoDao = new CursoDao();
        this.facuDao = new FaculdadeDao();

        if (!isAdmin) {
            adicionarCampoBusca(menuPainel);
        }
        DadosP(menuPainel);
        DadosI(menuPainel);
        DadosC(menuPainel);
        butao(menuPainel);
        carregarDadosCombobox();
        setVisible(true);
    }

    private void adicionarCampoBusca(JPanel fr) {
        labelBuscar = new JLabel("Nr. Candidato:");
        labelBuscar.setBounds(20, Py, 180, 20);
        labelBuscar.setFont(new Font("Arial", Font.PLAIN, 16));
        fr.add(labelBuscar);

        textBuscar = new JTextField(10);
        textBuscar.setBounds(250, Py, 150, 25);
        fr.add(textBuscar);

        bt[2] = new JButton("Buscar");
        bt[2].setBounds(420, Py, 100, 20);
        bt[2].addActionListener(this);
        fr.add(bt[2]);

        Py += 30;
    }

    public void criarD() {
        dis.criarTabela();
        JOptionPane.showMessageDialog(this, "Tabela disciplinas criada com sucesso!", "Informacao", JOptionPane.INFORMATION_MESSAGE);
    }

   /* public void criarC() {
        facuDao.criarTabela();
        JOptionPane.showMessageDialog(this, "Tabela faculdade criada com sucesso!", "Informacao", JOptionPane.INFORMATION_MESSAGE);
    }*/

    public void DadosC(JPanel fr) {
        Py += 50;
        labelC[0] = new JLabel("Dados do Curso");
        labelC[0].setBounds(20, Py, 300, 20);
        labelC[0].setFont(new Font("Arial", Font.BOLD, 20));
        fr.add(labelC[0]);
        comboC.clear();

        for (int i = 0; i < dados_do_Curso.length; i++) {
            Py += 30;
            labelC[i + 1] = new JLabel(dados_do_Curso[i]);
            JComboBox<String> combo = new JComboBox<>();
            combo.setModel(new DefaultComboBoxModel<>());
            
            //comboC[i] = new JComboBox<>();
            //comboC[i].setModel(new DefaultComboBoxModel<>());

            labelC[i + 1].setBounds(20, Py, 180, 20);
            labelC[i + 1].setFont(new Font("Arial", Font.PLAIN, 16));
       			//comboC[i].setBounds(250, Py, 250, 25);
       			combo.setBounds(250,Py,250,25);

            fr.add(labelC[i + 1]);
            fr.add(combo);
            comboC.add(combo);
        }
    }

    public void DadosP(JPanel fr) {
        Py = isAdmin ? 20 : 50; // Ajustado para campo de busca no gestor
        labelP[0] = new JLabel("Dados Pessoais");
        labelP[0].setBounds(20, Py, 300, 20);
        labelP[0].setFont(new Font("Arial", Font.BOLD, 20));
        fr.add(labelP[0]);
        
        comboP.clear();

        String[] sexos = {"M", "F"};
        String[] estCivil = {"S", "C", "D", "V"};

        for (int i = 0; i < dadosPessoais.length; i++) {
            Py += 30;
            labelP[i + 1] = new JLabel(dadosPessoais[i]);
            labelP[i + 1].setBounds(20, Py, 180, 20);

            if (dadosPessoais[i].equals("Sexo") || dadosPessoais[i].equals("Provincia") || dadosPessoais[i].equals("EstadoCivil")) {
                //comboP[i] = new JComboBox<>();
                JComboBox<String> combo = new JComboBox<>();
                if (dadosPessoais[i].equals("Sexo")) {
                    //comboP[i].setModel(new DefaultComboBoxModel<>(sexos));
                    combo.setModel(new DefaultComboBoxModel<>(sexos));

                } else if (dadosPessoais[i].equals("Provincia")) {
                    //comboP[i].setModel(new DefaultComboBoxModel<>());
                    combo.setModel(new DefaultComboBoxModel<>());
                } else if (dadosPessoais[i].equals("EstadoCivil")) {
                    //comboP[i].setModel(new DefaultComboBoxModel<>(estCivil));
                    combo.setModel(new DefaultComboBoxModel<>(estCivil));
                }
                //comboP[i].setBounds(250, Py, 250, 25);
                combo.setBounds(250,Py,250,25);
                fr.add(combo);
                comboP.add(combo);
            } else if (dadosPessoais[i].equals("Data de Nascimento")) {
                dateChooser = new JDateChooser();
                dateChooser.setBounds(250, Py, 250, 25);
                fr.add(dateChooser);
            } else {
                textP[i] = new JTextField(20);
                textP[i].setBounds(250, Py, 250, 25);
                fr.add(textP[i]);
            }

            fr.add(labelP[i + 1]);
        }
    }

    public void DadosI(JPanel fr) {
        Py += 50;
        labelI[0] = new JLabel("Dados de Ingresso");
        labelI[0].setBounds(20, Py, 300, 20);
        labelI[0].setFont(new Font("Arial", Font.BOLD, 20));
        fr.add(labelI[0]);
        
        comboI.clear();

        String[] habilitacoes = {"Medio", "Superior", "Mestrado"};
        String[] areas = {"GrupoC", "GrupoA", "GrupoB"};
        String[] distritos = {"MAssaca", "Boane", "Goba", "Fomento", "Boquisso", "Matola", "Nhangau", "Namaroi"};

        for (int i = 0; i < dados_de_ingresso.length; i++) {
            Py += 30;
            labelI[i + 1] = new JLabel(dados_de_ingresso[i]);
            labelI[i + 1].setBounds(20, Py, 180, 20);

            if (dados_de_ingresso[i].equals("Habilitacao de Ingresso") || dados_de_ingresso[i].equals("Area de Formacao") || dados_de_ingresso[i].equals("Provincia") || dados_de_ingresso[i].equals("Escola") || dados_de_ingresso[i].equals("Distrito")) {
                //comboI[i] = new JComboBox<>();
                JComboBox<String> combo = new JComboBox<>();
                if (dados_de_ingresso[i].equals("Habilitacao de Ingresso")) {
                    //comboI[i].setModel(new DefaultComboBoxModel<>(habilitacoes));
                    combo.setModel(new DefaultComboBoxModel<>(habilitacoes));
                } else if (dados_de_ingresso[i].equals("Provincia")) {
                    //comboI[i].setModel(new DefaultComboBoxModel<>());
                    combo.setModel(new DefaultComboBoxModel<>());
                } else if (dados_de_ingresso[i].equals("Distrito")) {
                    //comboI[i].setModel(new DefaultComboBoxModel<>(distritos));
                    combo.setModel(new DefaultComboBoxModel<>(distritos));
                } else if (dados_de_ingresso[i].equals("Escola")) {
                    //comboI[i].setModel(new DefaultComboBoxModel<>());
                    combo.setModel(new DefaultComboBoxModel<>());
                } else {
                    //comboI[i].setModel(new DefaultComboBoxModel<>(areas));
                    combo.setModel(new DefaultComboBoxModel<>(areas));
                }
                //comboI[i].setBounds(250, Py, 250, 25);
                combo.setBounds(250,Py,250,25);
                fr.add(combo);
                comboI.add(combo);
            } else {
                textI[i] = new JTextField(20);
                textI[i].setBounds(250, Py, 250, 25);
                fr.add(textI[i]);
            }

            fr.add(labelI[i + 1]);
        }
    }

    public void butao(JPanel fr) {
        try {
            Py += 50;
            bt[0] = new JButton("Salvar");
            bt[1] = new JButton("Sair");
            bt[3] = new JButton("Limpar");

            bt[0].setBounds(50, Py, 150, 20);
            bt[1].setBounds(220, Py, 150, 20);
            bt[3].setBounds(390, Py, 150, 20);

            fr.add(bt[0]);
            fr.add(bt[1]);
            fr.add(bt[3]);

            bt[0].addActionListener(this);
            bt[1].addActionListener(this);
            bt[3].addActionListener(this);
        } catch (Exception e) {
            lg.Som();
            JOptionPane.showMessageDialog(this, "Houve algum erro", "Erro", JOptionPane.ERROR_MESSAGE);
        }
    }

    private Date parseDate(String dateString) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            return sdf.parse(dateString);
        } catch (ParseException eq) {
            lg.Som();
            JOptionPane.showMessageDialog(this, "Formato de data inválido!!", "Erro", JOptionPane.ERROR_MESSAGE);
            throw new RuntimeException("Erro ao converter data", eq);
        }
    }

    public void cadastrar() {
    	int curso1 =  0;
    	AtomicInteger curso3 = new AtomicInteger(0);
        if (!validarCampo()) {
            lg.Som();
            JOptionPane.showMessageDialog(this, "Preencha todos os campos obrigatórios!", "Erro", JOptionPane.ERROR_MESSAGE);
            return;
        }

        JDialog progressDialog = new JDialog(this, "Processando", true);
        JProgressBar progressBar = new JProgressBar();
        progressBar.setIndeterminate(true);
        progressDialog.add(progressBar);
        progressDialog.setSize(300, 75);
        progressDialog.setLocationRelativeTo(this);

        new Thread(() -> {
            try {
                Thread.sleep(1500);

                String nome = textP[0].getText().trim();
                String apelido = textP[1].getText().trim();
                String sexo = comboP.get(2).getSelectedItem().toString();
                String BI = textP[3].getText().trim();
                String estCivil = comboP.get(4).getSelectedItem().toString();
                String dataNasc = ((JTextField) dateChooser.getDateEditor().getUiComponent()).getText();
                String pais = textP[6].getText().trim();
                String provincia = comboP.get(7).getSelectedItem().toString();
                String distrito = textP[8].getText().trim();
                String bairro = textP[9].getText().trim();

                String extensao = comboC.get(0).getSelectedItem().toString();
                String curso = comboC.get(1).getSelectedItem().toString();
                
                try{
               		Connection conm = conexao.getConnection();
               		String sql = "select seq from curso where descricao = ?";
               		PreparedStatement stmt = conm.prepareStatement(sql);
               		stmt.setString(1,curso);
               		
               		ResultSet rs = stmt.executeQuery();
               		while(rs.next()){
               			curso3.set(rs.getInt("seq"));
               			
               		}
               		conexao.fechar();
                }catch(SQLException e){
                	throw new RuntimeException("Erro na busca ");
                }
                int curso2 = curso3.get();
                String regime = comboC.get(2).getSelectedItem().toString();

                String habilitacao = comboI.get(0).getSelectedItem().toString();
                String provinciaEscola = comboI.get(1).getSelectedItem().toString();
                String distritoEscola = comboI.get(2).getSelectedItem().toString();
                String escola = comboI.get(3).getSelectedItem().toString();
                String areaFormacao = comboI.get(4).getSelectedItem().toString();
                String anoConclusao = textI[5].getText().trim();

                GerenciarCandidato candidato;
                if (!isAdmin && candidatoAtual != null) {
                    candidato = candidatoAtual; // Edição para gestor
                } else {
                    candidato = new GerenciarCandidato(); // Novo candidato
                    Random rm = new Random();
                    candidato.setNrCandidato(1000 + rm.nextInt(9000));
                }

                candidato.setNome(nome);
                candidato.setApelido(apelido);
                candidato.setBI(BI);
                candidato.setGenero(sexo.substring(0, 1));
                candidato.setPais(pais);
                candidato.setProv_Nasc(provincia);
                candidato.setProv_Resi(provincia);
                candidato.setNacionalidade("Mocambicana");
                candidato.setEstCivil(estCivil);
                candidato.setData_nasc(parseDate(dataNasc));
                candidato.setRegime(regime);
                candidato.setDelegacao(extensao);
                candidato.setEscoPU(escola);
                candidato.setOpcao1(curso2);
                candidato.setOpcao2(curso2);
                candidato.setTipoEst(habilitacao);

                candao.salvar(candidato);

                SwingUtilities.invokeLater(() -> {
                    progressDialog.dispose();
                    JOptionPane.showMessageDialog(this, "Candidato " + candidato.getNome() + 
                            (isAdmin || candidato.getId() == 0 ? " gravado" : " atualizado") + " com sucesso!!", 
                            "Informação", JOptionPane.INFORMATION_MESSAGE);
                    limparCampos();
                });
            } catch (Exception et) {
                SwingUtilities.invokeLater(() -> {
                    progressDialog.dispose();
                    JOptionPane.showMessageDialog(this, "Houve um erro inesperado " + et, "Erro", JOptionPane.ERROR_MESSAGE);
                });
            }
        }).start();
        progressDialog.setVisible(true);
    }

    public void buscarCandidato() {
        if (isAdmin) {
            JOptionPane.showMessageDialog(this, "Administradores não podem buscar candidatos!", "Erro", JOptionPane.ERROR_MESSAGE);
            return;
        }

        String nrCandidatoStr = textBuscar.getText().trim();
        if (nrCandidatoStr.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Digite o número do candidato!", "Erro", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try {
            int nrCandidato = Integer.parseInt(nrCandidatoStr);
            candidatoAtual = candao.buscarPorNrCandidato(nrCandidato);
            if (candidatoAtual == null) {
                JOptionPane.showMessageDialog(this, "Candidato não encontrado!", "Erro", JOptionPane.ERROR_MESSAGE);
                limparCampos();
                return;
            }

            textP[0].setText(candidatoAtual.getNome());
            textP[1].setText(candidatoAtual.getApelido());
            comboP.get(2).setSelectedItem(candidatoAtual.getGenero());
            textP[3].setText(candidatoAtual.getBI());
            comboP.get(4).setSelectedItem(candidatoAtual.getEstCivil());
            dateChooser.setDate(candidatoAtual.getData_nasc());
            textP[6].setText(candidatoAtual.getPais());
            comboP.get(7).setSelectedItem(candidatoAtual.getProv_Nasc());
            textP[8].setText("");
            textP[9].setText("");
            comboC.get(0).setSelectedItem(candidatoAtual.getDelegacao());
            comboC.get(1).setSelectedItem(candidatoAtual.getOpcao1());
            comboC.get(2).setSelectedItem(candidatoAtual.getRegime());
            comboI.get(0).setSelectedItem(candidatoAtual.getTipoEst());
            comboI.get(1).setSelectedItem(candidatoAtual.getProv_Nasc());
            comboI.get(2).setSelectedItem("");
            comboI.get(3).setSelectedItem(candidatoAtual.getEscoPU());
            comboI.get(4).setSelectedItem("");
            textI[5].setText("");

            JOptionPane.showMessageDialog(this, "Candidato carregado para edição!", "Sucesso", JOptionPane.INFORMATION_MESSAGE);
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this, "Número do candidato inválido!", "Erro", JOptionPane.ERROR_MESSAGE);
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Erro ao buscar candidato: " + e.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
        }
    }

    private boolean validarCampo() {
        for (int i = 0; i < dadosPessoais.length; i++) {
            if (dadosPessoais[i].equals("Data de Nascimento")) {
                if (((JTextField) dateChooser.getDateEditor().getUiComponent()).getText().trim().isEmpty()) {
                    return false;
                }
            } else if (dadosPessoais[i].equals("Provincia") || dadosPessoais[i].equals("Sexo") || dadosPessoais[i].equals("EstadoCivil")) {
                if (comboP.get(i).getSelectedItem() == null) {
                    return false;
                }
            } else if (textP[i] != null && textP[i].getText().trim().isEmpty()) {
                return false;
            }
        }

        for (int i = 0; i < dados_do_Curso.length; i++) {
            if (comboC.get(i).getSelectedItem() == null) {
                return false;
            }
        }

        for (int i = 0; i < dados_de_ingresso.length; i++) {
            if (dados_de_ingresso[i].equals("Provincia") || dados_de_ingresso[i].equals("Distrito") || 
                dados_de_ingresso[i].equals("Area de Formacao") || dados_de_ingresso[i].equals("Habilitacao de Ingresso") || 
                dados_de_ingresso[i].equals("Escola")) {
                if (comboI.get(i).getSelectedItem() == null) {
                    return false;
                }
            } else if (textI[i] != null && textI[i].getText().trim().isEmpty()) {
                return false;
            }
        }
        return true;
    }

    private void carregarDadosCombobox() {
        try {
            List<String> extensoes = cursoDao.buscarExtensoes();
            List<String> cursos = cursoDao.buscarCursos();
            List<String> regimes = cursoDao.buscarRegimes();
            List<String> provin = cursoDao.buscarProvincia();
            List<String> escola = cursoDao.buscarEscola();

            atualizarComboboxExtensoes(extensoes);
            atualizarComboboxCursos(cursos);
            atualizarComboboxRegimes(regimes);
            actualizarProvincia(provin);
            actualizarEscola(escola);
        } catch (SQLException e) {
            lg.Som();
            JOptionPane.showMessageDialog(this, "Erro ao carregar dados: " + e.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
            e.printStackTrace();
        }
    }

    private void actualizarEscola(List<String> escolas) {
        DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>();
        for (String escola : escolas) {
            model.addElement(escola);
        }

        for (int i = 0; i < dados_de_ingresso.length; i++) {
            if (dados_de_ingresso[i].equals("Escola") && comboI.get(i) != null) {
                comboI.get(i).setModel(model);
                break;
            }
        }
    }

    private void actualizarProvincia(List<String> provincia) {
        DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>();
        for (String prov : provincia) {
            model.addElement(prov);
        }

        for (int i = 0; i < dadosPessoais.length; i++) {
            if (dadosPessoais[i].equals("Provincia") && comboP.get(i) != null) {
                comboP.get(i).setModel(model);
                break;
            }
        }

        for (int i = 0; i < dados_de_ingresso.length; i++) {
            if (dados_de_ingresso[i].equals("Provincia") && comboI.get(i) != null) {
                comboI.get(i).setModel(model);
                break;
            }
        }
    }

    private void atualizarComboboxExtensoes(List<String> extensoes) {
        DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>();
        for (String extensao : extensoes) {
            model.addElement(extensao);
        }

        for (int i = 0; i < dados_do_Curso.length; i++) {
            if (dados_do_Curso[i].equals("Extensao") && comboC.get(i) != null) {
                comboC.get(i).setModel(model);
                break;
            }
        }
    }

    private void atualizarComboboxCursos(List<String> cursos) {
        DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>();
        for (String curso : cursos) {
            model.addElement(curso);
        }

        for (int i = 0; i < dados_do_Curso.length; i++) {
            if (dados_do_Curso[i].equals("Curso") && comboC.get(i) != null) {
                comboC.get(i).setModel(model);
                break;
            }
        }
    }

    private void atualizarComboboxRegimes(List<String> regimes) {
        DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>();
        for (String regime : regimes) {
            model.addElement(regime);
        }

        for (int i = 0; i < dados_do_Curso.length; i++) {
            if (dados_do_Curso[i].equals("Regime") && comboC.get(i) != null) {
                comboC.get(i).setModel(model);
                break;
            }
        }
    }

    public void limparCampos() {
        if (!isAdmin) {
            candidatoAtual = null;
            textBuscar.setText("");
        }
        textP[0].setText("");
        textP[1].setText("");
        comboP.get(2).setSelectedItem("");
        textP[3].setText("");
        comboP.get(4).setSelectedItem("");
        ((JTextField) dateChooser.getDateEditor().getUiComponent()).setText("");
        textP[6].setText("");
        comboP.get(7).setSelectedItem("");
        textP[8].setText("");
        textP[9].setText("");
        comboC.get(0).setSelectedItem("");
        comboC.get(1).setSelectedItem("");
        comboC.get(2).setSelectedItem("");
        comboI.get(0).setSelectedItem("");
        comboI.get(1).setSelectedItem("");
        comboI.get(2).setSelectedItem("");
        comboI.get(3).setSelectedItem("");
        comboI.get(4).setSelectedItem("");
        textI[5].setText("");
    }

    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == bt[0]) {
            cadastrar();
        } else if (e.getSource() == bt[1]) {
            dispose();
            menu.setVisible(true);
        } else if (e.getSource() == bt[2]) {
            buscarCandidato();
        } else if (e.getSource() == bt[3]) {
            limparCampos();
        }
    }
}
