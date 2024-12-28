-- Databricks notebook source
/*

1. Qual categoria tem mais produtos vendidos?
2. Qual categoria tem produtos mais caros, em média? E Mediana?
3. Qual categoria tem maiores fretes, em média?
4. Os clientes de qual estado pagam mais frete, em média?
5. Clientes de quais estados avaliam melhor, em média? Proporção de 5?
6. Vendedores de quais estados têm as piores reputações?
7. Quais estados de clientes levam mais tempo para a mercadoria chegar?
8. Qual meio de pagamento é mais utilizado por clientes do RJ?
9. Qual estado sai mais ferramentas?
10. Qual estado tem mais compras por cliente?

*/

-- COMMAND ----------

/* 1. Qual categoria tem mais produtos vendidos? */
SELECT t3.descCategoria,
       COUNT(t2.idProduto) AS totalProdutosVendidos

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.produto AS t3
ON t2.idProduto = t3.idProduto

WHERE t3.descCategoria IS NOT NULL 

GROUP BY t3.descCategoria

ORDER BY totalProdutosVendidos DESC

-- CORRETO

-- COMMAND ----------

/* 2. Qual categoria tem produtos mais caros, em média? E Mediana? */
SELECT t2.descCategoria,
       AVG(t1.vlPreco) AS avgPreco

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY avgPreco DESC

-- CORRETO

-- COMMAND ----------

/* 2. Qual categoria tem produtos mais caros, em média? E Mediana? */
SELECT t2.descCategoria,
       PERCENTILE(t1.vlPreco, 0.5) AS medianaPreco

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY medianaPreco DESC

-- CORRETO

-- COMMAND ----------

/* 3. Qual categoria tem maiores fretes, em média? */

SELECT t3.descCategoria, AVG(t2.vlFrete) AS avgFrete

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.produto AS t3
ON t2.idProduto = t3.idProduto

GROUP BY t3.descCategoria

ORDER BY avgFrete DESC

-- CORRETO

-- COMMAND ----------

/* 4. Os clientes de qual estado pagam mais frete, em média? */
SELECT t3.descUF,
       AVG(t2.vlFrete) AS avgFrete
FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t1.idCliente = t3.idCliente

GROUP BY t3.descUF

ORDER BY avgFrete DESC

-- INCORRETO - deveria ter considerado a soma de todos os fretes dividido pela contagem da quantidade de fretes
-- esta é a média de fretes por item

-- COMMAND ----------

/* 5. Clientes de quais estados avaliam melhor, em média? Proporção de 5? */
SELECT t1.descUF,
       AVG(t3.vlNota) AS avgNota

FROM silver.olist.cliente AS t1

LEFT JOIN silver.olist.pedido AS t2
ON t1.idCliente = t2.idCliente 

LEFT JOIN silver.olist.avaliacao_pedido AS t3
ON t2.idPedido = t3.idPedido

GROUP BY t1.descUF

ORDER BY avgNota DESC

-- CORRETO

-- COMMAND ----------

/* 6. Vendedores de quais estados têm as piores reputações? */
SELECT t3.descUF,
       AVG(t4.vlNota) AS avgNota

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

LEFT JOIN silver.olist.avaliacao_pedido AS t4
ON t1.idPedido = t4.idPedido

GROUP BY t3.descUF

ORDER BY avgNota ASC

-- CORRETO

-- COMMAND ----------

/* 7. Quais estados de clientes levam mais tempo para a mercadoria chegar? */

SELECT t3.descUF,
      AVG(date_diff(dtEntregue, dtPedido)) AS avgTempo
      
FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t1.idCliente = t3.idCliente

GROUP BY t3.descUF

ORDER BY avgTempo DESC

-- CORRETO - os valores ficaram bem parecidos, faltou retirar as entregas não realizadas da tabela

-- COMMAND ----------

/* 8. Qual meio de pagamento é mais utilizado por clientes do RJ? */

SELECT descTipoPagamento,
       COUNT(descTipoPagamento) AS contagemTipoPagamento
       
FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.pagamento_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t1.idCliente = t3.idCliente

WHERE t3.descUF = 'RJ'

GROUP BY descTipoPagamento

ORDER BY contagemTipoPagamento DESC

-- CORRETO -- mas melhor utilizar INNER JOIN na linha 8 para excluir os pagamentos não realizados

-- COMMAND ----------

/* 9. Qual estado sai mais ferramentas? */

SELECT descUF,
      COUNT(descUF) AS contagemEstado

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.produto AS t3
ON t2.idProduto = t3.idProduto

LEFT JOIN silver.olist.cliente AS t4
ON t1.idCliente = t4.idCliente

WHERE t3.descCategoria = 'ferramentas_jardim'

GROUP BY descUF 

ORDER BY contagemEstado DESC

-- INCORRETO - erro no filtro, apenas considerou ferramentas de jardim, melhor ficaria na linha 17: WHERE t2.descCategoria LIKE '%ferramentas%'


-- COMMAND ----------

/* 10. Qual estado tem mais compras por cliente? */

SELECT descUF,
      COUNT(DISTINCT t1.idCliente) AS contagemClientes

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.cliente AS t2
ON t1.idCliente = t2.idCliente

GROUP BY descUF

ORDER BY contagemClientes DESC

-- CORRETO, faltou contar a quantidade de clientes distintos (clientes únicos)

-- COMMAND ----------


