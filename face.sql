/*
o email virou pk do usuario, antes era usuado codigo;
Criamos uma table grupo;
Colocamos genero e data de nascimento para os usuarios;
Foi acrescentado os novos usuarios;
Retiramos a  coluna na tabela de usuário que totaliza a quantidade de amigos
do usuario para que não seja acessada mais de uma tabela para receber essa informação e logo depois trata-la ;
Retiramos o campo (qtdReacoes);
Retiramos o campo (dataUltimoPost);
*/


DROP TABLE USUARIO;

DROP TABLE AMIZADE;

DROP TABLE ASSUNTO;

DROP TABLE ASSUNTOPOST;

DROP TABLE CITACAO;

DROP TABLE REACAO;

DROP TABLE COMPARTILHAMENTO;

DROP TABLE POST;

DROP TABLE GRUPO;

DROP TABLE GRUPOUSUARIO;


CREATE TABLE USUARIO(
    EMAIL CHAR (100) NOT NULL,
    NOME CHAR(100) NOT NULL,
    DATACADASTRO DATETIME,
    CIDADE CHAR(100),
    PAIS CHAR(100),
    UF CHAR(100),
    GENERO char (1),
    NASCIMENTO date,
    PRIMARY KEY (EMAIL)
);

CREATE TABLE GRUPO(
    CODIGO INTEGER NOT NULL,
    NOMEGRUPO CHAR(100) NOT NULL, 
    PRIMARY KEY(CODIGO)
);

CREATE TABLE GRUPOUSUARIO(
    CODIGOGRUPO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    PRIMARY KEY (CODIGOGRUPO, EMAIL_USUARIO)
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
CODIGOGRUPO INTEGER,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (CODPOSTREFERENCIA) REFERENCES POST(CODIGO),
    FOREIGN KEY (CODIGOGRUPO) REFERENCES GRUPO(CODIGO),
    PRIMARY KEY (CODIGO)
);

    INSERT INTO 
    GRUPO(
        CODIGO,
        NOMEGRUPO
    )
    VALUES
    (
        1,
        'SQLite'
    ),
    (
        2,
        'Banco de Dados-IFRS-2021'
    );

INSERT INTO
    USUARIO(
        EMAIL,
        NOME,
        DATACADASTRO,
        CIDADE,
        PAIS,
        UF,
        GENERO,
        NASCIMENTO
    )
VALUES
    (
        'joaosbras@mymail.com',
        'João Silva Brasil',
        '2020-01-01 13:00:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'M',
        '1998-02-02'
    ),
    (
        'pmartinssilva90@mymail.com',
        'Paulo Martins Silva',
        null,
        null,
        null,
        null,
        'M',
        '2003-05-23'
    ),
    (
        'mcalbuq@mymail.com',
        'Maria Cruz Albuquerque',
        '2020-01-01 13:10:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'F',
        '2002-11-04'
    ),
    (
        'jorosamed@mymail.com',
        'Joana Rosa Medeiros',
        '2020-01-01 13:15:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'N',
        '1974-02-05'
    ),
    (
        'pxramos@mymail.com',
        'Paulo Xavier Ramos',
        '2020-01-01 13:20:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'N',
        '1966-03-30'
    ),
    (
        'pele@cbf.com.br',
        'Edson Arantes do Nascimento',
        null,
        'Três Corações',
        'Brasil',
        'MG',
        'M',
        '1940-10-23'
    );

INSERT INTO
    AMIZADE(EMAIL_USUARIO1, EMAIL_USUARIO2, DATAAMIZADE)
VALUES
    ('pxramos@mymail.com','jorosamed@mymail.com', '2021-05-17 10:15:00'),
    ('jorosamed@mymail.com', 'pele@cbf.com.br', '2021-05-17 10:15:00'),
    ('mcalbuq@mymail.com', 'pele@cbf.com.br', '2021-05-17 10:20:00' ),
    ( 'jorosamed@mymail.com','mcalbuq@mymail.com','2021-05-17 10:20:00' );
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
        QTDREACOES,
        CODIGOGRUPO
    )
