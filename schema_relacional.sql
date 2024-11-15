-- Criação do banco de dados
CREATE DATABASE EleicaoDB;
GO

-- Configuração de uso do banco de dados
USE EleicaoDB;
GO

-- Configuração de charset e collation padrão
ALTER DATABASE EleicaoDB COLLATE Latin1_General_CI_AS;
GO

-- Tabela Rede Social
CREATE TABLE Rede_Social (
    SQ_CANDIDATO INT NOT NULL,  -- Identificador do candidato
    NR_ORDEM_REDE_SOCIAL SMALLINT NOT NULL,  -- Número da ordem da rede social
    DS_URL VARCHAR(500) NOT NULL,  -- URL do perfil da rede social
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_REDE_SOCIAL),
 
);
GO

-- Tabela Bem do Candidato
CREATE TABLE Bem_Candidato (
    SQ_CANDIDATO INT NOT NULL,  -- Identificador do candidato
    NR_ORDEM_BEM_CANDIDATO SMALLINT NOT NULL,  -- Número da ordem do bem
    CD_TIPO_BEM_CANDIDATO INT,  -- Código do tipo de bem
    DS_BEM_CANDIDATO VARCHAR(200),  -- Descrição do bem
    VR_BEM_CANDIDATO DECIMAL(15, 2),  -- Valor do bem
    DT_ULT_ATUAL_BEM_CANDIDATO DATE,  -- Data da última atualização do bem
    HH_ULT_ATUAL_BEM_CANDIDATO TIME,  -- Hora da última atualização do bem
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_BEM_CANDIDATO),
    CHECK (VR_BEM_CANDIDATO >= 0) -- Valor do bem não pode ser negativo
);
GO

-- Tabela Eleição
CREATE TABLE Eleicao (
    CD_ELEICAO INT PRIMARY KEY,  -- Código da eleição
    AA_ELEICAO INT NOT NULL,  -- Ano da eleição
    DT_ELEICAO DATE NOT NULL,  -- Data da eleição
    CD_TIPO_ELEICAO TINYINT,  -- Código do tipo de eleição
    NM_TIPO_ELEICAO VARCHAR(50),  -- Nome do tipo de eleição
    DS_ELEICAO VARCHAR(100),  -- Descrição da eleição
    TP_ABRANGENCIA VARCHAR(20)  -- Abrangência da eleição (Municipal, Estadual, Federal)
);
GO
-- Tabela Cargo
CREATE TABLE Cargo (
    CD_CARGO SMALLINT PRIMARY KEY,  -- Código do cargo
    DS_CARGO VARCHAR(50) NOT NULL  -- Descrição do cargo
);
GO

-- Tabela Partido
CREATE TABLE Partido (
    SG_PARTIDO CHAR(5) PRIMARY KEY,  -- Sigla do partido
    NR_PARTIDO SMALLINT UNIQUE NOT NULL,  -- Número do partido (único)
    NM_PARTIDO VARCHAR(50) NOT NULL  -- Nome do partido
);
GO

