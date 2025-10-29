-- Projeto DETRAN_DB - Desafio 2 Backend - Trainee Engnet 2025.2
-- Autor: Caio Sabino
-- Script Físico
-- 9 tabelas 
-- Ultimas atualizações:
-- 29/10/2025: Criação do primeiro script físico
-- 29/10/2025: Foi necessário mudar o tipo da idade e criar um trigger


CREATE DATABASE IF NOT EXISTS DETRAN_DB;
USE DETRAN_DB;

CREATE TABLE CATEGORIA (
  cod_categoria TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome_categoria VARCHAR(30) NOT NULL,
  PRIMARY KEY (cod_categoria)
);

CREATE TABLE MODELO (
  cod_modelo MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome_modelo VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_modelo)
);

CREATE TABLE TIPO_INFRACAO (
  cod_tipo INT UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(255) NOT NULL,
  valor DECIMAL(10, 2) NOT NULL CHECK (valor > 0),
  PRIMARY KEY (cod_tipo)
);

CREATE TABLE LOCAL (
  id_local INT UNSIGNED NOT NULL AUTO_INCREMENT,
  latitude DECIMAL(8, 6) NOT NULL,
  longitude DECIMAL(9, 6) NOT NULL,
  velocidade_permitida SMALLINT UNSIGNED NULL CHECK (velocidade_permitida > 0),
  PRIMARY KEY (id_local),
  UNIQUE KEY uk_coordenadas (latitude, longitude)
);

CREATE TABLE PROPRIETARIO (
  cpf CHAR(11) NOT NULL,
  nome VARCHAR(255) NOT NULL,
  endereco VARCHAR(255) NULL,
  bairro VARCHAR(255) NULL,
  cidade VARCHAR(255) NULL,
  estado CHAR(2) NULL,
  sexo ENUM('M', 'F', 'O') NULL,
  data_nascimento DATE NOT NULL,
  idade TINYINT NULL,
  PRIMARY KEY (cpf)
);

DELIMITER $$

CREATE TRIGGER trg_proprietario_set_idade
BEFORE INSERT ON PROPRIETARIO
FOR EACH ROW
BEGIN
  SET NEW.idade = TIMESTAMPDIFF(YEAR, NEW.data_nascimento, CURDATE());
END$$

DELIMITER ;

CREATE TABLE AGENTE (
  matricula INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  data_contratacao DATE NOT NULL,
  tempo_servico_meses INT NULL,
  PRIMARY KEY (matricula)
);

DELIMITER $$

CREATE TRIGGER trg_agente_set_tempo_servico
BEFORE INSERT ON AGENTE
FOR EACH ROW
BEGIN
  SET NEW.tempo_servico_meses = TIMESTAMPDIFF(MONTH, NEW.data_contratacao, CURDATE());
END$$

DELIMITER ;

CREATE TABLE TELEFONE (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  cpf_proprietario CHAR(11) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cpf_proprietario)
    REFERENCES PROPRIETARIO(cpf)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE VEICULO (
  placa CHAR(7) NOT NULL,
  chassi CHAR(17) NOT NULL,
  cor VARCHAR(30) NULL,
  ano_fabricacao YEAR NOT NULL CHECK (ano_fabricacao >= 1900),
  cpf_proprietario CHAR(11) NOT NULL,
  cod_categoria TINYINT UNSIGNED NOT NULL,
  cod_modelo MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (placa),
  UNIQUE KEY uk_chassi (chassi),
  FOREIGN KEY (cpf_proprietario)
    REFERENCES PROPRIETARIO(cpf)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (cod_categoria)
    REFERENCES CATEGORIA(cod_categoria)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (cod_modelo)
    REFERENCES MODELO(cod_modelo)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE INFRACAO (
  id_infracao INT UNSIGNED NOT NULL AUTO_INCREMENT,
  data_hora DATETIME NOT NULL,
  velocidade_aferida DECIMAL(5,2),
  placa_veiculo CHAR(7) NOT NULL,
  cod_tipo INT UNSIGNED NOT NULL,
  matricula_agente INT UNSIGNED NOT NULL,
  id_local INT UNSIGNED NOT NULL,
  PRIMARY KEY (id_infracao),
  FOREIGN KEY (placa_veiculo)
    REFERENCES VEICULO(placa)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (cod_tipo)
    REFERENCES TIPO_INFRACAO(cod_tipo)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (matricula_agente)
    REFERENCES AGENTE(matricula)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (id_local)
    REFERENCES LOCAL(id_local)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);
