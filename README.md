         Sistema de candidatura aos exames de admissao na UP-Maputo;
         
📘 Projeto: Sistema de Distribuição de Candidatos às Salas de Exame
👨‍🎓 Autor: Maulate Antonio Izaquiel 2 Ano Informatica codigo 01.2439.2024
	Curso de Informática


   DESCRICAO
	Este sistema tem como objetivo automatizar a distribuição de candidatos às salas de exame com base na sua província de residência, disciplina e 				  disponibilidade de salas. Permite cadastrar, consultar, alocar e gerar relatórios estatísticos e por disciplina.	


	TECNOLOGIAS UTILIZADAS
	Java 11+

	Swing (Java GUI)

	PostgreSQL

	JDBC

	iTextPDF (para relatórios PDF)
	
	IMPORTAR A BASE DE DADOS
	
	Primeiro:
		Criar uma base de dados um usuario maulate com password 'maulass@27'
			create database sigexames;
			create user maulate whith password 'maulass@27';
			grant all Privilegies on database sigexames to maulate; 
			
			E por fim importar com 
				psql -U maulate -d sigexames -f importar.sql

         
         
     INSTRUCOES PARA COMPILAR E EXECUTAR O PROJECTO
1. Abra o terminal e vá até a pasta /src/main/java/com/mulass

2. Compile todos os arquivos:
   javac -cp .:/home/maulate/Transferências/Projecto1/lib/postgresql-42.6.0.jar:/home/maulate/Transferências/Projecto1/lib/jcalendar-1.4.jar:/home/maulate/Transferências/Projecto1/lib/itextpdf-5.5.13.2.jar Admisao.java view/*.java model/*.java util/*.java dao/*.java controller/*.java 

3. Execute o sistema (classe principal):
   java -cp .:/home/maulate/Transferências/Projecto1/lib/postgresql-42.6.0.jar:/home/maulate/Transferências/Projecto1/lib/jcalendar-1.4.jar:/home/maulate/Transferências/Projecto1/lib/itextpdf-5.5.13.2.jar Admisao 

OBS:
- Altere os caminhos se estiver usando Windows (trocar ":" por ";")
- Certifique-se de que o PostgreSQL está ativo e com a base importada

Em seguida sera aberto um frame de login
Gestor ("Onde ocorre a distribuicao");
		User : antonio
		Password : machipoi
		
Administrador ("Onde ocorre o cadastro")
		User : maulate
		Password : mutota
		
		As imagens estao no word nesse mesmo projecto
		
		Aceite Comprimentos 
					Maulate Antonio Isaquiel
		
		Para mais informacoes
		email: maulateantonio27@gmail.com
		Contacto: [+258 842641135]
		
