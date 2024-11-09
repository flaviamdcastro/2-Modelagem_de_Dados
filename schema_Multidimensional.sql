-- Criação do banco de dados
CREATE DATABASE EleicoesDW
GO

-- Seleção do banco de dados
USE EleicoesDW
GO

-- Configuração de charset e collation
ALTER DATABASE EleicoesDW COLLATE Latin1_General_CI_AS
GO

-- Criação da Tabela de Fatos (Fato_Votacao)
CREATE TABLE Fato_Votacao (
    SQ_CANDIDATO INT NOT NULL,
    CD_ELEICAO INT NOT NULL,
    CD_CARGO SMALLINT NOT NULL,
    CD_MUNICIPIO INT NOT NULL,
    NR_TURNO TINYINT NOT NULL,
    QT_VOTOS_NOMINAIS INT NOT NULL,
    QT_VOTOS_VALIDOS INT NOT NULL,
    ST_VOTO_EM_TRANSITO BIT NOT NULL DEFAULT 0,
    CD_SIT_TOT_TURNO SMALLINT NOT NULL,
    DS_SIT_TOT_TURNO VARCHAR(50),
    PRIMARY KEY (SQ_CANDIDATO, CD_ELEICAO, CD_CARGO, CD_MUNICIPIO, NR_TURNO),
    FOREIGN KEY (SQ_CANDIDATO) REFERENCES Dim_Candidato(SQ_CANDIDATO),
    FOREIGN KEY (CD_ELEICAO) REFERENCES Dim_Eleicao(CD_ELEICAO),
    FOREIGN KEY (CD_CARGO) REFERENCES Dim_Cargo(CD_CARGO),
    FOREIGN KEY (CD_MUNICIPIO) REFERENCES Dim_Municipio(CD_MUNICIPIO)
);
GO

-- Criação das Dimensões
CREATE TABLE Dim_Candidato (
    SQ_CANDIDATO INT PRIMARY KEY,
    NM_CANDIDATO VARCHAR(100) NOT NULL,
    NM_URNA_CANDIDATO VARCHAR(50),
    NM_SOCIAL_CANDIDATO VARCHAR(50),
    NR_CPF_CANDIDATO CHAR(11),
    DS_EMAIL VARCHAR(100),
    DT_NASCIMENTO DATE,
    NR_TITULO_ELEITORAL_CANDIDATO CHAR(12),
    CD_GENERO TINYINT CHECK (CD_GENERO IN (2, 4)),
    CD_GRAU_INSTRUCAO TINYINT,
    CD_ESTADO_CIVIL TINYINT,
    CD_COR_RACA TINYINT,
    CD_OCUPACAO INT,
    DS_OCUPACAO VARCHAR(50),
    SG_PARTIDO CHAR(5),
    SQ_COLIGACAO INT,
    FOREIGN KEY (SG_PARTIDO) REFERENCES Dim_Partido(SG_PARTIDO),
    FOREIGN KEY (SQ_COLIGACAO) REFERENCES Dim_Coligacao(SQ_COLIGACAO)
);
GO

CREATE TABLE Dim_Eleicao (
    CD_ELEICAO INT PRIMARY KEY,
    AA_ELEICAO YEAR NOT NULL,
    DT_ELEICAO DATE,
    CD_TIPO_ELEICAO TINYINT CHECK (CD_TIPO_ELEICAO IN (1, 2, 3)),
    NM_TIPO_ELEICAO VARCHAR(50),
    DS_ELEICAO VARCHAR(100),
    TP_ABRANGENCIA VARCHAR(20) CHECK (TP_ABRANGENCIA IN ('Municipal', 'Estadual', 'Federal'))
);
GO

CREATE TABLE Dim_Cargo (
    CD_CARGO SMALLINT PRIMARY KEY,
    DS_CARGO VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Dim_Partido (
    SG_PARTIDO CHAR(5) PRIMARY KEY,
    NR_PARTIDO SMALLINT UNIQUE NOT NULL,
    NM_PARTIDO VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Dim_Coligacao (
    SQ_COLIGACAO INT PRIMARY KEY,
    NM_COLIGACAO VARCHAR(100),
    DS_COMPOSICAO_COLIGACAO VARCHAR(200)
);
GO

CREATE TABLE Dim_Municipio (
    CD_MUNICIPIO INT PRIMARY KEY,
    NM_MUNICIPIO VARCHAR(100) NOT NULL,
    SG_UF CHAR(2) NOT NULL
);
GO

CREATE TABLE Dim_Tempo (
    Data DATE PRIMARY KEY,
    Ano AS YEAR(Data),
    Mes AS MONTH(Data),
    Dia AS DAY(Data)
);
GO

-- Índices para otimização de consultas
CREATE INDEX idx_candidato_nome ON Dim_Candidato (NM_CANDIDATO);
CREATE INDEX idx_municipio_nome ON Dim_Municipio (NM_MUNICIPIO);
CREATE INDEX idx_eleicao_tipo ON Dim_Eleicao (CD_TIPO_ELEICAO);
CREATE INDEX idx_cargo_descricao ON Dim_Cargo (DS_CARGO);

-- Comentários de Documentação
EXEC sp_addextendedproperty 'MS_Description', 'Tabela Fato que armazena a votação dos candidatos por eleição e município', 'SCHEMA', 'dbo', 'TABLE', 'Fato_Votacao';
EXEC sp_addextendedproperty 'MS_Description', 'Tabela Dimensão que armazena informações dos candidatos', 'SCHEMA', 'dbo', 'TABLE', 'Dim_Candidato';
EXEC sp_addextendedproperty 'MS_Description', 'Tabela Dimensão que armazena informações das eleições', 'SCHEMA', 'dbo', 'TABLE', 'Dim_Eleicao';
EXEC sp_addextendedproperty 'MS_Description', 'Tabela Dimensão que armazena informações dos cargos', 'SCHEMA', 'dbo', 'TABLE', 'Dim_Cargo';
EXEC sp_addextendedproperty 'MS_Description', 'Tabela Dimensão que armazena informações dos partidos', 'SCHEMA', 'dbo', 'TABLE', 'Dim_Partido';
EXEC sp_addextendedproperty 'MS_Description', 'Tabela Dimensão que armazena informações das coligações', 'SCHEMA', 'dbo', 'TABLE', 'Dim_Coligacao';
EXEC sp_addextendedproperty 'MS_Description', 'Tabela Dimensão que armazena informações dos municípios', 'SCHEMA', 'dbo', 'TABLE', 'Dim_Municipio';
EXEC sp_addextendedproperty 'MS_Description', 'Tabela Dimensão que armazena informações de tempo', 'SCHEMA', 'dbo', 'TABLE', 'Dim_Tempo';

-- Fim do Script
