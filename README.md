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
1. Abra o terminal e vá até a pasta Projecto1

2. Compile todos os arquivos (.java):

		javac -d bin  -cp "lib/*" $(find src/main/java -name ("*.java"))

3. Execute o sistema (classe principal):

   		java -cp "bin:lib/*" com.mulass.Admisao

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
		
 As imagens estao no word nesse mesmo projecto no arquivo Ilustracao.docx
		
		Aceite Comprimentos 
					Maulate António Isaquiel
		
		Para mais informações
		email: maulateantonio27@gmail.com
		Contacto: [+258 842641135]
		
