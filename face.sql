    /*
fiz uma entidade site 
fiz uma entidade amigoscomum_usuario como aux
fiz uma entidade amigoscomum
fiz um autorelacionamento em comentario
fiz um autorelacionamento em usuario
fiz uma entidade usuario_grupo como aux
fiz uma entidade grupo
fiz uma entidade citados 
fiz uma entidade assunto
coloquei codigo nas entidades como pk
coloquei os cod_(alguma coisa ) como fk, para pesquisar
e arrumei as ligações 
*/
    
    
    drop table grupo;
    drop table usuariogrupo;
    drop table compartilhamento;
    drop table comentario;
    drop table reacao;
    drop table citados;
    drop table assunto;
    drop table post ;
    drop table amigos;
    drop table amigoscomum;
    drop table amigoscomum_usuario;
    drop table usuario;
    drop table sitep;    
    
    
    create table sitep(
        codigo integer not null,
        nome char (100) not null,
        primary key (codigo)
    );

    create table usuario(
    email char (100) not null,
    nome char(100) not null,
    primary key (email)
    );

    insert into usuario(email, nome) values
    ('joaosbras@mymail.com', 'João Silva Brasi'), 
    ('mcalbuq@mymail.com', 'Maria Cruz Albuquerque'), 
    ('jorosamed@mymail.com', 'Joana Rosa Medeiros'), 
    ('pxramos@mymail.com', 'Paulo Xavier Ramos'),
    ('pmartinssilva90@mymail.com', 'Paulo Martins Silva'),
    ('pele@cbf.com.br', 'Edson Arantes do Nascimento');

    create table amigoscomum_usuario(
        email_usuario char (100) not null,
        cod_amigoscomum integer not null,
        foreign key (email_usuario) references usuario(email),
    foreign key (cod_amigoscomum) references amigoscomum(codigo),
    primary key (email_usuario, cod_amigoscomum)
    );

    create table amigoscomum(
    codigo integer not null,
    cod_amigos integer not null,
    email_usuario char (100) not null,
    foreign key (cod_amigos) references amigos(codigo),
    foreign key (email_usuario) references usuario(email),
    primary key (codigo)
    );

    create table amigos(
    codigo integer not null,
    email_usuario char (100) not null,
    nome char (100) not null,
    dataa datetime,
    pais char(100) not null,
    foreign key (email_usuario) references usuario(email),
    primary key (codigo)
    );

/*
    insert into amigos(codigo,email_usuario, nome, dataa, pais) values
    (1,1,'João Silva Brasil', '2021-05-17 10:00', 'Brasil'),
    (2,1,'Pedro Alencar Pereira', '2021-05-17 10:05', 'Brasil' ),
    (3,1,'Maria Cruz Albuquerque','2021-05-17 10:10','Brasil' ),
    (4,1,'Joana Rosa Medeiros','2021-05-17 10:15','Brasil' ),
    (5,1,'Paulo Xavier Ramos','2021-05-17 10:20','Brasil' );
*/ 

    create table post(
    codigo integer not null,
    email_usuario char (100) not null,
    post char(1000) not null,
    cidade char (100) not null, 
    estado char (100) not null,
    pais char (100) not null,
    dataa datetime, 
    foreign key (email_usuario) references usuario(email),
    primary key (codigo)
    );

    insert into post(codigo, email_usuario, post, cidade, estado, pais, dataa )values
    (3,'jorosamed@mymail.com','Alguém mais ficou com dúvida no comando INSERT?', 'Rio Grande', 'RS', 'Brasil','2021-06-02 15:15'),
    (4,'pxramos@mymail.com','Eu também', 'Rio Grande', 'RS', 'Brasil','2021-06-02 15:20'),
    (5,'joaosbras@mymail.com', 'Já agendaste horário de atendimento com o professor?', 'Rio Grande', 'RS', 'Brasil', '2021-06-02 15:30');


