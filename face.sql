DROP TABLE USUARIO;

DROP TABLE AMIZADE;

DROP TABLE ASSUNTO;

DROP TABLE ASSUNTOPOST;

DROP TABLE CITACAO;

DROP TABLE REACAO;

DROP TABLE COMPARTILHAMENTO;

DROP TABLE POST;

CREATE TABLE USUARIO(
    EMAIL CHAR (100) NOT NULL,
    NOME CHAR(100) NOT NULL,
    DATACADASTRO DATETIME,
    CIDADE CHAR(100),
    PAIS CHAR(100),
    UF CHAR(100),
    DATAULTIMOPOST DATETIME,
    TOTALAMIGOS INTEGER,
    PRIMARY KEY (CODIGO)
);

CREATE TABLE AMIZADE(
    EMAIL_USUARIO1 CHAR (100) NOT NULL,
    EMAIL_USUARIO2 CHAR (100) NOT NULL,
    DATAAMIZADE DATETIME,
    FOREIGN KEY (EMAIL_USUARIO1) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (EMAIL_USUARIO2) REFERENCES USUARIO(EMAIL),
    PRIMARY KEY (EMAIL_USUARIO1, EMAIL_USUARIO2)
);

CREATE TABLE ASSUNTO(
    CODIGO INTEGER NOT NULL,
    ASSUNTO CHAR(4096),
    PRIMARY KEY (CODIGO)
);

CREATE TABLE ASSUNTOPOST(
    CODIGOASSUNTO INTEGER NOT NULL,
    CODIGOPOST INTEGER NOT NULL,
    FOREIGN KEY (CODIGOASSUNTO) REFERENCES ASSUNTO(CODIGO),
    FOREIGN KEY (CODIGOPOST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGOASSUNTO, CODIGOPOST)
);

CREATE TABLE CITACAO(
    CODIGO INTEGER NOT NULL,
    COD_POST INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (COD_POST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGO, COD_POST, EMAIL_USUARIO)
);

CREATE TABLE REACAO(
    CODIGO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    TIPOREACAO CHAR(10) NOT NULL,
    COD_POST INTEGER NOT NULL,
    CIDADE CHAR(100) NOT NULL,
    UF CHAR(2) NOT NULL,
    PAIS CHAR(100) NOT NULL,
    DATAREACAO DATETIME,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (COD_POST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGO)
);

CREATE TABLE COMPARTILHAMENTO(
    CODIGO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    COD_POST INTEGER NOT NULL,
    CIDADE CHAR(100) NOT NULL,
    UF CHAR(2) NOT NULL,
    DATACOMPARTILHAMENTO DATETIME,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (COD_POST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGO)
);

CREATE TABLE POST(
    CODIGO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    POST CHAR(1000) NOT NULL,
    CIDADE CHAR (100) NOT NULL,
    UF CHAR (100) NOT NULL,
    PAIS CHAR (100) NOT NULL,
    DATAPOST DATETIME,
    CODPOSTREFERENCIA INTEGER,
    QTDREACOES INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (CODPOSTREFERENCIA) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGO)
);

INSERT INTO
    USUARIO(
        CODIGO,
        NOME,
        DATACADASTRO,
        CIDADE,
        PAIS,
        UF,
        DATAULTIMOPOST,
        TOTALAMIGOS
    )
