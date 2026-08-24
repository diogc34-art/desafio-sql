information_schema
#atividade 1 listar pela data de inscricao mais recente
SELECT *
FROM tb_inscricoes_cnh_social
ORDER BY data_inscricao DESC;

#atividade 2 total de inscricoes 
SELECT COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social;

#atividade 3 exibir municipios distintos
SELECT DISTINCT cidade
FROM tb_inscricoes_cnh_social;

#atividade 4 sao pcd 
SELECT * FROM tb_inscricoes_cnh_social 
WHERE eh_pcd = '1';

#atividade 5 nao sao 
SELECT*FROM tb_inscricoes_cnh_social 
WHERE eh_pcd = '0';

#atividade 6 Exibir os candidatos com idade entre 18 e 24 anos.
SELECT *
FROM tb_inscricoes_cnh_social
WHERE TIMESTAMPDIFF(
YEAR,
STR_TO_DATE(data_nascimento, '%d/%m/%Y'),
CURDATE()
) BETWEEN 18 AND 24;

#atividade 7 exibir acima de 60 anos
SELECT *
FROM tb_inscricoes_cnh_social
WHERE TIMESTAMPDIFF(
YEAR,
STR_TO_DATE(data_nascimento, '%d/%m/%Y'),
CURDATE()
) >= '60';

#atividade 8 listar os primeiros 100 candidatos cadastrados 
SELECT *
FROM tb_inscricoes_cnh_social
ORDER BY created_at ASC
LIMIT 100;

#atividade 9 Exibir todas as inscrições realizadas em uma data específica. 
SELECT *
FROM tb_inscricoes_cnh_social
WHERE str_to_date(created_at,'%d/%m/%Y') = '2025/10/08';

#atividade 10 Contar quantas inscrições ocorreram em cada dia. 
SELECT created_at, COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY created_at;

#PARTE 2 AGRUPAMENTO 

#atividade 11 Quantidade de inscrições por município.
SELECT DISTINCT cidade, COUNT(*) AS inscricoes_por_municipio 
FROM tb_inscricoes_cnh_social
GROUP BY cidade;

#atividade 12 Quantidade de inscrições por faixa etária. 
SELECT 
case 
when TIMESTAMPDIFF(YEAR,STR_TO_DATE(data_nascimento, '%d/%m/%Y'), CURDATE()) BETWEEN 0 AND 17 then '0-17'
when TIMESTAMPDIFF(YEAR,STR_TO_DATE(data_nascimento, '%d/%m/%Y'), CURDATE()) BETWEEN 18 AND 26 then '18-26'
when TIMESTAMPDIFF(YEAR,STR_TO_DATE(data_nascimento, '%d/%m/%Y'), CURDATE()) BETWEEN 27 AND 39 then '27-39'
when TIMESTAMPDIFF(YEAR,STR_TO_DATE(data_nascimento, '%d/%m/%Y'), CURDATE()) BETWEEN 40 AND 59 then '40-59'
ELSE '60+'
END AS faixa_etaria,
COUNT(*) AS quantidade_inscricoes 
FROM tb_inscricoes_cnh_social 
GROUP BY faixa_etaria 
ORDER BY faixa_etaria

#atividade 13 Quantidade de inscrições por categoria desejada (A ou B).
SELECT categoria_desejada, COUNT(*) AS quantidade_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY categoria_desejada;

#atividade 14 Quantidade de inscrições por sexo. 

#atividade 15 Quantidade de inscrições por condição PCD. 
SELECT eh_pcd, COUNT(*) AS quantidade_inscricoes 
FROM tb_inscricoes_cnh_social 
GROUP BY eh_pcd;

#atividade 16 Exibir os 10 municípios com mais inscrições.
SELECT
   cidade,
   COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY cidade
ORDER BY total_inscricoes DESC
LIMIT 10;

#atividade 17 Exibir os 10 municípios com menos inscrições.
SELECT
   cidade,
   COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY cidade
ORDER BY total_inscricoes ASC
LIMIT 10;

#atividade 18 Calcular a média de inscrições por município.
SELECT 
   AVG(total_inscricoes) AS media_inscricoes_por_municipio
FROM (
   SELECT 
   cidade,
 COUNT(*) AS total_inscricoes
   FROM tb_inscricoes_cnh_social
   GROUP BY cidade
) AS municipios;

#atividade 19 Identificar o município com maior número de inscrições.
SELECT 
   cidade,
   COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY cidade
ORDER BY total_inscricoes DESC
LIMIT 1;

#atividade 20 Identificar o município com menor número de inscrições.

SELECT 
cidade,
COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY cidade 
ORDER BY total_inscricoes asc
LIMIT 1;

#Parte 3 – Percentuais
#atividade 21. Calcular o percentual de inscrições por faixa etária.
SELECT
   faixa_etaria,
   COUNT(*) AS total_inscricoes,
   ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM tb_inscricoes_cnh_social)), 2) AS percentual
