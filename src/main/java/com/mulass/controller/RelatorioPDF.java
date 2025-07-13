package controller;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import java.io.FileOutputStream;
import java.sql.*;
import util.*;
import java.awt.Desktop;
import java.io.File;
import java.io.IOException;

public class RelatorioPDF {
	public final Conexao conm = new Conexao();

    public void gerarRelatorio(String caminhoArquivo) throws Exception {
        Document document = new Document();
        PdfWriter.getInstance(document, new FileOutputStream(caminhoArquivo));
        document.open();

        document.add(new Paragraph("Relatório de Exames por Disciplina e Provincia"));
        document.add(new Paragraph(" ")); // Espaço

        gerarTabela(document);

        document.close();
        System.out.println("✅ Relatório PDF gerado em: " + caminhoArquivo);
    }

    private void gerarTabela(Document document) throws Exception {
        PdfPTable tabela = new PdfPTable(3); // Província | Disciplina | Total
        tabela.addCell("Provincia");
        tabela.addCell("Disciplina");
        tabela.addCell("Total");

        Connection conexao = conm.getConnection();
        String sql = "SELECT provincia, disciplina, COUNT(*) as total FROM sala_candidato GROUP BY provincia, disciplina ORDER BY provincia, disciplina";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            tabela.addCell(rs.getString("provincia"));
            tabela.addCell(rs.getString("disciplina"));
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
            // Fallback para sistemas Linux
            Runtime.getRuntime().exec("xdg-open " + caminhoArquivo);
        }
    }

}

