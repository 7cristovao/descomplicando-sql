-- Databricks notebook source
/* 
1. Qual pedido com maior valor de frete?  E o menor?
2. Qual vendedor tem mais pedidos?
3. Qual vendedor tem mais itens vendidos? E o com menos?
4. Qual dia tivemos mais pedidos?
5. Quantos vendedores são do estado de São Paulo?
6. Quantos vendedores são de Presidente Prudente?
7. Quantos clientes são do estado do Rio de Janeiro?
8. Quantos produtos são de construção?
9. Qual o valor médio de um pedido? E do frete?
10. Em média os pedidos são de quantas parcelas de cartão? E o valor médio por parcela?
11. Quanto tempo em média demora para um pedido chegar depois de aprovado?
12. Qual estado tem mais vendedores?
13. Qual cidade tem mais clientes?
14. Qual categoria tem mais itens?
15. Qual categoria tem maior peso médio de produto?
16. Qual a série histórica de pedidos por dia? E receita?
17. Qual produto é o campeão de vendas? Em receita? Em quantidade? */

-- COMMAND ----------

/* 1. Qual pedido com maior valor de frete? E o menor? */

SELECT max(vlFrete) as maiorFrete,
       min(vlFrete) as menorFrete

FROM silver.olist.item_pedido

/* Ficou incorreto pois é necessário agrupar por pedido */ 
/* ver a correção no arquivo EXERCICIOS_CORRECAO */
/* Desta forma aparece apenas o maior frete por item de pedido */
/* ver a correção no arquivo EXERCICIOS_CORRECAO */

-- COMMAND ----------

/* 2. Qual vendedor tem mais pedidos? */

SELECT idVendedor,
       count(idPedido)
FROM silver.olist.item_pedido 
GROUP BY idVendedor ORDER BY count(idPedido) DESC LIMIT 1

/* Incorreto porque a pergunta é: qual vendedor tem mais pedidos e não quantos itens cada vendedor vendeu. O mesmo pedido vai se repetir. Para não contar o mesmo pedido mais de uma vez, a gente usa o DISTINCT. */
/* ver a correção no arquivo EXERCICIOS_CORRECAO */

-- COMMAND ----------

/* 3. Qual vendedor tem mais itens vendidos? E o com menos? */
/* Com mais */
SELECT idVendedor,
       count(idPedidoItem) AS qteItensPorPedido
FROM silver.olist.item_pedido 
GROUP BY idVendedor
ORDER BY qteItensPorPedido DESC LIMIT 1
/* Correto */

-- COMMAND ----------

/* 3. Qual vendedor tem mais itens vendidos? E o com menos? */
/* Com menos */
SELECT idVendedor,
       count(idPedidoItem) AS qteItensPorPedido
FROM silver.olist.item_pedido 
GROUP BY idVendedor
ORDER BY qteItensPorPedido ASC
/* Correto */ 

-- COMMAND ----------

/* 4. Qual dia tivemos mais pedidos? */
SELECT date(dtPedido),
       count(idPedido) AS qtePedidos
FROM silver.olist.pedido 
GROUP BY date(dtPedido)
ORDER BY qtePedidos DESC LIMIT 1
/* Correto */

-- COMMAND ----------

/* 5. Quantos vendedores são do estado de São Paulo? */
SELECT descUF,
       count(idVendedor) AS qteVendedores
FROM silver.olist.vendedor
GROUP BY descUF HAVING descUF = 'SP'
/* Correto */

-- COMMAND ----------

/* 6. Quantos vendedores são de Presidente Prudente? */
SELECT descCidade,
       count(idVendedor) AS qteVendedores
FROM silver.olist.vendedor
GROUP BY descCidade HAVING descCidade = 'presidente prudente'
/* Correto */

-- COMMAND ----------

/* 7. Quantos clientes são do estado do Rio de Janeiro? */
SELECT descUF,
       count(idCliente) AS qteClientes
FROM silver.olist.cliente
GROUP BY descUF HAVING descUF = 'RJ'
/* Correto */

-- COMMAND ----------

/* 8. Quantos produtos são de construção? */

SELECT descCategoria,
       count(DISTINCT idProduto) AS qteProduto
FROM silver.olist.produto 
WHERE descCategoria LIKE '%construcao%'
GROUP BY descCategoria
/* Correto */
/* Faltou totalizar */


-- COMMAND ----------

/* 9. Qual o valor médio de um pedido? E do frete? */
SELECT avg(vlPreco) AS mediaPrecoPedido,
       avg(vlFrete) AS mediaFretePedido
