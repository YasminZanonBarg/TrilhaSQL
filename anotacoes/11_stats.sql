-- Agregação = Expremer as tabelas / Dados sumarizados
SELECT
    ROUND(AVG(QtdePontos), 2) AS MediaCarteira,
    MIN(QtdePontos) AS MinimoCarteira,
    MAX(QtdePontos) AS MaximoCarteira,
    SUM(FlTwitch) QtdeClientesTwitch,
    SUM(FlEmail) QtdeClientesEmail
FROM clientes;