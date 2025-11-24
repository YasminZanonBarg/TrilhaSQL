SELECT
    count(*)
FROM clientes;

-- Valores distintos para a combinação de colunas que foram passadas:
SELECT
    DISTINCT FlTwitch, FlEmail
FROM clientes