# Project Management Database

Projeto de modelagem e implementação de banco de dados relacional desenvolvido em SQL para gerenciamento corporativo de recursos, equipes, projetos e atividades.

---

## 📚 Sobre o Projeto

Este projeto foi desenvolvido como atividade acadêmica da disciplina de Banco de Dados com o objetivo de aplicar conceitos de modelagem relacional, normalização e implementação de estruturas SQL em um cenário corporativo.

O sistema simula um ambiente empresarial para gerenciamento de:

- Recursos humanos
- Equipes
- Projetos
- Atividades
- Ferramentas
- Histórico salarial
- Telefones
- Endereços
- Tarefas

O banco de dados foi estruturado utilizando relacionamentos 1:1, 1:N e N:N, garantindo integridade e organização dos dados.

---

## 🚀 Funcionalidades

- ✅ Criação completa do banco de dados
- ✅ Estruturação de tabelas relacionais
- ✅ Implementação de chaves primárias e estrangeiras
- ✅ Controle de integridade referencial
- ✅ Relacionamentos entre entidades
- ✅ Inserção de dados para testes
- ✅ Modelagem corporativa escalável

---

## 🛠 Tecnologias Utilizadas

- SQL
- SQL Server
- Modelagem Relacional
- Banco de Dados Relacional

---

## 🧠 Conceitos Aplicados

- DDL (Data Definition Language)
- DML (Data Manipulation Language)
- Chaves Primárias
- Chaves Estrangeiras
- Integridade Referencial
- Relacionamentos:
  - 1:1
  - 1:N
  - N:N
- Normalização
- Modelagem de Dados
- Estruturação Corporativa de Banco de Dados

---

## 🗂 Estrutura do Banco de Dados

O sistema possui as seguintes entidades principais:

```text
Recurso
Endereco
Telefone
SalarioHistorico
Ferramenta
ProgramadorFerramenta
Equipe
Projeto
Atividade
ProjetoAtividade
Tarefa
```

---

## 🔗 Relacionamentos Implementados

| Relacionamento | Tipo |
|---|---|
| Recurso → Endereço | 1:1 |
| Recurso → Telefone | 1:N |
| Recurso → Salário Histórico | 1:N |
| Recurso ↔ Ferramenta | N:N |
| Projeto ↔ Atividade | N:N |
| Atividade → Tarefa | 1:N |

---

## 🗄 Estrutura SQL

O projeto contém:

- Criação do banco de dados
- Criação das tabelas
- Definição de constraints
- Foreign Keys
- Inserção de registros
- Estrutura relacional completa

---

## ▶️ Como Executar

### 1. Clone o repositório

```bash
git clone https://github.com/rodrigoars6/enterprise-database-sql.git
```

### 2. Abra o SQL Server Management Studio

Ou utilize outro gerenciador SQL compatível.

### 3. Execute o script SQL

Abra o arquivo:

```text
APS - BANCO DE DADOS.sql
```

Execute todo o script para:

- Criar o banco
- Criar as tabelas
- Inserir os registros

---

## 📖 Exemplo de Tabelas

### Recurso

```sql
CREATE TABLE Recurso (
    RecursoID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    NumeroRegistro VARCHAR(30) NOT NULL UNIQUE,
    Cargo VARCHAR(60) NOT NULL,
    DataAdmissao DATE NULL
);
```

### Projeto

```sql
CREATE TABLE Projeto (
    ProjetoID INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(30) NOT NULL UNIQUE,
    Nome VARCHAR(200) NOT NULL
);
```

---

## 🎓 Objetivo Acadêmico

Este projeto teve como objetivo aplicar na prática os conceitos de:

- Banco de Dados Relacional
- Modelagem de Dados
- SQL
- Integridade Referencial
- Estruturação de sistemas corporativos
- Organização de entidades e relacionamentos

---

## 👨‍💻 Autor

Rodrigo Araújo

---

## 📌 Status do Projeto

✅ Finalizado
