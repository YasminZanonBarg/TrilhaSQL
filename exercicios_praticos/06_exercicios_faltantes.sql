-- 1) Quantidade de transacoes acumuladas ao longo do tempo?
WITH transacoes_dia AS (
    SELECT
        substr(DtCriacao, 1, 10) AS Dia,
        COUNT(DISTINCT IdTransacao) AS QtdeTransacao
    FROM transacoes
    GROUP BY Dia
    ORDER BY Dia
)

SELECT 
    *,
    SUM(QtdeTransacao) OVER(ORDER BY Dia) AS Acumulado
FROM transacoes_dia;


-- 2) Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?
WITH cadastros_por_dia AS (
    SELECT 
        substr(DtCriacao, 1, 10) AS Dia,
        COUNT(DISTINCT IdCliente) AS QtdeClientesAbsolutos
    FROM clientes
    GROUP BY Dia
    ORDER BY Dia
)

SELECT 
    *,
    SUM(QtdeClientesAbsolutos) OVER(ORDER BY Dia) AS QtdeClientesAcumulado
FROM cadastros_por_dia;


-- 3) Qual o dia da semana mais ativo de cada usuário?
WITH transacoes_dia_semana_cliente AS (
    SELECT
        IdCliente,
        strftime('%w', substr(DtCriacao, 1, 10)) AS DiaSemana,
        COUNT(DISTINCT IdTransacao) AS QtdeTransacao
    FROM transacoes
    GROUP BY IdCliente, DiaSemana
),

transacoes_dia_semana_cliente_enumerada AS (
    SELECT 
        *,
        row_number() OVER(PARTITION BY IdCliente ORDER BY QtdeTransacao DESC, DiaSemana) AS rn
    FROM transacoes_dia_semana_cliente
)

SELECT 
    * 
FROM transacoes_dia_semana_cliente_enumerada 
WHERE rn = 1;


-- 4) Saldo de pontos acumulado de cada usuário

WITH relacao_cliente_pontos AS (
    SELECT
        IdCliente,
        substr(DtCriacao, 1, 10) AS Dia,
        SUM(QtdePontos) AS QtdePontosAbsolutos
    FROM transacoes
    GROUP BY IdCliente, Dia
    ORDER BY IdCliente, Dia
)

SELECT 
    *,
    SUM(QtdePontosAbsolutos) OVER(PARTITION BY IdCliente ORDER BY Dia) AS QtdePontosAcumulados 
FROM relacao_cliente_pontos;
