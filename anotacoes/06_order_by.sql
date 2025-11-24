-- Top 10 clientes com mais pontos
SELECT 
    *
FROM clientes
ORDER BY QtdePontos DESC
LIMIT 10;

-- Top 10 clientes que foram primeiro cadastrados
-- caso empate, trás o cliente que tem mais ponto primeiro
SELECT 
    *
FROM clientes
WHERE FlTwitch = 1
ORDER BY DtCriacao ASC, QtdePontos DESC
LIMIT 10;