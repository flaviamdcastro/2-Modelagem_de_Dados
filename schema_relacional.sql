-- Cria��o do banco de dados
CREATE DATABASE EleicaoDB;
GO

-- Configura��o de uso do banco de dados
USE EleicaoDB;
GO

-- Configura��o de charset e collation padr�o
ALTER DATABASE EleicaoDB COLLATE Latin1_General_CI_AS;
GO

-- Tabela Rede Social
CREATE TABLE Rede_Social (
    SQ_CANDIDATO INT NOT NULL,  -- Identificador do candidato
    NR_ORDEM_REDE_SOCIAL SMALLINT NOT NULL,  -- N�mero da ordem da rede social
    DS_URL VARCHAR(500) NOT NULL,  -- URL do perfil da rede social
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_REDE_SOCIAL),
 
);
GO

-- Tabela Bem do Candidato
CREATE TABLE Bem_Candidato (
    SQ_CANDIDATO INT NOT NULL,  -- Identificador do candidato
    NR_ORDEM_BEM_CANDIDATO SMALLINT NOT NULL,  -- N�mero da ordem do bem
    CD_TIPO_BEM_CANDIDATO INT,  -- C�digo do tipo de bem
    DS_BEM_CANDIDATO VARCHAR(200),  -- Descri��o do bem
    VR_BEM_CANDIDATO DECIMAL(15, 2),  -- Valor do bem
    DT_ULT_ATUAL_BEM_CANDIDATO DATE,  -- Data da �ltima atualiza��o do bem
    HH_ULT_ATUAL_BEM_CANDIDATO TIME,  -- Hora da �ltima atualiza��o do bem
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_BEM_CANDIDATO),
    CHECK (VR_BEM_CANDIDATO >= 0) -- Valor do bem n�o pode ser negativo
);
GO

-- Tabela Elei��o
CREATE TABLE Eleicao (
    CD_ELEICAO INT PRIMARY KEY,  -- C�digo da elei��o
    AA_ELEICAO INT NOT NULL,  -- Ano da elei��o
    DT_ELEICAO DATE NOT NULL,  -- Data da elei��o
    CD_TIPO_ELEICAO TINYINT,  -- C�digo do tipo de elei��o
    NM_TIPO_ELEICAO VARCHAR(50),  -- Nome do tipo de elei��o
    DS_ELEICAO VARCHAR(100),  -- Descri��o da elei��o
    TP_ABRANGENCIA VARCHAR(20)  -- Abrang�ncia da elei��o (Municipal, Estadual, Federal)
);
GO
-- Tabela Cargo
CREATE TABLE Cargo (
    CD_CARGO SMALLINT PRIMARY KEY,  -- C�digo do cargo
    DS_CARGO VARCHAR(50) NOT NULL  -- Descri��o do cargo
);
GO

-- Tabela Partido
CREATE TABLE Partido (
    SG_PARTIDO CHAR(5) PRIMARY KEY,  -- Sigla do partido
    NR_PARTIDO SMALLINT UNIQUE NOT NULL,  -- N�mero do partido (�nico)
    NM_PARTIDO VARCHAR(50) NOT NULL  -- Nome do partido
);
GO

-- Tabela Coliga��o/Federa��o e Composi��o da Coliga��o
CREATE TABLE Coligacao_Federacao (
    SQ_COLIGACAO INT PRIMARY KEY,  -- Sequencial da coliga��o/federa��o
    NM_COLIGACAO VARCHAR(100),  -- Nome da coliga��o/federa��o
);
GO

CREATE TABLE Composicao_Coligacao (
    SQ_COLIGACAO INT NOT NULL,
    SG_PARTIDO CHAR(5) NOT NULL,
    PRIMARY KEY (SQ_COLIGACAO, SG_PARTIDO),
    FOREIGN KEY (SQ_COLIGACAO) REFERENCES Coligacao_Federacao(SQ_COLIGACAO),
    FOREIGN KEY (SG_PARTIDO) REFERENCES Partido(SG_PARTIDO)
);
GO

-- Tabela Munic�pio
CREATE TABLE Municipio (
    CD_MUNICIPIO INT PRIMARY KEY,  -- C�digo do munic�pio
    NM_MUNICIPIO VARCHAR(100) NOT NULL,  -- Nome do munic�pio
    SG_UF CHAR(2) NOT NULL  -- Sigla da unidade federativa
);
GO

-- Tabela Motivo Cassa��o
CREATE TABLE Motivo_Cassacao (
    SQ_CANDIDATO INT NOT NULL,  -- Identificador do candidato
    CD_MOTIVO SMALLINT NOT NULL,  -- C�digo do motivo de cassa��o
    DS_MOTIVO VARCHAR(200),  -- Descri��o do motivo
    TP_MOTIVO VARCHAR(50),  -- Tipo do motivo
    DS_TP_MOTIVO VARCHAR(100),  -- Descri��o do tipo do motivo
    PRIMARY KEY (SQ_CANDIDATO, CD_MOTIVO),
 
);
GO

