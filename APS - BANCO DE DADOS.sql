CREATE DATABASE APS_BANCO_DE_DADOS;
USE APS_BANCO_DE_DADOS

-- tabela Recurso
CREATE TABLE Recurso (
    RecursoID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    NumeroRegistro VARCHAR(30) NOT NULL UNIQUE,
    Cargo VARCHAR(60) NOT NULL,
    DataAdmissao DATE NULL
);

-- Endereço (1:1 por Recurso)
CREATE TABLE Endereco (
    EnderecoID INT IDENTITY(1,1) PRIMARY KEY,
    RecursoID INT NOT NULL UNIQUE,
    Logradouro VARCHAR(200),
    Numero VARCHAR(20),
    Complemento VARCHAR(100),
    Bairro VARCHAR(100),
    Cidade VARCHAR(100),
    Estado VARCHAR(50),
    CEP VARCHAR(20),
    CONSTRAINT FK_Endereco_Recurso FOREIGN KEY (RecursoID) REFERENCES Recurso(RecursoID)
);

-- Telefone (N por Recurso)
CREATE TABLE Telefone (
    TelefoneID INT IDENTITY(1,1) PRIMARY KEY,
    RecursoID INT NOT NULL,
    TipoTelefone VARCHAR(40) NOT NULL, -- residencial, comercial, celular, ramal
    Numero VARCHAR(50) NOT NULL,
    Observacao VARCHAR(200),
    CONSTRAINT FK_Telefone_Recurso FOREIGN KEY (RecursoID) REFERENCES Recurso(RecursoID)
);

-- Histórico salarial (N por Recurso)
CREATE TABLE SalarioHistorico (
    SalarioID INT IDENTITY(1,1) PRIMARY KEY,
    RecursoID INT NOT NULL,
    DataAlteracao DATE NOT NULL,
    Salario DECIMAL(12,2) NOT NULL,
    Observacao VARCHAR(200),
    CONSTRAINT FK_Salario_Recurso FOREIGN KEY (RecursoID) REFERENCES Recurso(RecursoID)
);

-- Ferramenta
CREATE TABLE Ferramenta (
    FerramentaID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(120) NOT NULL
);

-- ProgramadorFerramenta (N:N com campo Versao e Nivel de experiencia opcional)
CREATE TABLE ProgramadorFerramenta (
    RecursoID INT NOT NULL,
    FerramentaID INT NOT NULL,
    Versao VARCHAR(50),
    NivelExperiencia VARCHAR(40),
    CONSTRAINT PK_ProgFerr PRIMARY KEY (RecursoID, FerramentaID),
    CONSTRAINT FK_PF_Recurso FOREIGN KEY (RecursoID) REFERENCES Recurso(RecursoID),
    CONSTRAINT FK_PF_Ferramenta FOREIGN KEY (FerramentaID) REFERENCES Ferramenta(FerramentaID)
);

-- Equipe
CREATE TABLE Equipe (
    EquipeID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(120) NOT NULL,
    NumeroRecursosPrev INT NULL
);

-- Projeto
CREATE TABLE Projeto (
    ProjetoID INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(30) NOT NULL UNIQUE,
    Nome VARCHAR(200) NOT NULL,
    DataInicio DATE NULL,
    DataPrevFim DATE NULL,
    DataFimReal DATE NULL,
    Status VARCHAR(60) NULL,
    HorasPrevistas INT NULL,
    HorasReais INT NULL,
    EquipeID INT NOT NULL,
    GerenteRecursoID INT NOT NULL,
    CONSTRAINT FK_Projeto_Equipe FOREIGN KEY (EquipeID) REFERENCES Equipe(EquipeID),
    CONSTRAINT FK_Projeto_Gerente FOREIGN KEY (GerenteRecursoID) REFERENCES Recurso(RecursoID)
);

-- Atividade
CREATE TABLE Atividade (
    AtividadeID INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(30) NOT NULL UNIQUE,
    Nome VARCHAR(200) NOT NULL
);

