-- Lista de transações com apenas 1 ponto;
SELECT 
    *
FROM transacoes
WHERE QtdePontos = 1;

-- Lista de pedidos realizados no fim de semana;
SELECT 
    *
FROM transacoes
WHERE strftime('%w', DtCriacao) IN ('0', '6');

-- Lista de clientes com 0 (zero) pontos;
SELECT 
    *
FROM transacoes
WHERE QtdePontos = 0;

-- Lista de clientes com 100 a 200 pontos (inclusive ambos);
SELECT 
    *
FROM transacoes
WHERE QtdePontos BETWEEN 100 AND 200;

-- Lista de produtos com nome que começa com “Venda de”;
SELECT 
    *
FROM produtos 
WHERE DescNomeProduto LIKE 'Venda de%';

-- Lista de produtos com nome que termina com “Lover”;
SELECT 
    *
FROM produtos 
WHERE DescNomeProduto LIKE '%Lover';

-- Lista de produtos que são “chapéu”;
SELECT 
    *
FROM produtos 
WHERE DescNomeProduto LIKE '%chapéu%';

-- Lista de transações com o produto “Resgatar Ponei”;
SELECT 
    *
FROM transacao_produto t1
JOIN produtos t2 on t1.IdProduto = t2.IdProduto
WHERE t2.DescNomeProduto = 'Resgatar Ponei';

-- Listar todas as transações adicionando uma coluna nova sinalizando “alto”, “médio” e “baixo” para o valor dos pontos [<10 ; <500; >=500]
SELECT 
    *,
    CASE
        WHEN QtdePontos < 10 THEN 'baixo'
        WHEN QtdePontos < 500 THEN 'médio'
        WHEN QtdePontos >= 500 THEN 'alto'
    END AS grau_ponto
FROM transacoes;