FROM (
   SELECT
   CASE
   WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 18 THEN 'Até 18 anos'
   WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 19 AND 30 THEN '19 a 30 anos'
   WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 31 AND 45 THEN '31 a 45 anos'
   WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 46 AND 60 THEN '46 a 60 anos'
   ELSE 'Acima de 60 anos'
   END AS faixa_etaria
   FROM tb_inscricoes_cnh_social
) AS faixas
GROUP BY faixa_etaria
ORDER BY percentual DESC;

#atividade 22. Calcular o percentual de inscritos PCD e Não PCD
SELECT
   CASE
   WHEN eh_pcd = 1 THEN 'PCD'
   ELSE 'Não PCD'
   END AS categoria,
   COUNT(*) AS total_inscricoes,
   ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM tb_inscricoes_cnh_social)), 2) AS percentual
FROM tb_inscricoes_cnh_social
GROUP BY categoria;

#atividade 23. Calcular o percentual de inscrições por município

SELECT
   cidade,
   COUNT(*) AS total_inscricoes,
   ROUND(
   (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM tb_inscricoes_cnh_social)),
   2
   ) AS percentual
FROM tb_inscricoes_cnh_social
GROUP BY cidade
ORDER BY percentual DESC;

#atividade 24. Identificar qual faixa etária representa a maior parcela dos inscritos.
SELECT
   faixa_etaria,
   COUNT(*) AS total_inscricoes
FROM (
   SELECT
CASE
   WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 18 THEN 'Até 18 anos' 
 WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 19 AND 30 THEN '19 a 30 anos'
WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 31 AND 45 THEN '31 a 45 anos'
WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 46 AND 60 THEN '46 a 60 anos'
   ELSE 'Acima de 60 anos'
   END AS faixa_etaria
   FROM tb_inscricoes_cnh_social
) AS faixas
GROUP BY faixa_etaria
ORDER BY total_inscricoes DESC
LIMIT 1;

#atividade 25. Calcular a participação percentual dos 5 municípios mais inscritos.


#atividade Parte 4 – Relatórios.
#atividade 26. Gerar relatório contendo Município, Total de inscritos e Percentual em relação ao total geral.
SELECT
   cidade AS municipio,
   COUNT(*) AS total_inscritos,
   ROUND(
   (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM tb_inscricoes_cnh_social)),
   2
   ) AS percentual_total
FROM tb_inscricoes_cnh_social
GROUP BY cidade
ORDER BY total_inscritos DESC;tb_inscricoes_cnh_social

#atividade 27  Gerar relatório contendo Faixa etária, Quantidade e Percentual.
SELECT 
CASE 
WHEN data_nascimento < 18 THEN 'Menor de 18'
WHEN data_nascimento BETWEEN 18 AND 29 THEN '18 and 29'
WHEN data_nascimento BETWEEN 30 AND 44 THEN '30 and 44'
WHEN data_nascimento BETWEEN 45 AND 59 THEN '45 and 49'
WHEN data_nascimento >= 60 THEN '60 ou mais'
END AS faixa_etaria,
COUNT(*) AS quantidade,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) over (), 2) AS percentual
FROM tb_inscricoes_cnh_social 
GROUP BY 1 
ORDER BY 1;

#atividade 28 Gerar relatório diário de inscrições contendo Data, Quantidade e Percentual sobre o total.
SELECT
  DATE(data_inscricao) AS data,
  COUNT(*) AS quantidade,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentual
FROM tb_inscricoes_cnh_social
GROUP BY DATE(data_inscricao)
ORDER BY data;

#atividade 29 Exibir os municípios que possuem mais de 5.000 inscrições.

SELECT
  cidade AS municipio,
  COUNT(*) AS quantidade_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY cidade
HAVING COUNT(*) > 5000
ORDER BY quantidade_inscricoes DESC;

#atividade 30 Exibir os municípios que possuem menos de 1.000 inscrições.
SELECT 
cidade AS municipio,
COUNT(*) AS quantidade_inscricoes 
FROM tb_inscricoes_cnh_social 
GROUP BY cidade
HAVING COUNT(*) <1000
ORDER BY quantidade_inscricoes DESC;

#Parte 5 – CASE e Regras de Negócio

#atividade 31 Criar uma coluna calculada chamada faixa_etaria utilizando CASE.
SELECT
    nome_completo,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) < 18 THEN 'Menor de idade'
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 18 AND 59 THEN 'Adulto'
        ELSE 'Idoso'
    END AS faixa_etaria
FROM tb_inscricoes_cnh_social;


#atividade 32 Criar uma coluna calculada chamada situacao_pcd.

SELECT
    nome_completo,
    CASE
        WHEN eh_pcd = 1 THEN 'PCD'
        ELSE 'Não PCD'
    END AS situacao_pcd
FROM tb_inscricoes_cnh_social; 

