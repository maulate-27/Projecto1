package Jogo;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Random;

public class StickBridgeGame extends JPanel {
    private int stickHeight = 0; // Altura do pau
    private int stickAngle = 90; // Ângulo do pau (90 = vertical, 0 = horizontal)
    private int columnX = 100, nextColumnX = 250; // Posições das colunas
    private int carX = columnX + 10; // Posição do carro
    private boolean isGrowing = false; // Indica se o pau está crescendo
    private boolean isFalling = false; // Indica se o pau está caindo
    private boolean gameOver = false; // Indica se o jogo acabou
    private boolean carMoving = false; // Indica se o carro está se movendo
    private Random random = new Random(); // Gerador de números aleatórios

    public StickBridgeGame() {
        // Botão para aumentar o tamanho do pau
        JButton growButton = new JButton("Aumentar Tamanho");
        growButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (!isGrowing && !gameOver && !isFalling) {
                    isGrowing = true;
                    new Timer(50, new ActionListener() {
                        @Override
                        public void actionPerformed(ActionEvent e) {
                            if (stickHeight < 150) {
                                stickHeight += 5; // Aumenta a altura do pau
                                repaint();
                            } else {
                                ((Timer) e.getSource()).stop();
                                isGrowing = false;
                            }
                        }
                    }).start();
                }
            }
        });

        // Botão para confirmar e fazer o pau cair
        JButton confirmButton = new JButton("Confirmar");
        confirmButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (!isFalling && !gameOver && stickHeight > 0) {
                    isFalling = true;
                    new Timer(20, new ActionListener() {
                        @Override
                        public void actionPerformed(ActionEvent e) {
                            if (stickAngle > 0) {
                                stickAngle -= 5; // Reduz o ângulo para fazer o pau cair
                                repaint();
                            } else {
                                ((Timer) e.getSource()).stop();
                                isFalling = false;
                                checkBridge(); // Verifica se o carro pode passar
                            }
                        }
                    }).start();
                }
            }
        });

        // Layout e adição dos botões
        JPanel buttonPanel = new JPanel();
        buttonPanel.add(growButton);
        buttonPanel.add(confirmButton);
        setLayout(new BorderLayout());
        add(buttonPanel, BorderLayout.SOUTH);
    }

    private void checkBridge() {
        int bridgeEnd = columnX + (int) (stickHeight * Math.cos(Math.toRadians(stickAngle)));
        if (bridgeEnd >= nextColumnX && bridgeEnd <= nextColumnX + 50) {
            carMoving = true;
            new Timer(20, new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    if (carX < nextColumnX + 10) {
                        carX += 5; // Move o carro
                        repaint();
                    } else {
                        ((Timer) e.getSource()).stop();
                        carMoving = false;
                        columnX = nextColumnX;
                        nextColumnX = columnX + 100 + random.nextInt(100);
                        carX = columnX + 10;
                        stickHeight = 0;
                        stickAngle = 90;
                        repaint();
                    }
                }
            }).start();
        } else {
            gameOver = true; // Fim de jogo
        }
        repaint();
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        // Desenha o chão
        g.setColor(Color.LIGHT_GRAY);
        g.fillRect(0, getHeight() - 100, getWidth(), 100);

        // Desenha as colunas
        g.setColor(Color.BLACK);
        g.fillRect(columnX, getHeight() - 120, 50, 20);
        g.fillRect(nextColumnX, getHeight() - 120, 50, 20);

        // Desenha o pau
        int stickEndX = columnX + (int) (stickHeight * Math.cos(Math.toRadians(stickAngle)));
        int stickEndY = getHeight() - 120 - (int) (stickHeight * Math.sin(Math.toRadians(stickAngle)));
        g.setColor(Color.RED);
        g.drawLine(columnX + 25, getHeight() - 120, stickEndX, stickEndY);

        // Desenha o carro
        g.setColor(Color.BLUE);
        g.fillRect(carX, getHeight() - 135, 30, 15);
        g.setColor(Color.BLACK);
        g.fillOval(carX + 3, getHeight() - 120, 8, 8);
        g.fillOval(carX + 19, getHeight() - 120, 8, 8);

        // Mensagem de Game Over
        if (gameOver) {
            g.setColor(Color.RED);
            g.drawString("Game Over!", getWidth() / 2, getHeight() / 2);
        }
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("Stick Bridge Game");
        StickBridgeGame game = new StickBridgeGame();
        frame.add(game);
        frame.setSize(400, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }
}
