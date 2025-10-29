-- Script para fazer as consultas necessárias

USE DETRAN_DB;


-- A) Dados dos veículos de um determinado proprietário (CPF)

SELECT 
  V.placa,
  V.chassi,
  V.cor,
  V.ano_fabricacao,
  C.nome_categoria,
  M.nome_modelo,
  P.nome AS nome_proprietario,
  P.cpf
FROM VEICULO V
JOIN CATEGORIA C ON V.cod_categoria = C.cod_categoria
JOIN MODELO M ON V.cod_modelo = M.cod_modelo
JOIN PROPRIETARIO P ON V.cpf_proprietario = P.cpf
WHERE P.cpf = '12345678901';  


-- B) Consultar proprietário(s) por qualquer parte do nome

SELECT 
  cpf,
  nome,
  cidade,
  estado,
  data_nascimento,
  idade
FROM PROPRIETARIO
WHERE nome LIKE '%Maria%'; 


-- C) Dados da infração e do veículo em um período DE...ATÉ...

SELECT 
  I.id_infracao,
  I.data_hora,
  I.velocidade_aferida,
  T.descricao AS tipo_infracao,
  T.valor AS valor_infracao,
  V.placa,
  V.chassi,
  V.cor,
  M.nome_modelo,
  P.nome AS proprietario
FROM INFRACAO I
JOIN TIPO_INFRACAO T ON I.cod_tipo = T.cod_tipo
JOIN VEICULO V ON I.placa_veiculo = V.placa
JOIN MODELO M ON V.cod_modelo = M.cod_modelo
JOIN PROPRIETARIO P ON V.cpf_proprietario = P.cpf
WHERE I.data_hora BETWEEN '2024-05-01' AND '2024-07-31';


-- D) Número de veículos cadastrados por modelo (ordem decrescente)

SELECT 
  M.nome_modelo,
  COUNT(V.placa) AS total_veiculos
FROM VEICULO V
JOIN MODELO M ON V.cod_modelo = M.cod_modelo
GROUP BY M.nome_modelo
ORDER BY total_veiculos DESC;