#atividade 33  Classificar municípios utilizando CASE (Grande, Médio e Pequeno Porte).
SELECT
    cidade,
    CASE
        WHEN cidade IN ('São Luís', 'Imperatriz', 'São José de Ribamar') THEN 'Grande Porte'
        WHEN cidade IN ('Santa Inês', 'Pinheiro', 'Barra do Corda') THEN 'Médio Porte'
        ELSE 'Pequeno Porte'
    END AS porte
FROM tb_inscricoes_cnh_social;

#atividade 34 Exibir apenas municípios classificados como Grande Porte. 
SELECT cidade
FROM tb_inscricoes_cnh_social
WHERE cidade IN ('São Luís', 'Imperatriz', 'São José de Ribamar');

#atividade 35 Contar quantos municípios existem em cada classificação.

SELECT
    CASE
        WHEN cidade IN ('São Luís', 'Imperatriz') THEN 'Grande Porte'
        WHEN cidade IN ('Santa Inês', 'Pinheiro') THEN 'Médio Porte'
        ELSE 'Pequeno Porte'
    END AS classificacao,
    COUNT(*) AS quantidade
FROM tb_inscricoes_cnh_social
GROUP BY classificacao; 

#Parte 6 Desafios avançados. 

#atividade 36. Criar uma consulta que exiba o ranking dos municípios por quantidade de inscrições.
SELECT 
cidade AS municipio,
COUNT(*) AS quantidade_inscricoes,
rank() over (ORDER BY COUNT(*) DESC) AS ranking 
FROM tb_inscricoes_cnh_social 
GROUP BY municipio 
ORDER BY ranking,municipio;

#atividade 37 Exibir os 5 municípios que representam a maior concentração de inscritos.
SELECT
  cidade as municipio,
  COUNT(*) AS quantidade_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY municipio
ORDER BY quantidade_inscricoes DESC, municipio
LIMIT 5;

#atividade 38 Calcular a média diária de inscrições.
SELECT AVG(total_inscricoes) AS media_diaria
FROM (
    SELECT
        DATE(STR_TO_DATE(created_at, '%d/%m/%Y %H:%i')) AS dia,
        COUNT(*) AS total_inscricoes
    FROM tb_inscricoes_cnh_social
    GROUP BY DATE(STR_TO_DATE(created_at, '%d/%m/%Y %H:%i'))
) AS t;

#atividade 39 Identificar o dia com maior número de inscrições.
SELECT
    DATE(STR_TO_DATE(created_at, '%d/%m/%Y %H:%i')) AS dia,
    COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY DATE(STR_TO_DATE(created_at, '%d/%m/%Y %H:%i'))
ORDER BY total_inscricoes DESC
LIMIT 1;


#atividade 40 Identificar o dia com menor número de inscrições.

SELECT 
    DATE(STR_TO_DATE(created_at, '%d/%m/%Y')) AS dia,
    COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY dia
ORDER BY total_inscricoes ASC
LIMIT 1;

#atividade 41 Calcular o acumulado de inscrições por dia.
SELECT dia,total_inscricoes,
SUM(total_inscricoes) over (ORDER BY dia) AS acumulado 
FROM(SELECT DATE(str_to_date(created_at,'%d/%m/%Y %H:%i:%s')) AS dia,
COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
WHERE str_to_date(created_at, '%d/%m/%Y %H:%i:%s') IS NOT NULL
GROUP BY dia) AS resumo



#atividade 42 Comparar cada município com a média estadual de inscrições.
SELECT cidade,total_inscricoes,media_estadual,
CASE 
WHEN total_inscricoes > media_estadual THEN 'Acima da média'
WHEN total_inscricoes < media_estadual THEN 'Abaixo da média'
ELSE 'Na média'
END AS comparacao 
FROM (
SELECT cidade,
COUNT(*) AS total_inscricoes,
(SELECT AVG (total)
FROM(
SELECT COUNT(*) AS total 
FROM tb_inscricoes_cnh_social
GROUP BY cidade) AS medias 
) AS media_estadual
FROM tb_inscricoes_cnh_social
GROUP BY cidade ) AS resultado




#atividade 43 .Exibir municípios acima da média estadual.
SELECT cidade, COUNT(*) AS total_inscritos 
FROM tb_inscricoes_cnh_social
GROUP BY cidade 
HAVING COUNT(*) > (
SELECT AVG(qtd)
FROM ( 
SELECT COUNT(*) AS qtd 
FROM tb_inscricoes_cnh_social
GROUP BY cidade 
)t 
) 
ORDER BY total_inscritos DESC;




#atividade 44. Exibir municípios abaixo da média estadual.
SELECT cidade, COUNT(*) AS total_inscritos 
FROM tb_inscricoes_cnh_social
GROUP BY cidade 
HAVING COUNT(*) < (
SELECT AVG(qtd) 
FROM (
SELECT COUNT(*) AS qtd 
FROM tb_inscricoes_cnh_social
GROUP BY cidade 
) t 
)
ORDER BY total_inscritos ASC;
	














