VALUES
    (
        1,
        'joaosbras@mymail.com',
        'Hoje eu aprendi como inserir dados no SQLite no IFRS',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:00:00',
        null,
        2,
        null
    ),
    (
        3,
        'jorosamed@mymail.com',
        'Alguém mais ficou com dúvida no comando INSERT?',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:15:00',
        1,
        1,
        1
    ),
    (
        4,
        'pxramos@mymail.com',
        'Eu também',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:20:00',
        3,
        0,
        null
    ),
    (
        5,
        'joaosbras@mymail.com',
        'Já agendaste horário de atendimento com o professor?',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:30:00',
        4,
        0,
        null
    ),
    (
        6,
        'pmartinssilva90@mymail.com',
        'Ontem aprendi sobre joins no SQLite na disciplina de banco de dados do IFRS.',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-08 18:30:00',
        null,
        0,
        null
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
    (6, 1),
    (6, 2);

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
        2,
        'Curtida',
        'mcalbuq@mymail.com',
        'Rio Grande',
        'RS',
        'Brasil',
        1,
        '2021-06-02 15:10:00'
    ),
    (
        3,
        'Triste',
        'pxramos@mymail.com',
        'Rio Grande',
        'RS',
        'Brasil',
        3,
        '2021-06-02 15:20:00'
    );


INSERT INTO
    GRUPOUSUARIO(
        CODIGOGRUPO,
        EMAIL_USUARIO
    )
values
    (2,
    'pxramos@mymail.com'),
    (2,
    'mcalbuq@mymail.com');
    

INSERT INTO COMPARTILHAMENTO(
    CODIGO,
    EMAIL_USUARIO,
    COD_POST,
    CIDADE,
    UF,
    DATACOMPARTILHAMENTO
) VALUES
(
    1, 
    'joaosbras@mymail.com',
    6,
    'Rio Grande',
    'RS', 
    '2021-06-10 13:00:00'
);

--A)
SELECT CASE WHEN USUARIO1.EMAIL= 'mcalbuq@mymail.com' THEN USUARIO2.NOME
ELSE USUARIO1.NOME 
END AS NOME
FROM AMIZADE
JOIN USUARIO USUARIO1 ON AMIZADE.EMAIL_USUARIO1= USUARIO1.EMAIL
JOIN USUARIO USUARIO2 ON AMIZADE.EMAIL_USUARIO2= USUARIO2.EMAIL
WHERE USUARIO1.EMAIL= 'mcalbuq@mymail.com' OR USUARIO2.EMAIL= 'mcalbuq@mymail.com';

--B)


--C)
-- SELECT (POST.QTDREACOES/) FROM ASSUNTO
--     JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
--     JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
--     LEFT JOIN REACAO ON REACAO.COD_POST = POST.CODIGO
-- 	WHERE UPPER(ASSUNTO) = 'BD'; TO FAZENDO

--D)


--E)

SELECT COUNT(POST) POSTS FROM ASSUNTO
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
    JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
    LEFT JOIN REACAO ON REACAO.COD_POST = POST.CODIGO
	WHERE UPPER(ASSUNTO) = 'BD' AND UPPER(REACAO.TIPOREACAO) = 'CURTIDA';

--F)
SELECT ASSUNTO.ASSUNTO AS ASSUNTO, COUNT(ASSUNTO) AS QUANTIDADE FROM ASSUNTO
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
    JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
	WHERE POST.DATAPOST BETWEEN date ('now', '-7 days', 'localtime' ) AND DATE ('now')
GROUP BY ASSUNTO.ASSUNTO
ORDER BY 2 DESC;

--G)
SELECT POST.UF AS ESTADO, COUNT(*) AS QUANTIDADE FROM POST
WHERE POST.PAIS = 'Brasil' AND POST.DATAPOST BETWEEN date ('now', '-3 months', 'localtime' ) 
AND DATE ('now') 
GROUP BY ESTADO
ORDER BY 2 ASC;

--H)
SELECT POST.POST AS POST, COUNT(*) AS QUANTIDADE FROM POST
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
    JOIN ASSUNTO ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