FROM silver.olist.item_pedido
/* Incorreto */
/* Esta tabela está para item-pedido, ou seja, não posso calcular diretamente a média destas coisas */
/* A gente deveria somar primeiro a quantidade de preços e dividir pela contagem distinta de idPedidom isso é a média */
/* Chegamos aos valores médios por item */
/* Também a gente chegou aos preços médios de frete por item, portanto incorreto */


-- COMMAND ----------

/* 10. Em média os pedidos são de quantas parcelas de cartão? E o valor médio por parcela? */
/* Parcelas de cartão */
/* Correto */
SELECT descTipoPagamento,
       avg(nrParcelas) AS mediaQteParcelas
FROM silver.olist.pagamento_pedido
WHERE descTipoPagamento = 'credit_card'
GROUP BY descTipoPagamento 

-- COMMAND ----------

/* 10. Em média os pedidos são de quantas parcelas de cartão? E o valor médio por parcela? */
/* Valor médio por parcela */
/* Correto */
SELECT descTipoPagamento,
       avg(vlPagamento / nrParcelas) AS mediaValorParcela
FROM silver.olist.pagamento_pedido
WHERE descTipoPagamento = 'credit_card' AND nrParcelas > 0
GROUP BY descTipoPagamento

-- COMMAND ----------

/* 11. Quanto tempo em média demora para um pedido chegar depois de aprovado? */
SELECT avg(datediff(dtEntregue, dtAprovado)) AS mediaDiasPedidoDepoisDeAprovado
FROM silver.olist.pedido
WHERE descSituacao = 'delivered'
/* Correto */

-- COMMAND ----------

/* 12. Qual estado tem mais vendedores? */

SELECT descUF,
       count(idVendedor) AS totalVendedores
FROM silver.olist.vendedor GROUP BY descUF
ORDER BY totalVendedores DESC LIMIT 1
/* Correto */

-- COMMAND ----------

/* 13. Qual cidade tem mais clientes? */
SELECT descCidade,
       count(idCliente) AS totalClientes
FROM silver.olist.cliente
GROUP BY descCidade
ORDER BY totalClientes DESC LIMIT 1
/* Correto */

-- COMMAND ----------

/* 14. Qual categoria tem mais itens? */
SELECT descCategoria,
       count(idProduto) AS totalItens
FROM silver.olist.produto
GROUP BY descCategoria
ORDER BY totalItens DESC LIMIT 1
/* Correto */

-- COMMAND ----------

/* 15. Qual categoria tem maior peso médio de produto? */
SELECT descCategoria,
       avg(vlPesoGramas) AS mediaPeso
FROM silver.olist.produto
GROUP BY descCategoria
ORDER BY mediaPeso DESC LIMIT 1
/* Correto */

-- COMMAND ----------

/* 16. Qual a série histórica de pedidos por dia? E receita? */
/* Pedidos por dia (TABELA) */
SELECT any_value(date(dtPedido)) AS dtPedido,
       count(date(dtPedido)) AS totalPedidosPorDia
FROM silver.olist.pedido
GROUP BY date(dtPedido)
ORDER BY date(dtPedido)
/* Correto */

-- COMMAND ----------

/* 16. Qual a série histórica de pedidos por dia? E receita? */
/* Média de Pedidos por dia */
/* Sem correção da parte da receita */

SELECT AVG(totalPedidosPorDia) AS mediaTotalPedidos
FROM (
    SELECT COUNT(date(dtPedido)) AS totalPedidosPorDia
    FROM silver.olist.pedido
    GROUP BY date(dtPedido)
) AS subquery;

-- COMMAND ----------

/* 16. Qual a série histórica de pedidos por dia? E receita? */
/* Receita */
/* Sem correção da parte da receita */

SELECT sum(vlPreco) AS receita FROM silver.olist.item_pedido

-- COMMAND ----------

/* 17. Qual produto é o campeão de vendas? Em receita? Em quantidade? */
/* Em quantidade */
SELECT idProduto,
       count(idProduto) AS quantidade
FROM silver.olist.item_pedido
GROUP BY idProduto
ORDER BY quantidade DESC LIMIT 1

/* Correto */

-- COMMAND ----------

/* 17. Qual produto é o campeão de vendas? Em receita? Em quantidade? */
/* Em receita */
SELECT idProduto,
       sum(vlPreco) AS receita
FROM silver.olist.item_pedido
GROUP BY idProduto
ORDER BY receita DESC LIMIT 1

/* Correto */

-- COMMAND ----------


