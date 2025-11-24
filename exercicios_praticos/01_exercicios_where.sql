-- Selecione todos os clientes com email cadastrado
SELECT  *
FROM clientes
WHERE FlEmail = 1
LIMIT 10;

-- Selecione todas as transações de 50 pontos (exatos)
SELECT *
FROM transacoes
WHERE QtdePontos = 50
LIMIT 10;

-- Selecione todos os clientes com mais de 500 pontos
SELECT *
FROM clientes
WHERE QtdePontos > 500
LIMIT 10;

-- Selecione produtos que contêm 'churn' no nome
SELECT *
FROM produtos
WHERE DescNomeProduto LIKE '%churn%' -- Operador mais custoso do que usar o IN
LIMIT 10;