package controller;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import java.io.FileOutputStream;
import java.sql.*;
import util.Conexao;
import java.awt.Desktop;
import java.io.File;
import java.io.IOException;

public class RelatorioEstatisticasPDF {
    private final Conexao conm = new Conexao();

    public void gerar(String caminhoArquivo) throws Exception {
        Document document = new Document();
        PdfWriter.getInstance(document, new FileOutputStream(caminhoArquivo));
        document.open();

        document.add(new Paragraph("Relatório Estatístico Geral de Candidatos", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14)));
        document.add(new Paragraph(" "));

        adicionarEstatisticas(document);

        document.close();
        System.out.println("✅ Estatísticas gerais geradas em: " + caminhoArquivo);
    }

    private void adicionarEstatisticas(Document document) throws Exception {
        Connection conn = conm.getConnection();

        PdfPTable tabela = new PdfPTable(2);
        tabela.setWidthPercentage(80);
        tabela.addCell("Indicador");
        tabela.addCell("Total");

        // Total de candidatos unicos
        ResultSet rs = conn.createStatement().executeQuery("SELECT COUNT(DISTINCT nrcandidato) AS total FROM sala_candidato");
        if (rs.next()) {
            tabela.addCell("Total de candidatos");
            tabela.addCell(String.valueOf(rs.getInt("total")));
        }

        // Total de exames (linhas)
        rs = conn.createStatement().executeQuery("SELECT COUNT(*) AS total FROM sala_candidato");
        if (rs.next()) {
            tabela.addCell("Total de exames");
            tabela.addCell(String.valueOf(rs.getInt("total")));
        }

        // Total de salas utilizadas
        rs = conn.createStatement().executeQuery("SELECT COUNT(DISTINCT sala) AS total FROM sala_candidato");
        if (rs.next()) {
            tabela.addCell("Total de salas utilizadas");
            tabela.addCell(String.valueOf(rs.getInt("total")));
        }

        // Total de disciplinas
        rs = conn.createStatement().executeQuery("SELECT COUNT(DISTINCT disciplina) AS total FROM sala_candidato");
        if (rs.next()) {
            tabela.addCell("Total de disciplinas aplicadas");
            tabela.addCell(String.valueOf(rs.getInt("total")));
        }

        // Aqui lista Candidatos por regime
        rs = conn.createStatement().executeQuery("SELECT regime, COUNT(*) AS total FROM candidato GROUP BY regime");
        while (rs.next()) {
            tabela.addCell("Candidatos - " + rs.getString("regime"));
            tabela.addCell(String.valueOf(rs.getInt("total")));
        }

        conm.fechar();
        document.add(tabela);
    }

    public static void abrirPDF(String caminhoArquivo) throws IOException {
        File file = new File(caminhoArquivo);
        if (Desktop.isDesktopSupported()) {
            Desktop.getDesktop().open(file);
        } else {
            Runtime.getRuntime().exec("xdg-open " + caminhoArquivo);
        }
    }
}

