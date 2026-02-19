CREATE DATABASE IF NOT EXISTS LojaEletronicosPBI;
USE LojaEletronicosPBI;

CREATE TABLE LojaEletronicosPBI_clientes (
  cliente_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  nome  VARCHAR(160) NOT NULL,
  email VARCHAR(160) NOT NULL UNIQUE,
  cidade VARCHAR(120),
  estado CHAR(2)
) ENGINE=InnoDB;

CREATE TABLE LojaEletronicosPBI_categorias (
  categoria_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE LojaEletronicosPBI_produtos (
  produto_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  sku  VARCHAR(50) NOT NULL UNIQUE,
  nome VARCHAR(180) NOT NULL,
  categoria_id BIGINT NOT NULL,
  marca VARCHAR(120),
  preco_lista DECIMAL(10,2) NOT NULL,
  custo_unitario DECIMAL(10,2) NOT NULL,
  ativo TINYINT(1) DEFAULT 1,
  KEY ix_produtos_categoria (categoria_id),
  CONSTRAINT fk_produtos_categoria
    FOREIGN KEY (categoria_id)
    REFERENCES LojaEletronicosPBI_categorias(categoria_id)
) ENGINE=InnoDB;

CREATE TABLE LojaEletronicosPBI_lojas (
  loja_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  tipo ENUM('LOJA','CD') NOT NULL,
  nome VARCHAR(160) NOT NULL,
  responsavel_nome VARCHAR(160) NOT NULL,
  cidade VARCHAR(120),
  estado CHAR(2),
  ativo TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE LojaEletronicosPBI_pedidos (
  pedido_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(40) NOT NULL UNIQUE,
  cliente_id BIGINT NOT NULL,
  loja_id BIGINT NOT NULL,
  data_pedido DATE NOT NULL,
  canal ENUM('SITE','APP','MARKETPLACE'),
  status ENUM('CRIADO','PAGO','ENVIADO','ENTREGUE','CANCELADO'),
  valor_frete DECIMAL(10,2) DEFAULT 0,
  desconto_total DECIMAL(10,2) DEFAULT 0,
  total_pedido DECIMAL(10,2) NOT NULL,
  KEY ix_pedidos_data (data_pedido),
  KEY ix_pedidos_cliente (cliente_id),
  KEY ix_pedidos_loja (loja_id),
  CONSTRAINT fk_pedidos_cliente
    FOREIGN KEY (cliente_id) REFERENCES LojaEletronicosPBI_clientes(cliente_id),
  CONSTRAINT fk_pedidos_loja
    FOREIGN KEY (loja_id) REFERENCES LojaEletronicosPBI_lojas(loja_id)
) ENGINE=InnoDB;

CREATE TABLE LojaEletronicosPBI_itens_pedido (
  item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  pedido_id BIGINT NOT NULL,
  produto_id BIGINT NOT NULL,
  quantidade INT NOT NULL,
  preco_unitario DECIMAL(10,2) NOT NULL,
  desconto_item DECIMAL(10,2) DEFAULT 0,
  total_item DECIMAL(10,2) NOT NULL,
  KEY ix_itens_pedido_pedido (pedido_id),
  KEY ix_itens_pedido_produto (produto_id),
  CONSTRAINT fk_itens_pedido_pedido
    FOREIGN KEY (pedido_id) REFERENCES LojaEletronicosPBI_pedidos(pedido_id)
    ON DELETE CASCADE,
  CONSTRAINT fk_itens_pedido_produto
    FOREIGN KEY (produto_id) REFERENCES LojaEletronicosPBI_produtos(produto_id)
) ENGINE=InnoDB;

CREATE TABLE LojaEletronicosPBI_pagamentos (
  pagamento_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  pedido_id BIGINT NOT NULL,
  data_pagamento DATE,
  metodo ENUM('PIX','CARTAO','BOLETO'),
  status ENUM('PENDENTE','APROVADO','RECUSADO','ESTORNADO'),
  valor DECIMAL(10,2),
  KEY ix_pagamentos_pedido (pedido_id),
  CONSTRAINT fk_pagamentos_pedido
    FOREIGN KEY (pedido_id) REFERENCES LojaEletronicosPBI_pedidos(pedido_id)
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE LojaEletronicosPBI_entregas (
  entrega_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  pedido_id BIGINT NOT NULL,
  transportadora VARCHAR(80),
  status ENUM('CRIADA','EM_TRANSITO','ENTREGUE','ATRASADA'),
  data_envio DATE,
  data_prevista DATE,
  data_entrega DATE,
  UNIQUE KEY uq_entregas_pedido (pedido_id),
  CONSTRAINT fk_entregas_pedido
    FOREIGN KEY (pedido_id) REFERENCES LojaEletronicosPBI_pedidos(pedido_id)
    ON DELETE CASCADE
) ENGINE=InnoDB;

USE LojaEletronicosPBI;

-- =====================================================
-- RESET (garante IDs 1,2,3...)
-- =====================================================
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE entrega;
TRUNCATE TABLE pagamento;
TRUNCATE TABLE item_pedido;
TRUNCATE TABLE pedido;
TRUNCATE TABLE produto;
TRUNCATE TABLE categoria;
TRUNCATE TABLE loja;
TRUNCATE TABLE cliente;

SET FOREIGN_KEY_CHECKS = 1;

START TRANSACTION;

-- =====================================================
-- LOJAS (5) - região Sorocaba
-- =====================================================
INSERT INTO loja (loja_id, tipo, nome, responsavel_nome, cidade, estado, ativo) VALUES
(1,'LOJA','Loja Sorocaba Centro','Carlos Silva','Sorocaba','SP',1),
(2,'LOJA','Loja Itu Centro','Ana Paula Lima','Itu','SP',1),
(3,'LOJA','Loja São Roque Shopping','Marcos Souza','São Roque','SP',1),
(4,'LOJA','Loja Votorantim','Fernanda Rocha','Votorantim','SP',1),
(5,'CD','CD Sorocaba','Ricardo Alves','Sorocaba','SP',1);

-- =====================================================
-- CATEGORIAS (8)
-- =====================================================
INSERT INTO categoria (categoria_id, nome) VALUES
(1,'Smartphones'),
(2,'Notebooks'),
(3,'TVs'),
(4,'Áudio'),
(5,'Acessórios'),
(6,'Monitores'),
(7,'Games'),
(8,'Periféricos');

-- =====================================================
-- PRODUTOS (20) -> produto_id 1..20
-- SKU simples: '1','2','3'... (sem "SKU001")
-- =====================================================
INSERT INTO produto (produto_id, sku, nome, categoria_id, marca, preco_lista, custo_unitario, ativo) VALUES
(1,'1','Galaxy S23',1,'Samsung',4200,3100,1),
(2,'2','iPhone 14',1,'Apple',5200,4100,1),
(3,'3','Redmi Note 12',1,'Xiaomi',1800,1200,1),
(4,'4','Moto G84',1,'Motorola',1700,1100,1),
(5,'5','Dell i5 15"',2,'Dell',4500,3400,1),
(6,'6','Lenovo i7 15"',2,'Lenovo',6200,4800,1),
(7,'7','Acer i5 15"',2,'Acer',3900,2900,1),
(8,'8','MacBook Air M1',2,'Apple',6800,5200,1),
(9,'9','TV Samsung 55"',3,'Samsung',3800,2900,1),
(10,'10','TV LG 65"',3,'LG',5200,4100,1),
(11,'11','TV TCL 50"',3,'TCL',2600,1900,1),
(12,'12','Soundbar LG',4,'LG',1500,900,1),
(13,'13','Fone JBL Tune',4,'JBL',600,350,1),
(14,'14','AirPods 2',4,'Apple',1400,900,1),
(15,'15','Echo Dot',4,'Amazon',450,280,1),
(16,'16','Carregador USB-C 30W',5,'Baseus',180,90,1),
(17,'17','Cabo HDMI 2.1',5,'Multilaser',90,40,1),
(18,'18','Monitor Dell 27"',6,'Dell',1800,1200,1),
(19,'19','PlayStation 5',7,'Sony',4200,3600,1),
(20,'20','Mouse Logitech',8,'Logitech',250,120,1);

-- Ajusta o AUTO_INCREMENT pra continuar do 21 se precisar inserir depois
ALTER TABLE produto AUTO_INCREMENT = 21;

-- =====================================================
-- CLIENTES (40) -> cliente_id 1..40
-- =====================================================
INSERT INTO cliente (cliente_id, nome, email, cidade, estado) VALUES
(1,'João Silva','joao@email.com','Sorocaba','SP'),
(2,'Maria Souza','maria@email.com','Itu','SP'),
(3,'Carlos Lima','carlos@email.com','São Roque','SP'),
(4,'Ana Rocha','ana@email.com','Votorantim','SP'),
(5,'Pedro Santos','pedro@email.com','Sorocaba','SP'),
(6,'Lucas Alves','lucas@email.com','Itu','SP'),
(7,'Fernanda Costa','fernanda@email.com','Sorocaba','SP'),
(8,'Juliana Martins','juliana@email.com','São Roque','SP'),
(9,'Bruno Pereira','bruno@email.com','Votorantim','SP'),
(10,'Rafael Gomes','rafael@email.com','Sorocaba','SP'),
(11,'Paula Ribeiro','paula@email.com','Itu','SP'),
(12,'Thiago Nunes','thiago@email.com','Sorocaba','SP'),
(13,'Camila Araujo','camila@email.com','São Roque','SP'),
(14,'Diego Barros','diego@email.com','Sorocaba','SP'),
(15,'Renata Lopes','renata@email.com','Itu','SP'),
(16,'Gustavo Farias','gustavo@email.com','Sorocaba','SP'),
(17,'Daniel Teixeira','daniel@email.com','Votorantim','SP'),
(18,'Patricia Melo','patricia@email.com','Sorocaba','SP'),
(19,'André Cunha','andre@email.com','São Roque','SP'),
(20,'Beatriz Pacheco','bia@email.com','Sorocaba','SP'),
(21,'Felipe Duarte','felipe@email.com','Itu','SP'),
(22,'Natalia Guedes','natalia@email.com','Sorocaba','SP'),
(23,'Leonardo Freitas','leo@email.com','Sorocaba','SP'),
(24,'Mariana Torres','mariana@email.com','Votorantim','SP'),
(25,'Eduardo Batista','edu@email.com','Sorocaba','SP'),
(26,'Aline Moreira','aline@email.com','Itu','SP'),
(27,'Rodrigo Siqueira','rodrigo@email.com','Sorocaba','SP'),
(28,'Vanessa Prado','vanessa@email.com','São Roque','SP'),
(29,'Igor Macedo','igor@email.com','Sorocaba','SP'),
(30,'Tatiane Lopes','tatiane@email.com','Votorantim','SP'),
(31,'Marcio Ferreira','marcio@email.com','Sorocaba','SP'),
(32,'Livia Campos','livia@email.com','Itu','SP'),
(33,'Henrique Dias','henrique@email.com','Sorocaba','SP'),
(34,'Priscila Andrade','pri@email.com','São Roque','SP'),
(35,'Caio Almeida','caio@email.com','Votorantim','SP'),
(36,'Isabela Ribeiro','isa@email.com','Sorocaba','SP'),
(37,'Vinicius Moura','vini@email.com','Itu','SP'),
(38,'Sabrina Cardoso','sabrina@email.com','Sorocaba','SP'),
(39,'Otavio Vieira','otavio@email.com','São Roque','SP'),
(40,'Gabriela Pinto','gabi@email.com','Votorantim','SP');

ALTER TABLE cliente AUTO_INCREMENT = 41;

-- Gera sequência 1..200 sem WITH RECURSIVE
INSERT INTO pedido
(pedido_id, codigo, cliente_id, loja_id, data_pedido, canal, status, valor_frete, desconto_total, total_pedido)
SELECT
  n AS pedido_id,
  CAST(n AS CHAR(40)) AS codigo,
  1 + MOD(n * 7, 40) AS cliente_id,
  1 + MOD(n * 3, 5)  AS loja_id,
  DATE_ADD('2024-01-01', INTERVAL MOD(n * 19, DATEDIFF('2025-12-31','2024-01-01')) DAY) AS data_pedido,
  ELT(1 + MOD(n, 3), 'SITE','APP','MARKETPLACE') AS canal,
  CASE
    WHEN MOD(n, 20) = 0 THEN 'CANCELADO'
    WHEN MOD(n, 7)  = 0 THEN 'ENVIADO'
    ELSE 'ENTREGUE'
  END AS status,
  19.90 AS valor_frete,
  CASE WHEN MOD(n, 10) = 0 THEN 50.00 ELSE 0.00 END AS desconto_total,
  0.00 AS total_pedido
FROM (
  SELECT @n := @n + 1 AS n
  FROM information_schema.columns, (SELECT @n := 0) vars
  LIMIT 200
) seq;

ALTER TABLE pedido AUTO_INCREMENT = 201;

INSERT INTO item_pedido
(item_id, pedido_id, produto_id, quantidade, preco_unitario, desconto_item, total_item)
SELECT
  n AS item_id,
  n AS pedido_id,
  1 + MOD(n * 5, 20) AS produto_id,  -- 1..20
  1 + MOD(n, 3) AS quantidade,       -- 1..3
  ROUND(p.preco_lista * (0.92 + (MOD(n, 9) / 100)), 2) AS preco_unitario,
  CASE WHEN MOD(n, 12) = 0 THEN 30.00 ELSE 0.00 END AS desconto_item,
  ROUND(
    (1 + MOD(n, 3)) * (p.preco_lista * (0.92 + (MOD(n, 9) / 100)))
    - (CASE WHEN MOD(n, 12) = 0 THEN 30.00 ELSE 0.00 END),
  2) AS total_item
FROM (
  SELECT @i := @i + 1 AS n
  FROM information_schema.columns, (SELECT @i := 0) vars
  LIMIT 200
) seq
JOIN produto p ON p.produto_id = (1 + MOD(seq.n * 5, 20));

ALTER TABLE item_pedido AUTO_INCREMENT = 201;

UPDATE pedido pe
JOIN item_pedido it ON it.pedido_id = pe.pedido_id
SET pe.total_pedido = ROUND(it.total_item + pe.valor_frete - pe.desconto_total, 2);

INSERT INTO pagamento
(pagamento_id, pedido_id, data_pagamento, metodo, status, valor)
SELECT
  p.pedido_id,
  p.pedido_id,
  CASE WHEN p.status IN ('ENTREGUE','ENVIADO') THEN DATE_ADD(p.data_pedido, INTERVAL 1 DAY) ELSE NULL END,
  ELT(1 + MOD(p.pedido_id, 3), 'PIX','CARTAO','BOLETO'),
  CASE
    WHEN p.status = 'CANCELADO' THEN 'ESTORNADO'
    WHEN MOD(p.pedido_id, 17) = 0 THEN 'RECUSADO'
    ELSE 'APROVADO'
  END,
  p.total_pedido
FROM pedido p;

ALTER TABLE pagamento AUTO_INCREMENT = 201;

INSERT INTO entrega
(entrega_id, pedido_id, transportadora, status, data_envio, data_prevista, data_entrega)
SELECT
  p.pedido_id,
  p.pedido_id,
  ELT(1 + MOD(p.pedido_id, 3), 'Correios','Jadlog','Loggi'),
  CASE
    WHEN p.status = 'CANCELADO' THEN 'CRIADA'
    WHEN MOD(p.pedido_id, 9) = 0 THEN 'ATRASADA'
    ELSE 'ENTREGUE'
  END,
  CASE WHEN p.status IN ('ENTREGUE','ENVIADO') THEN DATE_ADD(p.data_pedido, INTERVAL 1 DAY) ELSE NULL END,
  CASE WHEN p.status IN ('ENTREGUE','ENVIADO') THEN DATE_ADD(p.data_pedido, INTERVAL 6 DAY) ELSE NULL END,
  CASE
    WHEN p.status = 'ENTREGUE' AND MOD(p.pedido_id, 9) <> 0 THEN DATE_ADD(p.data_pedido, INTERVAL 5 DAY)
    WHEN p.status = 'ENTREGUE' AND MOD(p.pedido_id, 9) = 0 THEN DATE_ADD(p.data_pedido, INTERVAL 9 DAY)
    ELSE NULL
  END
FROM pedido p;

ALTER TABLE entrega AUTO_INCREMENT = 201;

