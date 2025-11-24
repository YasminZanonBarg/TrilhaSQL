-- Engajamento por dia cliente
WITH alunos_dia AS (
    SELECT 
        IdCliente,
        substr(DtCriacao, 1, 10) AS Dia,
        count(DISTINCT idTransacao) as QtdeTransacao
    FROM transacoes
    WHERE 
        DtCriacao >= '2025-08-25'
        AND DtCriacao < '2025-08-30'
    GROUP BY IdCliente, Dia
),

tb_lag AS (
    SELECT 
        *,
        SUM(QtdeTransacao) OVER(PARTITION BY IdCliente ORDER BY Dia) AS Acumulado,
        LAG(QtdeTransacao) OVER(PARTITION BY IdCliente ORDER BY Dia) AS LagTransacao
    FROM alunos_dia
)

SELECT 
    *,
    (1.* QtdeTransacao / LagTransacao) AS Engajamento
FROM tb_lag



-- Recorrência de retorno das pessoas para assistir o TeoMeWhy em 2025
WITH alunos_dia AS (
    SELECT 
        DISTINCT
        IdCliente,
        substr(DtCriacao, 1, 10) AS DiaAtual
    FROM transacoes
    WHERE 
        substr(DtCriacao, 1, 4) = '2025'
    ORDER BY IdCliente, DiaAtual
),

alunos_dia_completa AS (
    SELECT 
        *,
        LAG(DiaAtual) OVER(PARTITION BY IdCliente) AS UltimoDiaVisto
    FROM alunos_dia
),

alunos_dia_completa_com_recencia AS (
    SELECT
        *,
        (julianday(DiaAtual) - julianday(UltimoDiaVisto)) AS DiferencaDias
    FROM alunos_dia_completa
),

recencia_por_cliente AS (
    SELECT 
        IdCliente,
        AVG(DiferencaDias) AS MediaRecencia
    FROM alunos_dia_completa_com_recencia
    GROUP BY IdCliente
)

SELECT 
    AVG(MediaRecencia)
FROM recencia_por_cliente;