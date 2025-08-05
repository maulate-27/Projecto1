package Jogo;

import java.util.ArrayList;
import java.util.Random;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class Maulate extends JFrame implements ActionListener, KeyListener {
    Timer tempo;
    int pontuacao = 0;
    int N_P = 50, M_P = 50; 
    int L_X, L_Y; 
    int delay = 200;
    char direcao = 'D';
    ArrayList<Point> cobra = new ArrayList<>();
    final int TAMANHO_SEGMENTO = 25;

    public Maulate() {
        setTitle("Cobra em Java");
        setSize(700, 600);
        setLocationRelativeTo(null);
        getContentPane().setBackground(Color.green);
        setVisible(true);

        
        cobra.add(new Point(M_P, N_P));
        cobra.add(new Point(M_P - TAMANHO_SEGMENTO, N_P));
        cobra.add(new Point(M_P - 2 * TAMANHO_SEGMENTO, N_P));

        iniciar();
        addKeyListener(this);
    }

    
    public void paint(Graphics g) {
        super.paint(g);
        desenhar(g);
    }

    public void desenhar(Graphics g) {
        // Desenha a comida
        g.setColor(Color.red);
        g.fillOval(L_X, L_Y, TAMANHO_SEGMENTO, TAMANHO_SEGMENTO);

        // Desenha a cobra
        for (Point segmento : cobra) {
            g.setColor(Color.yellow);
            g.fillRect(segmento.x, segmento.y, TAMANHO_SEGMENTO, TAMANHO_SEGMENTO);
        }

        Pontuacao(g);
    }

    public void gerarComida() {
        Random random = new Random();
        L_X = random.nextInt((700 / TAMANHO_SEGMENTO)) * TAMANHO_SEGMENTO;
        L_Y = random.nextInt((600 / TAMANHO_SEGMENTO)) * TAMANHO_SEGMENTO;
    }

    public void Pontuacao(Graphics g) {
        String pontua = "Pontuacao: " + pontuacao;
        g.setColor(Color.BLUE);
        g.setFont(new Font("Arial", Font.BOLD, 25));
        g.drawString(pontua, 20, 100);
    }

    public void iniciar() {
        tempo = new Timer(delay, this);
        gerarComida();
        tempo.start();
    }

    public void comer() {
        Point cabeca = cobra.get(0);
        if (cabeca.x == L_X && cabeca.y == L_Y) {
            gerarComida();
            pontuacao += 10;
            // Adiciona novo segmento no final
            Point ultimo = cobra.get(cobra.size() - 1);
            cobra.add(new Point(ultimo.x, ultimo.y));
        }
    }

    public void mover() {
        // Move os segmentos (do último para o primeiro)
        for (int i = cobra.size() - 1; i > 0; i--) {
            cobra.get(i).x = cobra.get(i - 1).x;
            cobra.get(i).y = cobra.get(i - 1).y;
        }

        // Move a cabeça
        Point cabeca = cobra.get(0);
        switch (direcao) {
            case 'D':
            					cabeca.x += TAMANHO_SEGMENTO;
            					break;
            case 'E':
            					cabeca.x -= TAMANHO_SEGMENTO;
            					break;
            case 'B':
            					cabeca.y += TAMANHO_SEGMENTO;
            					break;
            case 'C':
            					cabeca.y -= TAMANHO_SEGMENTO;
            					break;
            default: break;
        }

        // Verifica colisão com as paredes
        if (cabeca.x < 0 || cabeca.x >= 700 || cabeca.y < 0 || cabeca.y >= 600) {
            gameOver();
        }

        // Verifica colisão com o próprio corpo
        for (int i = 1; i < cobra.size(); i++) {
            if (cabeca.x == cobra.get(i).x && cabeca.y == cobra.get(i).y) {
                gameOver();
            }
        }
    }

    public void gameOver() {
        tempo.stop();
        JOptionPane.showMessageDialog(this, "Game Over! Pontuação: " + pontuacao);
        //System.exit(0);
    }

    public void keyPressed(KeyEvent k1) {
        int tecla = k1.getKeyCode();
        switch (tecla) {
            case KeyEvent.VK_LEFT:
            							 			 if (direcao != 'D') direcao = 'E';
            							 			 break;
            case KeyEvent.VK_RIGHT:
            											if (direcao != 'E') direcao = 'D'; 
            											break;
            case KeyEvent.VK_UP:
            										if (direcao != 'B') direcao = 'C';
            										break;
            case KeyEvent.VK_DOWN:
            										if (direcao != 'C') direcao = 'B';
            										break;
           default: break;
        }
    }

    public void keyTyped(KeyEvent k2) {}
    public void keyReleased(KeyEvent k3) {}

    public void actionPerformed(ActionEvent e) {
        mover();
        comer();
        repaint();
    }
  }
