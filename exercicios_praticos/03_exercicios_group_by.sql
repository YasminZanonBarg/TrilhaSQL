-- 01) Quantos clientes tem email cadastrado?
SELECT 
    SUM(flEmail) as QtdeClienteEmail
FROM clientes;


-- 02) Qual cliente juntou mais pontos positivos em 2025-05?
SELECT 
    IdCliente,
    SUM(QtdePontos) as SomaPontos
FROM clientes
WHERE 
    QtdePontos > 0
    AND strftime('%Y-%m', substr(DtCriacao, 1, 10)) = '2025-05'
GROUP BY IdCliente
ORDER BY SomaPontos DESC
LIMIT 1;


-- 03) Qual cliente fez mais transações no ano de 2024?
SELECT 
    IdCliente,
    COUNT(*) as TotalTransacoes
FROM transacoes
WHERE 
    strftime('%Y', substr(DtCriacao, 1, 10)) = '2024'
GROUP BY IdCliente
ORDER BY TotalTransacoes DESC
LIMIT 1;


-- 04) Quantos produtos são de rpg?
SELECT 
    COUNT(*) AS QtdeRpg
FROM produtos
WHERE 
    DescCategoriaProduto = 'rpg';


-- 05) Qual o valor médio de pontos positivos por dia?
SELECT 
    substr(DtCriacao, 1, 10) AS Dia,
    ROUND(AVG(QtdePontos), 2) as MediaPontosDia
FROM transacoes
WHERE 
    QtdePontos > 0
GROUP BY Dia;


-- 06) Qual dia da semana que tem mais pedidos em 2025?
SELECT
    CASE
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '0' THEN 'Domingo'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '1' THEN 'Segunda'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '2' THEN 'Terça'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '3' THEN 'Quarta'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '4' THEN 'Quinta'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '5' THEN 'Sexta'
        WHEN strftime('%w', substr(DtCriacao, 1, 10)) = '6' THEN 'Sábado'
    END AS DiaSemana,
    COUNT(*) AS QtdePedidos
FROM transacoes
WHERE 
    substr(DtCriacao, 1, 4) = '2025'
GROUP BY DiaSemana
ORDER BY QtdePedidos DESC
LIMIT 1;


-- 07) Qual o produto mais transacionado?
SELECT 
    IdProduto,
    SUM(QtdeProduto) AS SomaQtdeProduto
FROM transacao_produto
GROUP BY IdProduto
ORDER BY SomaQtdeProduto DESC
LIMIT 1;


-- 08) Qual o produto com mais pontos transacionados?
SELECT 
    t1.IdProduto,
    SUM(t2.QtdePontos) AS SomaPontos
FROM transacao_produto t1
JOIN transacoes t2 ON t1.IdTransacao = t2.IdTransacao
WHERE
    t2.QtdePontos > 0
GROUP BY t1.IdProduto
ORDER BY SomaPontos DESC
LIMIT 1;