WHERE  ASSUNTO = 'BD' 
    AND PAIS = 'Brasil' 
    AND POST.DATAPOST BETWEEN date ('now', '-3 months', 'localtime' ) 
    AND DATE ('now')
    GROUP BY POST
    ORDER BY DATAPOST;
--I)

SELECT USUARIO.NOME AS NOME, COUNT(REACAO.CODIGO) AS QUANTIDADE FROM POST 
JOIN REACAO ON POST.CODIGO= REACAO.COD_POST
JOIN USUARIO ON POST.EMAIL_USUARIO=USUARIO.EMAIL
WHERE REACAO.DATAREACAO BETWEEN date ('now', '-30 days', 'localtime' ) 
    AND DATE ('now')
    AND USUARIO.PAIS = 'Brasil'
    GROUP BY POST
    ORDER BY QUANTIDADE;
--J)
SELECT COUNT (COD_POST) AS QUANTIDADE FROM REACAO


WHERE CODIGOGRUPO = 1
AND POST.DATAPOST BETWEEN date ('now', '-60 days', 'localtime' ) 
AND DATE ('now');
--K)

--L)
SELECT DISTINCT(CASE WHEN UPPER(GRUPOUSUARIO1.NOMEGRUPO)= 'BANCO DE DADOS-IFRS-2021' THEN USUARIO2.NOME
ELSE USUARIO1.NOME END) AS NOME
FROM AMIZADE
LEFT JOIN USUARIO USUARIO1 ON AMIZADE.EMAIL_USUARIO1= USUARIO1.EMAIL
LEFT JOIN USUARIO USUARIO2 ON AMIZADE.EMAIL_USUARIO2= USUARIO2.EMAIL
LEFT JOIN GRUPOUSUARIO GRUPOUSUARIOUSUARIO1 ON USUARIO1.EMAIL = GRUPOUSUARIOUSUARIO1.EMAIL_USUARIO
LEFT JOIN GRUPOUSUARIO GRUPOUSUARIOUSUARIO2 ON USUARIO2.EMAIL = GRUPOUSUARIOUSUARIO2.EMAIL_USUARIO
LEFT JOIN GRUPO GRUPOUSUARIO1 ON GRUPOUSUARIOUSUARIO1.CODIGOGRUPO = GRUPOUSUARIO1.CODIGO 
LEFT JOIN GRUPO GRUPOUSUARIO2 ON GRUPOUSUARIOUSUARIO2.CODIGOGRUPO = GRUPOUSUARIO2.CODIGO
WHERE UPPER(GRUPOUSUARIO1.NOMEGRUPO)= 'BANCO DE DADOS-IFRS-2021' OR UPPER(GRUPOUSUARIO2.NOMEGRUPO)= 'BANCO DE DADOS-IFRS-2021';

--M)
SELECT USUARIO.NOME AS NOME, COUNT(REACAO.CODIGO) AS NUMEROREACOES FROM POST 
JOIN REACAO ON POST.CODIGO= REACAO.COD_POST
JOIN USUARIO ON POST.EMAIL_USUARIO=USUARIO.EMAIL
WHERE (REACAO.DATAREACAO BETWEEN REACAO.DATAREACAO
    AND DATE(POST.DATAPOST, '+1 day','-1 minute', 'localtime'))
    AND (POST.DATAPOST BETWEEN DATE('now', '-7 day', 'localtime')
    AND DATE('NOW'))
    GROUP BY POST
    HAVING NUMEROREACOES > 1000;

--N)
SELECT ASSUNTO.ASSUNTO FROM COMPARTILHAMENTO 
LEFT JOIN POST ON COMPARTILHAMENTO.COD_POST = POST.CODIGO
LEFT JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
LEFT JOIN ASSUNTO ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
WHERE COMPARTILHAMENTO.EMAIL_USUARIO = 'joaosbras@mymail.com' 
AND COMPARTILHAMENTO.DATACOMPARTILHAMENTO BETWEEN date ('now', '-3 months', 'localtime' ) 
    AND DATE ('now');
