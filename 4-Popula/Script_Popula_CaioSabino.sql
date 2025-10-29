-- Script para popular o banco de dados

USE DETRAN_DB;

INSERT INTO CATEGORIA (nome_categoria) VALUES
('Carro'),
('Moto'),
('Caminhão'),
('Ônibus'),
('Van');

INSERT INTO MODELO (nome_modelo) VALUES
('Fiat Uno'),
('Honda Civic'),
('Yamaha XTZ 250'),
('Volkswagen Gol'),
('Scania R450');

INSERT INTO TIPO_INFRACAO (descricao, valor) VALUES
('Excesso de velocidade até 20%', 130.16),
('Excesso de velocidade acima de 50%', 880.41),
('Estacionar em local proibido', 195.23),
('Dirigir sem cinto de segurança', 195.23),
('Avançar sinal vermelho', 293.47);

INSERT INTO LOCAL (latitude, longitude, velocidade_permitida) VALUES
(-23.550520, -46.633308, 60),
(-22.903539, -43.209587, 50),
(-25.428356, -49.273251, 70),
(-19.916681, -43.934493, 40),
(-15.780148, -47.929170, 80);

INSERT INTO PROPRIETARIO (cpf, nome, endereco, bairro, cidade, estado, sexo, data_nascimento)
VALUES
('12345678901', 'Carlos Silva', 'Rua A, 100', 'Centro', 'São Paulo', 'SP', 'M', '1985-06-15'),
('23456789012', 'Maria Souza', 'Av. B, 200', 'Jardim', 'Rio de Janeiro', 'RJ', 'F', '1990-03-20'),
('34567890123', 'João Oliveira', 'Rua C, 50', 'Boa Vista', 'Belo Horizonte', 'MG', 'M', '1978-12-01'),
('45678901234', 'Ana Lima', 'Av. D, 300', 'Industrial', 'Curitiba', 'PR', 'F', '1995-07-09'),
('56789012345', 'Pedro Santos', 'Rua E, 400', 'Centro', 'Brasília', 'DF', 'M', '2000-01-10');

INSERT INTO AGENTE (nome, data_contratacao)
VALUES
('Rafael Mendes', '2015-04-10'),
('Juliana Costa', '2018-09-15'),
('Ricardo Alves', '2010-01-20'),
('Fernanda Lopes', '2012-12-05'),
('Gustavo Nogueira', '2020-06-01');

INSERT INTO TELEFONE (cpf_proprietario, telefone) VALUES
('12345678901', '(11) 98888-1111'),
('23456789012', '(21) 97777-2222'),
('34567890123', '(31) 96666-3333'),
('45678901234', '(41) 95555-4444'),
('56789012345', '(61) 94444-5555');

INSERT INTO VEICULO (placa, chassi, cor, ano_fabricacao, cpf_proprietario, cod_categoria, cod_modelo)
VALUES
('ABC1D23', '9BWZZZ377VT004251', 'Prata', 2015, '12345678901', 1, 4),
('XYZ9E87', '8ADZZZ322VT007654', 'Preto', 2019, '23456789012', 1, 2),
('MNO2F65', '7BWZZZ311VT008912', 'Azul', 2021, '34567890123', 2, 3),
('JKL3G12', '6BWZZZ388VT002345', 'Branco', 2017, '45678901234', 1, 1),
('PQR4H98', '5BWZZZ399VT009876', 'Vermelho', 2016, '56789012345', 3, 5);

INSERT INTO INFRACAO (data_hora, velocidade_aferida, placa_veiculo, cod_tipo, matricula_agente, id_local)
VALUES
('2024-05-15 10:30:00', 78.5, 'ABC1D23', 1, 1, 1),
('2024-06-01 08:15:00', 120.0, 'XYZ9E87', 2, 2, 3),
('2024-07-12 18:45:00', NULL, 'MNO2F65', 3, 3, 2),
('2024-08-09 14:10:00', 65.0, 'JKL3G12', 4, 4, 4),
('2024-09-20 22:00:00', 90.0, 'PQR4H98', 5, 5, 5);
