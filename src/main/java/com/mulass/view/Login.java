package view;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.sound.sampled.*;
import java.io.File;
import java.util.Arrays;

public class Login extends JFrame implements ActionListener{

	String[] dados = {"maulate","antonio"};
	
	String[] dadosA = {"antonio","teste21"};
	boolean comparei = false;
	
	String[] dada = {"Gestor","Administrador"};
	
	
	JLabel lb[] = new JLabel[100];
	TextField tx[] = new TextField[100];
	JPasswordField tp[] = new JPasswordField[100];
	JButton bt[] = new JButton[100];
	//JComboBox<String> combox;
	
	boolean ok = false;
	
	public Login(String a){}
	public Login(){
	
		setTitle("Tela de Login");
		setSize(400,300);
		setResizable(false);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setLocationRelativeTo(null);
		setLayout(null);
		
		
		JPanel panel = new JPanel(){
			protected void paintComponent(Graphics g){
				super.paintComponent(g);		
				float transparencia = 0.3f;		
					Graphics2D grd = (Graphics2D) g.create();
						grd.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER, transparencia));
							ImageIcon background = new ImageIcon("/home/maulate/Transferências/Projecto1/src/main/resources /img/photo.jpg");
								grd.drawImage(background.getImage(),0,0, getWidth(),getHeight(), this);
								grd.dispose();		
			}
		};
		panel.setLayout(null);
		setContentPane(panel);
		Adicionar(this);
		botao(this);
	}
	
	public void Adicionar(JFrame tr){
	
	Color[] cores = {Color.red,Color.blue,Color.white,Color.yellow,Color.black,Color.green,Color.gray,Color.magenta,Color.orange};
	final int[] index={0};
	
	Timer time = new Timer(1000, e ->{
		lb[0].setForeground(cores[index[0]]);
		index[0] = (index[0] +1) % cores.length;
	});
	
	time.start();
	
		lb[0] = new JLabel("Login");
		lb[1] = new JLabel("User");
		lb[2] = new JLabel("Password");
		
		lb[0].setFont(new Font("Arial",Font.BOLD | Font.ITALIC, 24));
		//lb[0].setForeground(Color.RED);
		
		tx[0] = new TextField(15);
		tp[0] = new JPasswordField(15);
		
		lb[0].setBounds(185,30,100,30);
		lb[1].setBounds(80,80,50,20);
		lb[2].setBounds(80,120,75,20);
		
		tx[0].setBounds(120,80,200,20);
		tp[0].setBounds(155,120,165,20);
		
		tr.add(lb[0]);
		tr.add(tx[0]);
		tr.add(lb[1]);
		tr.add(lb[2]);
		tr.add(tp[0]);
		
		setVisible(true);
	}
	
	public void botao(JFrame ny){
		bt[0] = new JButton("Entrar");
		//combox = new JComboBox<>();
		
		//combox.setBounds(190,160,130,20);
		bt[0].setBounds(150,160,100,20);
		
	//	combox.addItem(dada[0]);
	//	combox.addItem(dada[1]);
		
		//ny.add(combox);
		ny.add(bt[0]);
		bt[0].addActionListener(this);
		
	}
	
	public void Som(){
		try{
			//Toolkit.getDefaultToolkit().beep();
			AudioInputStream audio = AudioSystem.getAudioInputStream(new File("/home/maulate/som/alerta1.wav"));
			Clip clip = AudioSystem.getClip();
			clip.open(audio);
			clip.start();
		}catch(Exception e){
			JOptionPane.showMessageDialog(this,"Erro " + e.getMessage() ,"Erro",JOptionPane.ERROR_MESSAGE);
		}
	}
	
	public void ocultar(JFrame gh){
		gh.setVisible(false);	
		repaint();
	}
	
	public void actionPerformed(ActionEvent e){
	
	//String tipo = (String) combox.getSelectedItem();
	char[] password = tp[0].getPassword();
	String user = tx[0].getText();
	
	char[] password1 = tp[0].getPassword();
	String user2 = tx[0].getText();
		
		try{
			if(user.equals(dados[0])){
			char[] pass = {'m','u','t','o','t','a'};
				if(Arrays.equals(pass,password)){
					new Menu(this);
					ocultar(this);
				
				}else if(tx[0].getText().isEmpty() && new String(tp[0].getPassword()).isEmpty()){
					Som();
					JOptionPane.showMessageDialog(this, "Por favor insira os dados de login", "Alerta", JOptionPane.INFORMATION_MESSAGE);
				
				}else if(tx[0].getText().isEmpty() || new String(tp[0].getPassword()).isEmpty()){
				Som();
					JOptionPane.showMessageDialog(this, "Dados de login em falta", "Alerta",JOptionPane.INFORMATION_MESSAGE);
			
				}else if(Arrays.equals(pass,password) == false) {
				Som();
					JOptionPane.showMessageDialog(this, "Password incorrecto!! ", "Alerta", JOptionPane.INFORMATION_MESSAGE);
				}
				
			}else if(user.equals(dadosA[0])){
				char[] passA = {'m','a','c','h','i','p','o','i'};
				if(Arrays.equals(passA,password)){
					new Menu(this,"Gestor");
					ocultar(this);
				}else if(tx[0].getText().isEmpty() && new String(tp[0].getPassword()).isEmpty()){
				Som();
					JOptionPane.showMessageDialog(this, "Por favor insira os dados de login", "Alerta", JOptionPane.INFORMATION_MESSAGE);
				
				}else if(tx[0].getText().isEmpty() || new String(tp[0].getPassword()).isEmpty()){
				Som();
					JOptionPane.showMessageDialog(this, "Dados de login em falta", "Alerta",JOptionPane.INFORMATION_MESSAGE);
			
				}else if(Arrays.equals(passA,password1) == false) {
				Som();
					JOptionPane.showMessageDialog(this, "Password incorrecto!!", "Alerta", JOptionPane.INFORMATION_MESSAGE);
				}
			}
		}catch(Exception er){
		Som();
			JOptionPane.showMessageDialog(this, " 404 error!!" , "Erro", JOptionPane.ERROR_MESSAGE);
			dispose();	
		}
	}
}