-- Tabela Coligação/Federação e Composição da Coligação
CREATE TABLE Coligacao_Federacao (
    SQ_COLIGACAO INT PRIMARY KEY,  -- Sequencial da coligação/federação
    NM_COLIGACAO VARCHAR(100),  -- Nome da coligação/federação
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

-- Tabela Município
CREATE TABLE Municipio (
    CD_MUNICIPIO INT PRIMARY KEY,  -- Código do município
    NM_MUNICIPIO VARCHAR(100) NOT NULL,  -- Nome do município
    SG_UF CHAR(2) NOT NULL  -- Sigla da unidade federativa
);
GO

-- Tabela Motivo Cassação
CREATE TABLE Motivo_Cassacao (
    SQ_CANDIDATO INT NOT NULL,  -- Identificador do candidato
    CD_MOTIVO SMALLINT NOT NULL,  -- Código do motivo de cassação
    DS_MOTIVO VARCHAR(200),  -- Descrição do motivo
    TP_MOTIVO VARCHAR(50),  -- Tipo do motivo
    DS_TP_MOTIVO VARCHAR(100),  -- Descrição do tipo do motivo
    PRIMARY KEY (SQ_CANDIDATO, CD_MOTIVO),
 
);
GO

-- Tabela Candidato
CREATE TABLE Candidato (
    SQ_CANDIDATO INT PRIMARY KEY,  -- Identificador único do candidato
    NR_CANDIDATO INT NOT NULL,  -- Número do candidato
    NM_CANDIDATO VARCHAR(100) NOT NULL,  -- Nome completo do candidato
    NM_URNA_CANDIDATO VARCHAR(50) NOT NULL,  -- Nome do candidato na urna
    NM_SOCIAL_CANDIDATO VARCHAR(50),  -- Nome social do candidato
    NR_CPF_CANDIDATO CHAR(11) UNIQUE NOT NULL,  -- CPF do candidato (único)
    DS_EMAIL VARCHAR(100),  -- Email do candidato
    DT_NASCIMENTO DATE,  -- Data de nascimento do candidato
    NR_TITULO_ELEITORAL_CANDIDATO CHAR(12) UNIQUE,  -- Número do título eleitoral (único)
    CD_GENERO TINYINT CHECK (CD_GENERO IN (2, 4)),  -- Código do gênero (2: Masculino, 4: Feminino)
    CD_GRAU_INSTRUCAO TINYINT,  -- Código do grau de instrução
    CD_ESTADO_CIVIL TINYINT,  -- Código do estado civil
    CD_COR_RACA TINYINT,  -- Código da cor/raça
    CD_OCUPACAO INT,  -- Código da ocupação
    DS_OCUPACAO VARCHAR(50),  -- Descrição da ocupação
    SG_PARTIDO CHAR(5),  -- Sigla do partido
    SQ_COLIGACAO INT,  -- Sequencial da coligação
    CD_ELEICAO INT,  -- Código da eleição
    CONSTRAINT FK_Candidato_Partido FOREIGN KEY (SG_PARTIDO) REFERENCES Partido(SG_PARTIDO),
    CONSTRAINT FK_Candidato_Coligacao FOREIGN KEY (SQ_COLIGACAO) REFERENCES Coligacao_Federacao(SQ_COLIGACAO),
    CONSTRAINT FK_Candidato_Eleicao FOREIGN KEY (CD_ELEICAO) REFERENCES Eleicao(CD_ELEICAO)
);
GO

-- Tabela Votação
CREATE TABLE Votacao (
    SQ_CANDIDATO INT NOT NULL,  -- Identificador do candidato
    CD_ELEICAO INT NOT NULL,  -- Código da eleição
    CD_MUNICIPIO INT NOT NULL,  -- Código do município
    NR_TURNO TINYINT,  -- Número do turno
    NR_ZONA SMALLINT,  -- Número da zona eleitoral
    QT_VOTOS_NOMINAIS INT,  -- Quantidade de votos nominais
    QT_VOTOS_NOMINAIS_VALIDOS INT,  -- Quantidade de votos válidos
    ST_VOTO_EM_TRANSITO BIT,  -- Indicador de voto em trânsito (1 = Sim, 0 = Não)
    CD_SIT_TOT_TURNO SMALLINT,  -- Código da situação total do turno
    DS_SIT_TOT_TURNO VARCHAR(50),  -- Descrição da situação total do turno
    PRIMARY KEY (SQ_CANDIDATO, CD_ELEICAO, CD_MUNICIPIO),
    CONSTRAINT FK_Votacao_Candidato FOREIGN KEY (SQ_CANDIDATO) REFERENCES Candidato(SQ_CANDIDATO),
    CONSTRAINT FK_Votacao_Eleicao FOREIGN KEY (CD_ELEICAO) REFERENCES Eleicao(CD_ELEICAO),
    CONSTRAINT FK_Votacao_Municipio FOREIGN KEY (CD_MUNICIPIO) REFERENCES Municipio(CD_MUNICIPIO)
);
GO

-- Adicionar a constraint FOREIGN KEY à tabela Rede Sociais
ALTER TABLE Rede_Social
   ADD CONSTRAINT FK_RedeSocial_Candidato FOREIGN KEY (SQ_CANDIDATO) REFERENCES Candidato(SQ_CANDIDATO);
GO


-- Adicionar a constraint FOREIGN KEY à tabela Bem do Candidato
ALTER TABLE Bem_Candidato
   ADD CONSTRAINT FK_BemCandidato_Candidato FOREIGN KEY (SQ_CANDIDATO) REFERENCES Candidato(SQ_CANDIDATO);
GO

-- Adicionar a constraint FOREIGN KEY à tabela Bem do Candidato
ALTER TABLE Bem_Candidato
   ADD CONSTRAINT FK_MotivoCassacao_Candidato FOREIGN KEY (SQ_CANDIDATO) REFERENCES Candidato(SQ_CANDIDATO)
GO

-- Índices para otimização das consultas
CREATE INDEX IDX_Candidato_NR_CANDIDATO ON Candidato(NR_CANDIDATO);
CREATE INDEX IDX_Candidato_NR_CPF_CANDIDATO ON Candidato(NR_CPF_CANDIDATO);
CREATE INDEX IDX_Eleicao_AA_ELEICAO ON Eleicao(AA_ELEICAO);
CREATE INDEX IDX_Votacao_CD_MUNICIPIO ON Votacao(CD_MUNICIPIO);
