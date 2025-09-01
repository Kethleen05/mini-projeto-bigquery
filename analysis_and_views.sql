-- ANÁLISE DE DADOS --

-- Pergunta 1: Qual o nome dos clientes que moram no estado de 'SP'?
SELECT Nome_Cliente
FROM livraria-devsaber-47818.Grupo_3_14.Clientes
WHERE Estado_Cliente = 'SP';

-- Pergunta 2: Quais produtos pertencem à categoria 'Ficção Científica'?
SELECT Nome_Produto
FROM livraria-devsaber-47818.Grupo_3_14.Produtos
WHERE Categoria_Produto = 'Ficção Científica';

-- Pergunta 3: Listar todas as vendas, mostrando o nome do cliente, o nome do produto e a data da venda. Ordene pela data.
SELECT
    C.Nome_Cliente,
    P.Nome_Produto,
    V.Data_Venda
FROM livraria-devsaber-47818.Grupo_3_14.Vendas AS V
JOIN livraria-devsaber-47818.Grupo_3_14.Clientes AS C ON V.ID_Cliente = C.ID_Cliente
JOIN livraria-devsaber-47818.Grupo_3_14.Produtos AS P ON V.ID_Produto = P.ID_Produto
ORDER BY V.Data_Venda;

-- Pergunta 4: Qual o valor total de cada venda? (quantidade * preço)
SELECT
    V.ID_Venda,
    (V.Quantidade * P.Preco_Produto) AS Valor_Total
FROM livraria-devsaber-47818.Grupo_3_14.Vendas AS V
JOIN livraria-devsaber-47818.Grupo_3_14.Produtos AS P ON V.ID_Produto = P.ID_Produto;

-- Pergunta 5: Qual o produto mais vendido em termos de quantidade?
SELECT
    P.Nome_Produto,
    SUM(V.Quantidade) AS Total_Quantidade_Vendida
FROM livraria-devsaber-47818.Grupo_3_14.Vendas AS V
JOIN livraria-devsaber-47818.Grupo_3_14.Produtos AS P ON V.ID_Produto = P.ID_Produto
GROUP BY P.Nome_Produto
ORDER BY Total_Quantidade_Vendida DESC
LIMIT 1;

-- CRIAÇÃO DA VIEW --
CREATE OR REPLACE VIEW livraria-devsaber-47818.Grupo_3_14.v_relatorio_vendas_detalhado AS
SELECT
    V.ID_Venda,
    V.Data_Venda,
    C.Nome_Cliente,
    C.Estado_Cliente,
    P.Nome_Produto,
    P.Categoria_Produto,
    V.Quantidade,
    P.Preco_Produto,
    (V.Quantidade * P.Preco_Produto) AS Valor_Total
FROM livraria-devsaber-47818.Grupo_3_14.Vendas AS V
JOIN livraria-devsaber-47818.Grupo_3_14.Clientes AS C ON V.ID_Cliente = C.ID_Cliente
JOIN livraria-devsaber-47818.Grupo_3_14.Produtos AS P ON V.ID_Produto = P.ID_Produto;