/*
o email virou pk do usuario, antes era usuado codigo;
Criamos uma table grupo;
Colocamos genero e data de nascimento para os usuarios;
Foi acrescentado os novos usuarios;
Retiramos a  coluna na tabela de usuário que totaliza a quantidade de amigos
do usuario para que não seja acessada mais de uma tabela para receber essa informação e logo depois trata-la ;
Retiramos o campo (qtdReacoes);
Retiramos o campo (dataUltimoPost);
*/


DROP TABLE USUARIO;

DROP TABLE AMIZADE;

DROP TABLE ASSUNTO;

DROP TABLE ASSUNTOPOST;

DROP TABLE CITACAO;

DROP TABLE REACAO;

DROP TABLE COMPARTILHAMENTO;

DROP TABLE POST;

DROP TABLE GRUPO;

DROP TABLE GRUPOUSUARIO;


CREATE TABLE USUARIO(
    EMAIL CHAR (100) NOT NULL,
    NOME CHAR(100) NOT NULL,
    DATACADASTRO DATETIME,
    CIDADE CHAR(100),
    PAIS CHAR(100),
    UF CHAR(100),
    GENERO char (1),
    NASCIMENTO date,
    PRIMARY KEY (EMAIL)
);

CREATE TABLE GRUPO(
    CODIGO INTEGER NOT NULL,
    NOMEGRUPO CHAR(100) NOT NULL, 
    PRIMARY KEY(CODIGO)
);

CREATE TABLE GRUPOUSUARIO(
    CODIGOGRUPO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    PRIMARY KEY (CODIGOGRUPO, EMAIL_USUARIO)
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
CODIGOGRUPO INTEGER,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (CODPOSTREFERENCIA) REFERENCES POST(CODIGO),
    FOREIGN KEY (CODIGOGRUPO) REFERENCES GRUPO(CODIGO),
    PRIMARY KEY (CODIGO)
);

    INSERT INTO 
    GRUPO(
        CODIGO,
        NOMEGRUPO
    )
    VALUES
    (
        1,
        'SQLite'
    ),
    (
        2,
        'Banco de Dados-IFRS-2021'
    );

INSERT INTO
    USUARIO(
        EMAIL,
        NOME,
        DATACADASTRO,
        CIDADE,
        PAIS,
        UF,
        GENERO,
        NASCIMENTO
    )
VALUES
    (
        'joaosbras@mymail.com',
        'João Silva Brasil',
        '2020-01-01 13:00:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'M',
        '1998-02-02'
    ),
    (
        'pmartinssilva90@mymail.com',
        'Paulo Martins Silva',
        null,
        null,
        null,
        null,
        'M',
        '2003-05-23'
    ),
    (
        'mcalbuq@mymail.com',
        'Maria Cruz Albuquerque',
        '2020-01-01 13:10:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'F',
        '2002-11-04'
    ),
    (
        'jorosamed@mymail.com',
        'Joana Rosa Medeiros',
        '2020-01-01 13:15:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'N',
        '1974-02-05'
    ),
    (
        'pxramos@mymail.com',
        'Paulo Xavier Ramos',
        '2020-01-01 13:20:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'N',
        '1966-03-30'
    ),
    (
        'pele@cbf.com.br',
        'Edson Arantes do Nascimento',
        null,
        'Três Corações',
        'Brasil',
        'MG',
        'M',
        '1940-10-23'
    );

INSERT INTO
    AMIZADE(EMAIL_USUARIO1, EMAIL_USUARIO2, DATAAMIZADE)
VALUES
    ('pxramos@mymail.com','jorosamed@mymail.com', '2021-05-17 10:15:00'),
    ('jorosamed@mymail.com', 'pele@cbf.com.br', '2021-05-17 10:15:00'),
    ('mcalbuq@mymail.com', 'pele@cbf.com.br', '2021-05-17 10:20:00' ),
    ( 'jorosamed@mymail.com','mcalbuq@mymail.com','2021-05-17 10:20:00' );
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
        QTDREACOES,
        CODIGOGRUPO
    )
