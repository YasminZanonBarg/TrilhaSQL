-- 01) Qual categoria tem mais produtos vendidos?
SELECT 
    t2.DescCategoriaProduto,
    SUM(QtdeProduto) AS SomaVendaProduto
FROM transacao_produto AS t1
JOIN produtos AS t2 ON T1.IdProduto = t2.IdProduto
GROUP BY t2.DescCategoriaProduto
ORDER BY SomaVendaProduto DESC
LIMIT 1;


-- 02) Em 2024, quantas transações de Lovers tivemos?
SELECT 
    COUNT(DISTINCT t1.IdTransacao) AS QtdeTransacoes
FROM transacoes AS t1
JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
JOIN produtos t3 ON t2.IdProduto = t3.IdProduto
WHERE
    SUBSTR(t1.DtCriacao, 1, 4) = '2024'
    AND t3.DescCategoriaProduto = 'lovers'


-- 03) Qual mês tivemos mais lista de presença assinada?
SELECT 
    SUBSTR(t1.DtCriacao, 1, 7) AS Safra,
    SUM(t2.QtdeProduto) AS QtdeProduto
FROM transacoes AS t1
JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
JOIN produtos t3 ON t2.IdProduto = t3.IdProduto
WHERE
    t3.DescNomeProduto = 'Lista de presença'
GROUP BY Safra
ORDER BY QtdeProduto DESC
LIMIT 1;


-- 04) Qual o total de pontos trocados no Stream Elements em Junho de 2025?
-- SELECT 
--     SUM(t1.QtdePontos) AS QtdePontos
-- FROM transacoes AS t1
-- JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
-- JOIN produtos t3 ON t2.IdProduto = t3.IdProduto
-- WHERE
--     t3.DescCategoriaProduto = 'streamelements'
--     AND SUBSTR(t1.DtCriacao, 1, 7) = '2025-06';


-- 05) Quais clientes mais perderam pontos por Lover?
SELECT 
    IdCliente,
    SUM(t1.QtdePontos) AS QtdePontos
FROM transacoes AS t1
JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
JOIN produtos t3 ON t2.IdProduto = t3.IdProduto
WHERE
    t1.QtdePontos < 0
    AND t3.DescCategoriaProduto = 'lovers'
GROUP BY IdCliente
ORDER BY QtdePontos
LIMIT 5;


-- 06) Quais clientes assinaram a lista de presença no dia 2025/08/25?
SELECT 
    DISTINCT IdCliente
FROM transacoes AS t1
JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
JOIN produtos t3 ON t2.IdProduto = t3.IdProduto
WHERE
    SUBSTR(t1.DtCriacao, 1, 10) = '2025-08-25'
    AND t3.DescNomeProduto = 'Lista de presença';


-- 07) Do início ao fim do nosso curso (2025/08/25 a 2025/08/29), quantos clientes assinaram a lista de presença?
SELECT 
    COUNT(DISTINCT IdCliente)
FROM transacoes AS t1
JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
JOIN produtos t3 ON t2.IdProduto = t3.IdProduto
WHERE
    SUBSTR(t1.DtCriacao, 1, 10) BETWEEN '2025-08-25' AND '2025-08-29'
    AND t3.DescNomeProduto = 'Lista de presença';


-- 08) Clientes mais antigos, tem mais frequência de transação? MENTIRA
SELECT 
    julianday('now') - julianday(SUBSTR(t1.DtCriacao, 1, 10)) AS IdadeBase,
    COUNT(IdTransacao) AS QtdeTransacao
FROM transacoes t1
JOIN clientes t2 ON t1.idCliente = t2.idCliente
GROUP BY IdadeBase
ORDER BY QtdeTransacao DESC
LIMIT 10;