-- ProjetoAtividade (N:N)
CREATE TABLE ProjetoAtividade (
    ProjetoID INT NOT NULL,
    AtividadeID INT NOT NULL,
    CONSTRAINT PK_ProjAtiv PRIMARY KEY (ProjetoID, AtividadeID),
    CONSTRAINT FK_PA_Projeto FOREIGN KEY (ProjetoID) REFERENCES Projeto(ProjetoID),
    CONSTRAINT FK_PA_Atividade FOREIGN KEY (AtividadeID) REFERENCES Atividade(AtividadeID)
);

-- Tarefa (pertence a uma Atividade)
CREATE TABLE Tarefa (
    TarefaID INT IDENTITY(1,1) PRIMARY KEY,
    AtividadeID INT NOT NULL,
    Codigo VARCHAR(50) NOT NULL,
    Descricao VARCHAR(400) NULL,
    CONSTRAINT FK_Tarefa_Atividade FOREIGN KEY (AtividadeID) REFERENCES Atividade(AtividadeID)
);

/* -----------------------------
   3) DML - Inserts (pelo menos 10 registros em cada tabela)
   Observação: alguns inserts respeitam FKs; a ordem importará.
*/

-- INSERIR RECURSOS (10)
INSERT INTO Recurso (Nome, NumeroRegistro, Cargo, DataAdmissao) VALUES
('Ana Souza', 'REG-1001', 'Gerente de Projeto', '2018-03-15'),
('Bruno Lima', 'REG-1002', 'Analista de Negócios', '2019-06-01'),
('Carla Mendes', 'REG-1003', 'DBA', '2017-11-20'),
('Diego Ferreira', 'REG-1004', 'Programador', '2020-01-10'),
('Eduarda Ramos', 'REG-1005', 'Programador', '2021-05-22'),
('Felipe Costa', 'REG-1006', 'Programador', '2016-09-30'),
('Gabriela Alves', 'REG-1007', 'Analista de Testes', '2018-12-03'),
('Hugo Pereira', 'REG-1008', 'Gerente de Projeto', '2015-02-14'),
('Isabela Rocha', 'REG-1009', 'Programador', '2022-08-01'),
('João Martins', 'REG-1010', 'Infraestrutura', '2014-07-18');

-- INSERIR ENDEREÇOS (10) - vinculados aos RecursoID 1..10
INSERT INTO Endereco (RecursoID, Logradouro, Numero, Complemento, Bairro, Cidade, Estado, CEP) VALUES
(1,'Rua das Flores','123','Apto 12','Centro','São Paulo','SP','01001-000'),
(2,'Av. Brasil','450','Sala 4','Jardins','São Paulo','SP','01440-000'),
(3,'Rua do Sol','78',NULL,'Vila Nova','Campinas','SP','13020-100'),
(4,'Travessa I','9','Casa','Boa Vista','São José dos Campos','SP','12210-200'),
(5,'Rua 7','300','Bloco B','Vila Rica','Ribeirão Preto','SP','14010-300'),
(6,'Av. Central','1000',NULL,'Centro','Santos','SP','11010-400'),
(7,'Rua Azul','55','Apto 3','Pinheiros','São Paulo','SP','05422-010'),
(8,'Rua Verde','210',NULL,'Cambuí','Campinas','SP','13025-200'),
(9,'Alameda 9','12',NULL,'Moema','São Paulo','SP','04509-010'),
(10,'Rua Larga','77','Casa','Centro','São Paulo','SP','01002-000');

