SELECT
    SUM(QtdePontos) AS Total,
    SUM(CASE
        WHEN QtdePontos > 0 THEN QtdePontos
        END ) AS QtdePontosPositivos,
    SUM(CASE
        WHEN QtdePontos < 0 THEN QtdePontos
        END)AS QtdePontosNegativos
FROM transacoes
WHERE
    DtCriacao >= '2025-07-01'
    AND DtCriacao < '2025-08-01';