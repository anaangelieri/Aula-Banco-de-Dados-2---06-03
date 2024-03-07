######################   1   ######################

#a. Inserir <‘Roberto’, ‘F’, ‘Santos’, ‘94377554355’, ‘21-06-1972’, ‘Rua Benjamin, 34, Santo André, SP’, M, 58.000, ‘88866555576’, 1> em FUNCIONARIO.
# Não tem erro

#b. Inserir <‘ProdutoA’, 4, ‘Santo André’, 2> em PROJETO.
#Não tem erro

#c. Inserir <‘Producao’, 4, ‘94377554355’, ‘01- 10-2007’> em DEPARTAMENTO.
# Não irá funcionar, porque a coluna de 'Dnumero' tem que ser único e tem já um 4 cadastrado. Deve ser inserido <‘Producao’, 3, ‘94377554355’, ‘01- 10-2007’>

#d. Inserir <‘67767898944’, NULL, ‘40,0’> em TRABALHA_EM.
#Não irá funcionar, porque a coluna Pnr é de chave e chave não pode ser atribuído o valor null. Deve ser inserido <‘67767898944’, 10, ‘40,0’>

#e. Inserir <‘45345345376’, ‘João’, ‘M’, ‘12-12-1990’, ‘Marido’> em DEPENDENTE.
#Não tem erro

#f. Excluir as tuplas de TRABALHA_EM com Fcpf = ‘33344555587’.
#delete from TRABALHA_EM where Fcpf = '33344555587';

#g. Excluir a tupla de FUNCIONARIO com Cpf = ‘98765432168’.
#delete from FUNCIONARIO where Cpf = '98765432168';

#h. Excluir a tupla de PROJETO com Projnome = ‘ProdutoX’.
#delete from PROJETO where Projnome = 'ProdutoX';

#i. Modificar Cpf_gerente e Data_inicio_gerente da tupla DEPARTAMENTO com Dnumero = 5 para ‘12345678966’ e ‘01-10-2007’, respectivamente.
#update DEPARTAMENTO set Cpf_gerente = '12345678966', Data_inicio_gerente = '01-10-2007' where Dnumero = 5;

#j. Modificar o atributo Cpf_supervisor da tupla FUNCIONARIO com Cpf = ‘99988777767’ para ‘c’.
#Não irá funcionar, porque o domínio do CPF é inteiro e o valor que iria ser inserido é do tipo char.

#k. Modificar o atributo Horas da tupla TRABALHA_EM com Fcpf = ‘99988777767’ e Pnr = 10 para ‘5,0’.
#update TRABALHA_EM set Horas = '5,0' where Fcpf = '99988777767' and Pnr = 10;

######################   2   ######################
create schema EMPRESA;
use EMPRESA;
drop schema Empresa;

create table Cliente (
    Num_cliente INT NOT NULL PRIMARY KEY,
    Nome_cliente VARCHAR(255),
    Num_cidade INT
);

create table Pedido (
    Num_pedido INT NOT NULL PRIMARY KEY,
    Data_pedido DATE,
    Num_cliente INT,
    Valor_pedido DECIMAL(10, 2) NOT NULL check (Valor_pedido >= 0),
    FOREIGN KEY (Num_cliente) REFERENCES CLIENTE(Num_cliente)
);

create table ITEM (
    Num_item INT NOT NULL PRIMARY KEY,
    Preco_unitario DECIMAL(10, 2) NOT NULL check (Preco_unitario > 0)
);

create table ITEM_PEDIDO (
    Num_pedido INT NOT NULL,
    Num_item INT NOT NULL,
    Quantidade INT NOT NULL check (Quantidade > 0),
    PRIMARY KEY (Num_pedido, Num_item),
    FOREIGN KEY (Num_pedido) REFERENCES PEDIDO(Num_pedido),
    FOREIGN KEY (Num_item) REFERENCES ITEM(Num_item)
);

create table DEPOSITO (
    Num_deposito INT NOT NULL PRIMARY KEY,
    Cidade VARCHAR(255) NOT NULL
);

create table EXPEDICAO (
    Num_pedido INT NOT NULL,
    Num_deposito INT NOT NULL,
    Data_envio DATE,
    PRIMARY KEY (Num_pedido, Num_deposito),
    FOREIGN KEY (Num_pedido) REFERENCES PEDIDO(Num_pedido),
    FOREIGN KEY (Num_deposito) REFERENCES DEPOSITO(Num_deposito)
);

-- Inserir dados na tabela CLIENTE

INSERT INTO CLIENTE (Num_cliente, Nome_cliente, Num_cidade)
VALUES	(1, 'Mateus Almeida', 101),
		(2, 'Sara Conor', 102),
        (3, 'André Matos', 103);

-- Inserir dados na tabela PEDIDO

INSERT INTO PEDIDO (Num_pedido, Data_pedido, Num_cliente, Valor_pedido)
VALUES	(101, '2022-03-08', 2, 500.00),
		(102, '2023-10-13', 1, 1250.00),
        (103, '2024-10-13', 1, 500.00),
        (104, '2023-12-08', 3, 1000.00),
        (105, '2024-03-06', 2, 750.00);
        
-- Inserir dados na tabela ITEM

INSERT INTO ITEM (Num_item, Preco_unitario)
VALUES	(1, 50.00),
		(2, 75.00),
        (3, 100.00),
        (4, 25.00);

-- Inserir dados na tabela ITEM_PEDIDO

INSERT INTO ITEM_PEDIDO (Num_pedido, Num_item, Quantidade)
VALUES	(101, 1, 2),
		(101, 2, 3),
		(102, 1, 1),
		(103, 1, 4);

-- Inserir dados na tabela DEPOSITO

INSERT INTO DEPOSITO (Num_deposito, Cidade)
VALUES	(201, 'São José do Rio Preto'),
		(202, 'Perdões'),
		(203, 'Bragança Paulista');

-- Inserir dados na tabela EXPEDICAO

INSERT INTO EXPEDICAO (Num_pedido, Num_deposito, Data_envio)
VALUES	(101, 201, '2022-03-10'),
		(102, 202, '2023-10-23'),
        (103, 203, '2023-10-23'),
        (104, 201, '2023-12-21'),
        (105, 203, '2024-03-10');

SELECT Num_cliente, Nome_cliente
FROM CLIENTE
WHERE Num_cliente IN (
    SELECT Num_cliente
    FROM PEDIDO
    WHERE Num_pedido IN (
        SELECT Num_pedido
        FROM EXPEDICAO
        WHERE Data_envio = '2023-10-23'
    )
);



######################   3   ######################