-- INSERIR TELEFONES (10) - pelo menos um por recurso (alguns com múltiplos)
INSERT INTO Telefone (RecursoID, TipoTelefone, Numero, Observacao) VALUES
(1,'Comercial','(11)4000-1001','Ramal 101'),
(2,'Celular','(11)9 8800-2002',NULL),
(3,'Residencial','(19)3400-3003',NULL),
(4,'Celular','(12)9 9900-4004','Urgência'),
(5,'Comercial','(16)3200-5005','Horário comercial'),
(6,'Celular','(13)9 7700-6006',NULL),
(7,'Comercial','(11)3500-7007',NULL),
(8,'Residencial','(19)3800-8008',NULL),
(9,'Celular','(11)9 6600-9009',NULL),
(10,'Comercial','(11)3300-1010','Suporte infra');

-- INSERIR SALÁRIO HISTÓRICO (10) - cada recurso tem um registro inicial
INSERT INTO SalarioHistorico (RecursoID, DataAlteracao, Salario, Observacao) VALUES
(1,'2018-03-15',12000.00,'Admissão'),
(2,'2019-06-01',7000.00,'Admissão'),
(3,'2017-11-20',9000.00,'Admissão'),
(4,'2020-01-10',4500.00,'Admissão'),
(5,'2021-05-22',4600.00,'Admissão'),
(6,'2016-09-30',5000.00,'Admissão'),
(7,'2018-12-03',4200.00,'Admissão'),
(8,'2015-02-14',13000.00,'Admissão'),
(9,'2022-08-01',4300.00,'Admissão'),
(10,'2014-07-18',6000.00,'Admissão');

-- INSERIR FERRAMENTAS (10)
INSERT INTO Ferramenta (Nome) VALUES
('Java'),
('C#'),
('Python'),
('SQL Server Management Studio'),
('Oracle DB'),
('VS Code'),
('Git'),
('React'),
('Angular'),
('Docker');

-- INSERIR PROGRAMADORFERRAMENTA (10) - mapeando programadores (RecursoID 4,5,6,9 são programadores; repetiremos até 10 linhas)
INSERT INTO ProgramadorFerramenta (RecursoID, FerramentaID, Versao, NivelExperiencia) VALUES
(4,1,'11', 'Intermediário'), -- Diego -> Java
(4,6,'1.78','Avançado'),      -- Diego -> VS Code
(5,3,'3.9','Intermediário'),  -- Eduarda -> Python
(5,6,'1.80','Intermediário'),
(6,2,'8.0','Avançado'),       -- Felipe -> C#
(6,7,'2.34','Avançado'),      -- Git
(9,8,'18','Básico'),         -- Isabela -> React
(9,6,'1.75','Básico'),
(4,7,'2.28','Intermediário'),
(5,1,'8','Básico');

-- INSERIR EQUIPES (10) - criaremos 5 equipes e repetiremos nomes para chegar a 10 registros
INSERT INTO Equipe (Nome, NumeroRecursosPrev) VALUES
('Equipe Alfa',5),
('Equipe Beta',4),
('Equipe Gama',6),
('Equipe Delta',3),
('Equipe Sigma',4),
('Equipe Teta',5),
('Equipe Kappa',4),
('Equipe Lambda',6),
('Equipe Ómega',3),
('Equipe Pi',4);

-- INSERIR PROJETOS (10)
INSERT INTO Projeto (Codigo, Nome, DataInicio, DataPrevFim, DataFimReal, Status, HorasPrevistas, HorasReais, EquipeID, GerenteRecursoID) VALUES
('P-001','Portal Corporativo','2023-01-10','2023-06-30',NULL,'Em andamento',1200,NULL,1,1),
('P-002','Sistema Financeiro','2022-03-01','2022-12-31','2022-11-25','Finalizado',2000,2100,2,8),
('P-003','App Mobile','2024-02-20','2024-10-01',NULL,'Em andamento',1500,NULL,3,1),
('P-004','Migração DB','2021-05-01','2021-08-31','2021-08-20','Finalizado',400,380,3,3),
('P-005','Plataforma e-Learning','2023-09-01','2024-03-01',NULL,'Aguardando prioridade',800,NULL,4,8),
('P-006','API de Pagamento','2022-07-10','2022-11-10','2022-11-05','Finalizado',600,610,5,1),
('P-007','Ferramenta Interna','2024-05-01','2024-12-01',NULL,'Em andamento',900,NULL,6,8),
('P-008','Relatórios Gerenciais','2020-02-01','2020-07-30','2020-07-15','Finalizado',500,520,7,3),
('P-009','Portal RH','2024-09-01','2025-02-28',NULL,'Em andamento',1100,NULL,8,1),
('P-010','Integração Microserviços','2023-04-01','2023-10-01',NULL,'Em andamento',1300,NULL,9,8);