VALUES
    (
        1,
        'Professor de BD',
        '2010-01-01 09:00:00',
        'Rio Grande',
        'Brasil',
        'RS',
        '2021-06-02 15:35:00',
        5
    ),
    (
        2,
        'João Silva Brasil',
        '2020-01-01 13:00:00',
        'Rio Grande',
        'Brasil',
        'RS',
        '2021-06-02 15:30:00',
        2
    ),
    (
        3,
        'Pedro Alencar Pereira',
        '2020-01-01 13:05:00',
        'Rio Grande',
        'Brasil',
        'RS',
        null,
        2
    ),
    (
        4,
        'Maria Cruz Albuquerque',
        '2020-01-01 13:10:00',
        'Rio Grande',
        'Brasil',
        'RS',
        null,
        1
    ),
    (
        5,
        'Joana Rosa Medeiros',
        '2020-01-01 13:15:00',
        'Rio Grande',
        'Brasil',
        'RS',
        '2021-06-02 15:15:00',
        1
    ),
    (
        6,
        'Paulo Xavier Ramos',
        '2020-01-01 13:20:00',
        'Rio Grande',
        'Brasil',
        'RS',
        '2021-06-02 15:20:00',
        1
    ),
    (
        7,
        'IFRS campus Rio Grande',
        null,
        'Rio Grande',
        'Brasil',
        'RS',
        null,
        0
    );

INSERT INTO
    AMIZADE(CODIGOUSUARIO1, CODIGOUSUARIO2, DATAAMIZADE)
VALUES
    (1, 2, '2021-05-17 10:00:00'),
    (1, 3, '2021-05-17 10:05:00'),
    (1, 4, '2021-05-17 10:10:00'),
    (1, 5, '2021-05-17 10:15:00'),
    (2, 3, '2021-05-17 10:15:00'),
    (1, 6, '2021-05-17 10:20:00');

INSERT INTO
    POST(
        CODIGO,
        EMAIL_USUARIO,
        POST,
        CIDADE,
        UF,
        PAIS,
        DATAPOST,
        CODPOSTREFERENCIA,
        QTDREACOES
    )
VALUES
    (
        1,
        2,
        'Hoje eu aprendi como inserir dados no SQLite no IFRS',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:00:00',
        null,
        2
    ),
    (
        2,
        1,
        'Atendimento de BD no GMeet amanhã para quem tiver dúvidas de INSERT',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:35:00',
        null,
        0
    ),
    (
        3,
        5,
        'Alguém mais ficou com dúvida no comando INSERT?',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:15:00',
        1,
        1
    ),
    (
        4,
        6,
        'Eu também',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:20:00',
        3,
        0
    ),
    (
        5,
        2,
        'Já agendaste horário de atendimento com o professor?',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:30:00',
        4,
        0
    );

INSERT INTO
    ASSUNTO(CODIGO, ASSUNTO)
VALUES
    (1, 'BD'),
    (2, 'SQLite'),
    (3, 'INSERT'),
    (4, 'atendimento');

INSERT INTO
    ASSUNTOPOST (CODIGOPOST, CODIGOASSUNTO)
VALUES
    (1, 1),
    (1, 2),
    (3, 1),
    (3, 2),
    (3, 3),
    (5, 4),
    (5, 1),
    (2, 4),
    (2, 1),
    (2, 2),
    (2, 3);

INSERT INTO
    CITACAO (CODIGO, COD_POST, EMAIL_USUARIO)
VALUES
    (1, 1, 7),
    (2, 2, 5),
    (3, 2, 6);

INSERT INTO
    REACAO(
        CODIGO,
        TIPOREACAO,
        EMAIL_USUARIO,
        CIDADE,
        UF,
        PAIS,
        COD_POST,
        DATAREACAO
    )
values
    (
        1,
        'Curtida',
        3,
        'Rio Grande',
        'RS',
        'Brasil',
        1,
        '2021-06-02 15:05:00'
    ),
    (
        2,
        'Curtida',
        4,
        'Rio Grande',
        'RS',
        'Brasil',
        1,
        '2021-06-02 15:10:00'
    ),
    (
        3,
        'Triste',
        6,
        'Rio Grande',
        'RS',
        'Brasil',
        3,
        '2021-06-02 15:20:00'
    );

INSERT INTO
    COMPARTILHAMENTO(
        CODIGO,
        EMAIL_USUARIO,
        COD_POST,
        CIDADE,
        UF,
        DATACOMPARTILHAMENTO
    )
VALUES
    (
        1,
        2,
        2,
        'Rio Grande',
        'RS',
        '2021-06-02 15:40:00'
    );

