SELECT 
    IdCliente,
    QtdePontos,
    QtdePontos + 10 AS QtdePontosPlus10,
    QtdePontos * 2  AS QtdePontosDouble,
    -- substr(nome_campo, posicao_inicial_desejada, posicao_final_desejada)
    datetime(substr(DtCriacao, 1, 19)) AS dtCriacaoNova,
    strftime('%w', datetime(substr(DtCriacao, 1, 19))) AS diaSemana
FROM clientes 
LIMIT 10;