-- INSERIR ATIVIDADES (10)
INSERT INTO Atividade (Codigo, Nome) VALUES
('A-001','Levantamento de Requisitos'),
('A-002','Modelagem de Dados'),
('A-003','Desenvolvimento Backend'),
('A-004','Desenvolvimento Frontend'),
('A-005','Testes Unitários'),
('A-006','Testes de Integração'),
('A-007','Implantação'),
('A-008','Treinamento'),
('A-009','Documentação'),
('A-010','Ajustes Pós-Entrega');

-- INSERIR PROJETO_ATIVIDADE (10) - mapeamentos diversos
INSERT INTO ProjetoAtividade (ProjetoID, AtividadeID) VALUES
(1,1),(1,2),(1,4),(2,1),(2,3),(3,3),(3,4),(4,2),(4,7),(5,8);

-- INSERIR TAREFAS (10)
INSERT INTO Tarefa (AtividadeID, Codigo, Descricao) VALUES
(1,'T-001','Entrevistar stakeholders e coletar requisitos iniciais'),
(2,'T-002','Criar diagrama ER e documentação de modelo lógico'),
(3,'T-003','Desenvolver endpoints CRUD principais'),
(4,'T-004','Implementar páginas de cadastro e login'),
(5,'T-005','Criar testes unitários para camada de serviço'),
(6,'T-006','Executar testes de integração com serviços externos'),
(7,'T-007','Configurar ambiente de produção e deploy'),
(8,'T-008','Preparar material de treinamento e ministrar sessões'),
(9,'T-009','Gerar documentação técnica e manuais de usuário'),
(10,'T-010','Corrigir bugs reportados no pós-implantação');

SELECT p.ProjetoID, p.Codigo, p.Nome AS ProjetoNome, p.Status, e.Nome AS EquipeNome,
r.Nome AS GerenteNome, p.DataInicio, p.DataPrevFim, p.DataFimReal
FROM Projeto p
JOIN Equipe e ON p.EquipeID = e.EquipeID
JOIN Recurso r ON p.GerenteRecursoID = r.RecursoID;

SELECT rec.RecursoID, rec.Nome AS RecursoNome, f.Nome AS Ferramenta, pf.Versao, pf.NivelExperiencia
FROM ProgramadorFerramenta pf
JOIN Recurso rec ON pf.RecursoID = rec.RecursoID
JOIN Ferramenta f ON pf.FerramentaID = f.FerramentaID
WHERE rec.Cargo LIKE '%Programador%'
ORDER BY rec.Nome;

SELECT r.RecursoID, r.Nome, s.DataAlteracao, s.Salario, s.Observacao
FROM SalarioHistorico s
JOIN Recurso r ON s.RecursoID = r.RecursoID
ORDER BY r.RecursoID, s.DataAlteracao;

SELECT p.ProjetoID, p.Nome AS ProjetoNome, a.AtividadeID, a.Codigo, a.Nome AS AtividadeNome
FROM ProjetoAtividade pa
JOIN Projeto p ON pa.ProjetoID = p.ProjetoID
JOIN Atividade a ON pa.AtividadeID = a.AtividadeID
WHERE p.ProjetoID = 1;

SELECT t.TarefaID, t.Codigo, t.Descricao, a.Nome AS AtividadeNome
FROM Tarefa t
JOIN Atividade a ON t.AtividadeID = a.AtividadeID
WHERE t.AtividadeID = 3;