VALUES
    (
        1,
        'joaosbras@mymail.com',
        'Hoje eu aprendi como inserir dados no SQLite no IFRS',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:00:00',
        null,
        2,
        null
    ),
    (
        3,
        'jorosamed@mymail.com',
        'Alguém mais ficou com dúvida no comando INSERT?',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:15:00',
        1,
        1,
        1
    ),
    (
        4,
        'pxramos@mymail.com',
        'Eu também',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:20:00',
        3,
        0,
        null
    ),
    (
        5,
        'joaosbras@mymail.com',
        'Já agendaste horário de atendimento com o professor?',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:30:00',
        4,
        0,
        null
    ),
    (
        6,
        'pmartinssilva90@mymail.com',
        'Ontem aprendi sobre joins no SQLite na disciplina de banco de dados do IFRS.',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-08 18:30:00',
        null,
        0,
        null
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
    (6, 1),
    (6, 2);

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
        2,
        'Curtida',
        'mcalbuq@mymail.com',
        'Rio Grande',
        'RS',
        'Brasil',
        1,
        '2021-06-02 15:10:00'
    ),
    (
        3,
        'Triste',
        'pxramos@mymail.com',
        'Rio Grande',
        'RS',
        'Brasil',
        3,
        '2021-06-02 15:20:00'
    );


INSERT INTO
    GRUPOUSUARIO(
        CODIGOGRUPO,
        EMAIL_USUARIO
    )
values
    (2,
    'pxramos@mymail.com'),
    (2,
    'mcalbuq@mymail.com');
    

INSERT INTO COMPARTILHAMENTO(
    CODIGO,
    EMAIL_USUARIO,
    COD_POST,
    CIDADE,
    UF,
    DATACOMPARTILHAMENTO
) VALUES
(
    1, 
    'joaosbras@mymail.com',
    6,
    'Rio Grande',
    'RS', 
    '2021-06-10 13:00:00'
);

--A)
SELECT CASE WHEN USUARIO1.EMAIL= 'mcalbuq@mymail.com' THEN USUARIO2.NOME
ELSE USUARIO1.NOME 
END AS NOME
FROM AMIZADE
JOIN USUARIO USUARIO1 ON AMIZADE.EMAIL_USUARIO1= USUARIO1.EMAIL
JOIN USUARIO USUARIO2 ON AMIZADE.EMAIL_USUARIO2= USUARIO2.EMAIL
WHERE USUARIO1.EMAIL= 'mcalbuq@mymail.com' OR USUARIO2.EMAIL= 'mcalbuq@mymail.com';

--B)


--C)
SELECT (CAST(SUM(POST.QTDREACOES) AS REAL)/CAST(COUNT(POST) AS REAL)) AS MEDIA FROM POST
    LEFT JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
    LEFT JOIN ASSUNTO ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
	WHERE UPPER(ASSUNTO.ASSUNTO) = 'BD'; 

--D)
(SUM(POST.QTDREACOES)/COUNT(POST.POST))

--E)

SELECT COUNT(POST) POSTS FROM ASSUNTO
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
    JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
    LEFT JOIN REACAO ON REACAO.COD_POST = POST.CODIGO
	WHERE UPPER(ASSUNTO) = 'BD' AND UPPER(REACAO.TIPOREACAO) = 'CURTIDA';

--F)
SELECT ASSUNTO.ASSUNTO AS ASSUNTO, COUNT(ASSUNTO) AS QUANTIDADE FROM ASSUNTO
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
    JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
	WHERE POST.DATAPOST BETWEEN date ('now', '-7 days', 'localtime' ) AND DATE ('now')
GROUP BY ASSUNTO.ASSUNTO
ORDER BY 2 DESC;

--G)
SELECT POST.UF AS ESTADO, COUNT(*) AS QUANTIDADE FROM POST
WHERE POST.PAIS = 'Brasil' AND POST.DATAPOST BETWEEN date ('now', '-3 months', 'localtime' ) 
AND DATE ('now') 
GROUP BY ESTADO
ORDER BY 2 ASC;

--H)
SELECT POST.POST AS POST, COUNT(*) AS QUANTIDADE FROM POST
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
    JOIN ASSUNTO ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
