SELECT 
    DATE(created_at) AS dia,
    COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY DATE(created_at)
ORDER BY dia;

SELECT 
    cidade,
    COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY cidade
ORDER BY total_inscricoes DESC
LIMIT 5;

SELECT 
    CASE
        WHEN eh_pcd = 1 THEN 'PCD'
        WHEN eh_pcd = 0 THEN 'Não PCD'
    END AS tipo,
    COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY eh_pcd;

SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(data_nascimento,'%d/%m/%Y'), CURDATE()) BETWEEN 18 AND 24 THEN '18-24'
        WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(data_nascimento,'%d/%m/%Y'), CURDATE()) BETWEEN 25 AND 34 THEN '25-34'
        WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(data_nascimento,'%d/%m/%Y'), CURDATE()) BETWEEN 35 AND 44 THEN '35-44'
        WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(data_nascimento,'%d/%m/%Y'), CURDATE()) BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60+'
    END AS faixa_etaria,
    COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY faixa_etaria
ORDER BY MIN(
    TIMESTAMPDIFF(YEAR, STR_TO_DATE(data_nascimento,'%d/%m/%Y'), CURDATE())
);

SELECT 
    cidade,
    COUNT(*) AS total_inscricoes
FROM tb_inscricoes_cnh_social
GROUP BY cidade
ORDER BY total_inscricoes DESC;


SELECT 
    DATE(created_at) AS dia,
    COUNT(*) AS total_inscricoes,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM tb_inscricoes_cnh_social),
        2
    ) AS percentual
FROM tb_inscricoes_cnh_social
GROUP BY DATE(created_at)
ORDER BY dia;

SELECT
    faixa_etaria,
    total_inscricoes,
    ROUND(
        total_inscricoes * 100.0 /
        (SELECT COUNT(*) FROM tb_inscricoes_cnh_social),
        2
    ) AS percentual
FROM (
    SELECT
        CASE
            WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(data_nascimento,'%d/%m/%Y'), CURDATE()) BETWEEN 18 AND 24 THEN '18-24'
            WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(data_nascimento,'%d/%m/%Y'), CURDATE()) BETWEEN 25 AND 34 THEN '25-34'
            WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(data_nascimento,'%d/%m/%Y'), CURDATE()) BETWEEN 35 AND 44 THEN '35-44'
            WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(data_nascimento,'%d/%m/%Y'), CURDATE()) BETWEEN 45 AND 59 THEN '45-59'
            ELSE '60+'
        END AS faixa_etaria,
        COUNT(*) AS total_inscricoes
    FROM tb_inscricoes_cnh_social
    GROUP BY faixa_etaria
) AS dados
ORDER BY total_inscricoes DESC;

SELECT
    CASE
        WHEN eh_pcd = 1 THEN 'PCD'
        WHEN eh_pcd = 0 THEN 'Não PCD'
    END AS tipo,
    COUNT(*) AS total_inscricoes,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM tb_inscricoes_cnh_social),
        2
    ) AS percentual
FROM tb_inscricoes_cnh_social
GROUP BY eh_pcd;