-- Tabela Candidato
CREATE TABLE Candidato (
    SQ_CANDIDATO INT PRIMARY KEY,  -- Identificador �nico do candidato
    NR_CANDIDATO INT NOT NULL,  -- N�mero do candidato
    NM_CANDIDATO VARCHAR(100) NOT NULL,  -- Nome completo do candidato
    NM_URNA_CANDIDATO VARCHAR(50) NOT NULL,  -- Nome do candidato na urna
    NM_SOCIAL_CANDIDATO VARCHAR(50),  -- Nome social do candidato
    NR_CPF_CANDIDATO CHAR(11) UNIQUE NOT NULL,  -- CPF do candidato (�nico)
    DS_EMAIL VARCHAR(100),  -- Email do candidato
    DT_NASCIMENTO DATE,  -- Data de nascimento do candidato
    NR_TITULO_ELEITORAL_CANDIDATO CHAR(12) UNIQUE,  -- N�mero do t�tulo eleitoral (�nico)
    CD_GENERO TINYINT CHECK (CD_GENERO IN (2, 4)),  -- C�digo do g�nero (2: Masculino, 4: Feminino)
    CD_GRAU_INSTRUCAO TINYINT,  -- C�digo do grau de instru��o
    CD_ESTADO_CIVIL TINYINT,  -- C�digo do estado civil
    CD_COR_RACA TINYINT,  -- C�digo da cor/ra�a
    CD_OCUPACAO INT,  -- C�digo da ocupa��o
    DS_OCUPACAO VARCHAR(50),  -- Descri��o da ocupa��o
    SG_PARTIDO CHAR(5),  -- Sigla do partido
    SQ_COLIGACAO INT,  -- Sequencial da coliga��o
    CD_ELEICAO INT,  -- C�digo da elei��o
    CONSTRAINT FK_Candidato_Partido FOREIGN KEY (SG_PARTIDO) REFERENCES Partido(SG_PARTIDO),
    CONSTRAINT FK_Candidato_Coligacao FOREIGN KEY (SQ_COLIGACAO) REFERENCES Coligacao_Federacao(SQ_COLIGACAO),
    CONSTRAINT FK_Candidato_Eleicao FOREIGN KEY (CD_ELEICAO) REFERENCES Eleicao(CD_ELEICAO)
);
GO

-- Tabela Vota��o
CREATE TABLE Votacao (
    SQ_CANDIDATO INT NOT NULL,  -- Identificador do candidato
    CD_ELEICAO INT NOT NULL,  -- C�digo da elei��o
    CD_MUNICIPIO INT NOT NULL,  -- C�digo do munic�pio
    NR_TURNO TINYINT,  -- N�mero do turno
    NR_ZONA SMALLINT,  -- N�mero da zona eleitoral
    QT_VOTOS_NOMINAIS INT,  -- Quantidade de votos nominais
    QT_VOTOS_NOMINAIS_VALIDOS INT,  -- Quantidade de votos v�lidos
    ST_VOTO_EM_TRANSITO BIT,  -- Indicador de voto em tr�nsito (1 = Sim, 0 = N�o)
    CD_SIT_TOT_TURNO SMALLINT,  -- C�digo da situa��o total do turno
    DS_SIT_TOT_TURNO VARCHAR(50),  -- Descri��o da situa��o total do turno
    PRIMARY KEY (SQ_CANDIDATO, CD_ELEICAO, CD_MUNICIPIO),
    CONSTRAINT FK_Votacao_Candidato FOREIGN KEY (SQ_CANDIDATO) REFERENCES Candidato(SQ_CANDIDATO),
    CONSTRAINT FK_Votacao_Eleicao FOREIGN KEY (CD_ELEICAO) REFERENCES Eleicao(CD_ELEICAO),
    CONSTRAINT FK_Votacao_Municipio FOREIGN KEY (CD_MUNICIPIO) REFERENCES Municipio(CD_MUNICIPIO)
);
GO

-- Adicionar a constraint FOREIGN KEY � tabela Rede Sociais
ALTER TABLE Rede_Social
   ADD CONSTRAINT FK_RedeSocial_Candidato FOREIGN KEY (SQ_CANDIDATO) REFERENCES Candidato(SQ_CANDIDATO);
GO


-- Adicionar a constraint FOREIGN KEY � tabela Bem do Candidato
ALTER TABLE Bem_Candidato
   ADD CONSTRAINT FK_BemCandidato_Candidato FOREIGN KEY (SQ_CANDIDATO) REFERENCES Candidato(SQ_CANDIDATO);
GO

-- Adicionar a constraint FOREIGN KEY � tabela Bem do Candidato
ALTER TABLE Bem_Candidato
   ADD CONSTRAINT FK_MotivoCassacao_Candidato FOREIGN KEY (SQ_CANDIDATO) REFERENCES Candidato(SQ_CANDIDATO)
GO

-- �ndices para otimiza��o das consultas
CREATE INDEX IDX_Candidato_NR_CANDIDATO ON Candidato(NR_CANDIDATO);
CREATE INDEX IDX_Candidato_NR_CPF_CANDIDATO ON Candidato(NR_CPF_CANDIDATO);
CREATE INDEX IDX_Eleicao_AA_ELEICAO ON Eleicao(AA_ELEICAO);
CREATE INDEX IDX_Votacao_CD_MUNICIPIO ON Votacao(CD_MUNICIPIO);
