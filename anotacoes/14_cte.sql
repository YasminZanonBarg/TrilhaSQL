-- SELECT 
--     COUNT(DISTINCT IdCliente)
-- FROM transacoes AS t1
-- WHERE 
--     substr(DtCriacao, 1, 10) = '2025-08-29'
--     AND t1.IdCliente IN (
--         SELECT 
--             DISTINCT IdCliente
--         FROM transacoes
--         WHERE 
--             substr(DtCriacao, 1, 10) = '2025-08-25'
--     );


-- Transofrmando o código a cima para CTE
WITH tb_cliente_primeiro_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_cliente_ultimo_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-29'
),

tb_join AS (
    SELECT 
        t1.IdCliente AS primCliente,
        t2.IdCliente AS ultCliente
    FROM tb_cliente_primeiro_dia AS t1
    LEFT JOIN tb_cliente_ultimo_dia AS t2
    ON t1.IdCliente = t2.idCliente
)

SELECT 
    COUNT(primCliente) AS totalPrimCliente,
    COUNT(ultCliente) AS totalUltCliente,
    CAST(COUNT(ultCliente) / COUNT(primCliente) AS DOUBLE)  * 100  AS diferencaPorcentagem
FROM tb_join;