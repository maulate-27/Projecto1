package controller;

import java.util.*;
import model.*;
import dao.*;
import util.*;
import java.sql.*;

public class DistribuicaoCandidatos {
    private SalaDAO salaEstruturaDAO = new SalaDAO();
    private SalaCandidatoDAO salaCandidatoDAO = new SalaCandidatoDAO();
    private LocalidadeDAO localidadeDAO = new LocalidadeDAO();
    private DisciplinaDao disciplinaDAO = new DisciplinaDao();

    public void distribuir(List<GerenciarCandidato> candidatos) throws SQLException {
        
        		System.out.println("Iniciando distribuição. Total de candidatos: " + candidatos.size());
            // Buscar salas disponíveis
            List<SalaEstrutura> salas = salaEstruturaDAO.buscarTodas();
            if (salas.isEmpty()) {
                throw new RuntimeException("Nenhuma sala disponível!");
            }
           
           // Buscar mapeamento de designacao para localID
       		 	Map<String, Integer> designacaoParaLocalID = localidadeDAO.buscarDesignacaoParaLocalID();
        		System.out.println("Províncias carregadas: " + designacaoParaLocalID.keySet());
        		
        		salaCandidatoDAO.excluirTudo();
           	System.out.println("Tabela sala_candidato limpa.");

            // Distribuir candidatos por província
            // Agrupar salas por localID
       			Map<Integer, List<SalaEstrutura>> salasPorLocalID = new HashMap<>();
        		for (SalaEstrutura sala : salas) {
            	int localID = sala.getProvincia();
            	System.out.println("Sala: " + sala.getNrSala() + ", localID: " + localID);
            	salasPorLocalID.computeIfAbsent(localID, k -> new ArrayList<>()).add(sala);
        		}

						
						int alocados = 0;
            for (GerenciarCandidato candidato : candidatos) {
                String nome = candidato.getNome() != null ? candidato.getNome() : "Sem nome";
            String provincia = candidato.getProv_Resi() != null ? candidato.getProv_Resi().trim() : "";
            System.out.println("Candidato: " + nome + ", Província: " + provincia);
            
            if(candidato.getNrCandidato() <= 0) {
            	System.out.println("Erro: Número de candidato inválido para " + nome);
              continue;
            }
            		
            		 // Mapear prov_Nasc para localID
            		Integer localID = designacaoParaLocalID.get(provincia.toLowerCase());
            		if (localID == null) {
                	System.out.println("Sem localID para província " + provincia + " para " + nome);
                	continue;
            		}
            		System.out.println("Prov_Nasc: " + provincia + " mapeado para localID: " + localID);
            		
                List<SalaEstrutura> salasDisponiveis = salasPorLocalID.getOrDefault(localID, new ArrayList<>());
								System.out.println("************ O nr total das salas disponiveis sao: " + salasDisponiveis + " *********************");
                if (salasDisponiveis.isEmpty()) {
                    System.out.println("Nenhuma sala na província " + provincia + ". Tentando outras salas.");
                //salasDisponiveis = new ArrayList<>(salas);
                continue;
                }
                
                 // Ordenar salas por prioridade e ordem
           	 		salasDisponiveis.sort((s1, s2) -> {
                	if (s1.getOrdem() != s2.getOrdem()) {
                    return Integer.compare(s1.getOrdem(), s2.getOrdem());
                	}
                	return Integer.compare(s2.getPrioridade(), s1.getPrioridade());
            		});


                // Escolher sala com capacidade disponível
                boolean alocado = false;
                for (SalaEstrutura sala : salasDisponiveis) {
                    alocados = contarAlocados(sala.getNrSala());
                    System.out.println("Sala " + sala.getNrSala() + ": " + alocados + "/" + sala.getCapacidade());
                    if (alocados < sala.getCapacidade()) {
                        
                        List<String> disciplinas = disciplinaDAO.buscarDisciplinasPorCurso(candidato.getOpcao1());
												if (disciplinas.isEmpty()) {
											    System.out.println("Curso " + candidato.getOpcao1() + " sem disciplinas associadas.");
    											continue;
												}
												System.out.println("Disciplinas encontradas para curso " + candidato.getOpcao1() + ": " + disciplinas);

												for(String disciplina : disciplinas.subList(0, Math.min(2, disciplinas.size()))){
													Sala alocacao = new Sala();
													System.out.println("As disciplinas sao : " + disciplina);
                        	alocacao.setProvincia(candidato.getProv_Resi());
                        	alocacao.setNrCandidato(candidato.getNrCandidato());
                        	alocacao.setNome(candidato.getNome());
                        	alocacao.setOpcao1(candidato.getOpcao1() + "");
                        	alocacao.setOpcao2(candidato.getOpcao2() + "");
                       	 	alocacao.setDisciplina(disciplina); 
                        	alocacao.setLocal(sala.getLocal());
                        	alocacao.setSala(sala.getNrSala());
                        	
                        	try {
                        salaCandidatoDAO.salvar(alocacao,sala);
                        alocados++;
                        System.out.println("Candidato " + candidato.getNome() + " alocado na sala " + sala.getNrSala());
                        }catch(RuntimeException e){
                        	System.err.println("Erro ao salvar alocação para candidato " + candidato.getNome() + ": " + e.getMessage());
                        throw e;
                        }catch(Exception ty){
                        	System.out.println("ERROOO");
                        }
                       }
                       
                       alocado = true;
                       break;
                    }
                }
                if (!alocado) {
                System.out.println("Não alocado: " + nome + " (todas as salas cheias)");
            }
            }
            System.out.println("Distribuição concluída. Total de candidatos alocados: " + alocados);
    }

    private int contarAlocados(String nrSala) throws SQLException {
        return salaEstruturaDAO.contarCandidatosNaSala(nrSala);
    }
}
