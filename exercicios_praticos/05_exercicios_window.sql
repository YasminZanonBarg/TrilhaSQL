-- 09) Quantidade de transações Acumuladas ao longo do tempo?
SELECT * FROM clientes LIMIT 10
SELECT * FROM transacoes LIMIT 10
SELECT * FROM transacao_produto LIMIT 10
SELECT * FROM produtos LIMIT 10


-- 13) Dos clientes que começaram SQL no primeiro dia, quantos chegaram ao 5o dia?
SELECT 
    COUNT(DISTINCT IdCliente)
FROM transacoes AS t1
WHERE 
    substr(DtCriacao, 1, 10) = '2025-08-29'
    AND t1.IdCliente IN (
        SELECT 
            DISTINCT IdCliente
        FROM transacoes
        WHERE 
            substr(DtCriacao, 1, 10) = '2025-08-25'
    );


-- 14) Como foi a curva de Churn do Curso de SQL?
-- Churn = cancelamento

WITH tb_clientes_primeiro_dia AS (
    SELECT 
        * 
    FROM transacoes 
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
)

SELECT 
    substr(t2.DtCriacao, 1, 10) AS data,
    count(DISTINCT t1.IdCliente) as qtdCliente,
    1 - 1. * count(DISTINCT t1.IdCliente) / (select count(DISTINCT IdCliente) from tb_clientes_primeiro_dia) AS porcentual_churn
FROM tb_clientes_primeiro_dia AS t1
LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente
WHERE 
    t2.DtCriacao >= '2025-08-25'
    AND t2.DtCriacao < '2025-08-30'
GROUP BY data;


-- 15) Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?
WITH tb_prim_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_dias_curso AS (
    SELECT 
        DISTINCT 
        IdCliente, 
        substr(DtCriacao, 1, 10) AS presenteDia
    FROM transacoes
    WHERE 
        DtCriacao >= '2025-08-25'
        AND DtCriacao < '2025-08-30'
    ORDER BY IdCliente, presenteDia
),

tb_cliente_dias AS (
    SELECT 
        t1.IdCliente,
        COUNT(presenteDia) as qtdeDias
    FROM tb_prim_dia AS t1
    JOIN tb_dias_curso t2
    ON t1.idCliente = t2.idCliente
    GROUP BY t1.IdCliente
)

SELECT AVG(qtdeDias) FROM tb_cliente_dias;


-- 16) Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?
WITH clientes_janeiro AS (
    SELECT
        DISTINCT idCliente
    FROM clientes
    WHERE strftime('%m', substr(DtCriacao, 1, 10)) = '01'
),

clientes_aulas_sql AS (
    SELECT 
        DISTINCT idCliente
    FROM transacoes
    WHERE 
        DtCriacao >= '2025-08-25'
        AND DtCriacao < '2025-08-30'
)

SELECT 
    COUNT(t1.IdCliente) AS quantidade_clientes
FROM clientes_janeiro AS t1
INNER JOIN clientes_aulas_sql AS t2 ON t1.IdCliente = t2.IdCliente;


-- 17) Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?
WITH alunos_dia_1 AS (
    SELECT 
        DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

relacao_cliente_dias AS (
    SELECT 
        t1.IdCliente,
        substr(t2.DtCriacao, 1, 10) AS Dia,
        count(*) AS QtdeInteracoes
    FROM alunos_dia_1 AS t1
    LEFT JOIN transacoes AS t2 
    ON t1.IdCliente = t2.IdCliente
    AND t2.DtCriacao >= '2025-08-25'
    AND t2.DtCriacao < '2025-08-30'
    GROUP BY t1.IdCliente, Dia
    ORDER BY QtdeInteracoes DESC
),

tb_rn AS (
    SELECT 
        *,
        row_number() OVER (PARTITION BY IdCliente ORDER BY QtdeInteracoes DESC, Dia) as rn
    FROM relacao_cliente_dias
)

SELECT *
FROM tb_rn
WHERE rn = 1;