create table assunto(
    codigo integer not null,
    cod_post integer not null,
        assunto char (100),
foreign key (cod_post) references post(codigo),
primary key (codigo)
);
insert into assunto(codigo, cod_post, assunto) values
(7,3,'bd'), (8,3,'sqlite'), (9,3,'insert'),(10,5,'atendimento'), (11,5,'bd');

create table citados(
    codigo integer not null,
    cod_post integer not null,
    email_usuario char (100) not null,
foreign key (email_usuario) references usuario(email),
foreign key (cod_post) references post(codigo),
primary key (codigo)
);
insert into citados (codigo, cod_post, email_usuario) values
(3,2,'pxramos@mymail.com');

    create table reacao(
    codigo integer not null, 
    email_usuario char (100) not null,
    cod_post integer not null,  
    cidade char(100) not null, 
    estado char(2) not null, 
    pais char(100) not null, 
    dataa datetime,
    foreign key (email_usuario) references usuario(email),
    foreign key (cod_post) references post(codigo),
    primary key (codigo)
    );

    insert into reacao(codigo, email_usuario, cidade, estado, pais, cod_post, dataa)values
    (4,'pxramos@mymail.com','Rio Grande', 'RS', 'Brasil',3, '2021-06-07 15:20' );

    create table comentario(
    codigo integer not null,
    cod_post integer not null,
    foreign key (cod_post) references post(codigo),
    primary key (codigo)
    );

    insert into comentario(codigo, cod_post, cod_post)values
    (2,3,4),
    (3,4,5);

    create table compartilhamento(
    codigo integer not null,
    email_usuario char (100) not null, 
    cod_post integer not null, 
    cidade char(100) not null, 
    estado char(2) not null, 
    dataa datetime,
    foreign key (email_usuario) references usuario(codigo),
    foreign key (cod_post) references post(codigo),
    primary key (codigo)
    );
/*
    insert into compartilhamento(codigo, email_usuario,cod_post, cidade, estado, dataa) values
    (1,2,2, 'Rio Grande', 'RS', '2021-06-02 15:40');
*/

create table usuariogrupo(
    email_usuario integer not null,
    cod_grupo integer not null,
    foreign key (email_usuario) references usuario(email),
    foreign key (cod_grupo) references grupo(codigo),
    primary key (email_usuario, cod_grupo)
);

create table grupo(
    codigo integer not null,
    email_usuario integer not null,
    nome char(100) not null,
    foreign key (email_usuario) references usuario(email),
    primary key (codigo)
);


/*
Modificações:
Coloquei datetime nas tables

a)select * from assunto
where cod_post = 5;

b)select count (*) as quantidade from reacao
where cod_usuario = 2;

c)select count (*) as quantidade from post
where datetime(dataa) > datetime('now', '-1 month', 'localtime') and cod_usuario = 2; 

d)select dataa from post
where cod_usuario = 4
order by dataa desc;

e) select cod_usuario, count (*) as quantidade from post
where datetime(dataa) > datetime('now', '-1 months', 'localtime') and pais = 'Brasil'
group by cod_usuario
having count (*) > 50;

f)select date(dataa), count (*) as quantidade from post
where datetime(dataa) > datetime('now', '-7 days', 'localtime') and pais = "Brasil"
order by quantidade;

g)select cidade, count (*) as quantidade from usuario
group by cidade
order by quantidade;

h)select estado, count (*) as quantidade from usuario
group by estado
order by quantidade;

i)select cod_usuario, count (*) as quantidade from amigos
group by cod_usuario
having count (*) > 100;

j)select cod_usuario, count (*) as quantidade from amigos
where pais ='Brasil'
group by cod_usuario
having count (*) > 100;

k)select count (*) as quantidade from usuario
where datetime(dataa) > datetime('now', '-12 months', 'localtime') and pais = 'Brasil';

l)select date(dataa), count (*) as quantidade from post
where datetime(dataa) > datetime('now', '-3 months', 'localtime') and pais ='Brasil';

m)select (count(cod_usuario)/count(distinct cod_post)) as media from reacao
where datetime(dataa) > datetime('now', '-3 months', 'localtime') and cod_post = 3
group by cod_post;

n)Não consegui fazer :(
*/