WHERE  ASSUNTO = 'BD' 
    AND PAIS = 'Brasil' 
    AND POST.DATAPOST BETWEEN date ('now', '-3 months', 'localtime' ) 
    AND DATE ('now')
    GROUP BY POST
    ORDER BY DATAPOST;
--I)

SELECT USUARIO.NOME AS NOME, COUNT(REACAO.CODIGO) AS QUANTIDADE FROM POST 
JOIN REACAO ON POST.CODIGO= REACAO.COD_POST
JOIN USUARIO ON POST.EMAIL_USUARIO=USUARIO.EMAIL
WHERE REACAO.DATAREACAO BETWEEN date ('now', '-30 days', 'localtime' ) 
    AND DATE ('now')
    AND USUARIO.PAIS = 'Brasil'
    GROUP BY POST
    ORDER BY QUANTIDADE;
--J)
SELECT COUNT (COD_POST) AS QUANTIDADE FROM REACAO


WHERE CODIGOGRUPO = 1
AND POST.DATAPOST BETWEEN date ('now', '-60 days', 'localtime' ) 
AND DATE ('now');
--K)

--L)
SELECT DISTINCT(CASE WHEN UPPER(GRUPOUSUARIO1.NOMEGRUPO)= 'BANCO DE DADOS-IFRS-2021' THEN USUARIO2.NOME
ELSE USUARIO1.NOME END) AS NOME
FROM AMIZADE
LEFT JOIN USUARIO USUARIO1 ON AMIZADE.EMAIL_USUARIO1= USUARIO1.EMAIL
LEFT JOIN USUARIO USUARIO2 ON AMIZADE.EMAIL_USUARIO2= USUARIO2.EMAIL
LEFT JOIN GRUPOUSUARIO GRUPOUSUARIOUSUARIO1 ON USUARIO1.EMAIL = GRUPOUSUARIOUSUARIO1.EMAIL_USUARIO
LEFT JOIN GRUPOUSUARIO GRUPOUSUARIOUSUARIO2 ON USUARIO2.EMAIL = GRUPOUSUARIOUSUARIO2.EMAIL_USUARIO
LEFT JOIN GRUPO GRUPOUSUARIO1 ON GRUPOUSUARIOUSUARIO1.CODIGOGRUPO = GRUPOUSUARIO1.CODIGO 
LEFT JOIN GRUPO GRUPOUSUARIO2 ON GRUPOUSUARIOUSUARIO2.CODIGOGRUPO = GRUPOUSUARIO2.CODIGO
WHERE UPPER(GRUPOUSUARIO1.NOMEGRUPO)= 'BANCO DE DADOS-IFRS-2021' OR UPPER(GRUPOUSUARIO2.NOMEGRUPO)= 'BANCO DE DADOS-IFRS-2021';

--M)
SELECT USUARIO.NOME AS NOME, COUNT(REACAO.CODIGO) AS NUMEROREACOES FROM POST 
JOIN REACAO ON POST.CODIGO= REACAO.COD_POST
JOIN USUARIO ON POST.EMAIL_USUARIO=USUARIO.EMAIL
WHERE (REACAO.DATAREACAO BETWEEN REACAO.DATAREACAO
    AND DATE(POST.DATAPOST, '+1 day','-1 minute', 'localtime'))
    AND (POST.DATAPOST BETWEEN DATE('now', '-7 day', 'localtime')
    AND DATE('NOW'))
    GROUP BY POST
    HAVING NUMEROREACOES > 1000;

--N)
SELECT ASSUNTO.ASSUNTO FROM COMPARTILHAMENTO 
LEFT JOIN POST ON COMPARTILHAMENTO.COD_POST = POST.CODIGO
LEFT JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
LEFT JOIN ASSUNTO ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
WHERE COMPARTILHAMENTO.EMAIL_USUARIO = 'joaosbras@mymail.com'
AND POST.EMAIL_USUARIO= 'pmartinssilva90@mymail.com'
AND COMPARTILHAMENTO.DATACOMPARTILHAMENTO BETWEEN date ('now', '-3 months', 'localtime' ) 
    AND DATE ('now');
