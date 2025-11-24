SELECT
    *
FROM transacao_produto
WHERE IdProduto IN (
    SELECT 
        IdProduto
    FROM produtos 
    WHERE DescNomeProduto = 'Resgatar Ponei'
)