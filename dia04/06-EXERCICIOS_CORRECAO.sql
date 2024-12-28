-- Databricks notebook source
/* 1. Qual categoria tem mais produtos vendidos? */
SELECT t2.descCategoria,
       COUNT(*) AS qteCategoria,
       COUNT(DISTINCT idPedido) AS qtePedidos

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY qtePedidos DESC

LIMIT 1

-- COMMAND ----------

/* 2. Qual categoria tem produtos mais caros, em média? E Mediana? */
SELECT t2.descCategoria,
       AVG(t1.vlPreco) AS avgPreco

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY avgPreco DESC

LIMIT 1

-- COMMAND ----------

/* 2. Qual categoria tem produtos mais caros, em média? E Mediana? */
SELECT t2.descCategoria,
       PERCENTILE(t1.vlPreco, 0.5) AS medianaPreco

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY medianaPreco DESC

LIMIT 1

-- COMMAND ----------

/* 3. Qual categoria tem maiores fretes, em média? */

SELECT t2.descCategoria, 
       AVG(t1.vlFrete) AS avgFrete

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY avgFrete DESC

-- COMMAND ----------

/* 4. Os clientes de qual estado pagam mais frete, em média? */
SELECT t3.descUF,
       SUM(t1.vlFrete) / COUNT(DISTINCT t1.idPedido) AS avgFrete,
       AVG(t1.vlFrete) AS avgFreteItem,
       SUM(t1.vlFrete) / COUNT(DISTINCT t2.idCliente) AS avgFreteCliente
       

FROM silver.olist.item_pedido AS t1

INNER JOIN silver.olist.pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t2.idCliente = t3.idCliente

GROUP BY t3.descUF

ORDER BY avgFrete DESC

-- COMMAND ----------

/* 5. Clientes de quais estados avaliam melhor, em média? Proporção de 5? */
SELECT t3.descUF,
       AVG(t1.vlNota) AS avgNota

FROM silver.olist.avaliacao_pedido AS t1

INNER JOIN silver.olist.pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t2.idCliente = t3.idCliente

GROUP BY t3.descUF

ORDER BY avgNota DESC

-- COMMAND ----------

/* 5. Clientes de quais estados avaliam melhor, em média? Proporção de 5? */
/* Calculando a proporção */
SELECT t3.descUF,
       AVG(t1.vlNota) AS avgNota,
       AVG(CASE WHEN t1.vlNota = 5 THEN 1 ELSE 0 END)

FROM silver.olist.avaliacao_pedido AS t1

INNER JOIN silver.olist.pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t2.idCliente = t3.idCliente

GROUP BY t3.descUF

ORDER BY avgNota DESC

-- COMMAND ----------

/* 6. Vendedores de quais estados têm as piores reputações? */
SELECT t3.descUF,
       AVG(t1.vlNota) AS avgNota


FROM silver.olist.avaliacao_pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

GROUP BY t3.descUF
ORDER BY avgNota ASC

-- COMMAND ----------

/* 7. Quais estados de clientes levam mais tempo para a mercadoria chegar? */

SELECT t2.descUF,
       AVG(datediff(t1.dtEntregue, t1.dtPedido)) AS qteDias       

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.cliente AS t2 
ON t1.idCliente = t2.idCliente

WHERE t1.dtEntregue IS NOT NULL 

GROUP BY t2.descUF

ORDER BY qteDias

-- COMMAND ----------

/* 8. Qual meio de pagamento é mais utilizado por clientes do RJ? */

SELECT t1.descTipoPagamento,
       COUNT(DISTINCT t1.idPedido) AS qtePedidos

FROM silver.olist.pagamento_pedido AS t1

INNER JOIN silver.olist.pedido AS t2 
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t2.idCliente = t3.idCliente

WHERE t3.descUF = 'RJ' 

GROUP BY t1.descTipoPagamento

ORDER BY qtePedidos DESC

-- COMMAND ----------

/* 9. Qual estado sai mais ferramentas? */

SELECT t3.descUF,
       COUNT(*) AS qteProdutoVendido

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

LEFT JOIN silver.olist.vendedor AS t3
ON t1.idVendedor = t3.idVendedor

WHERE t2.descCategoria LIKE '%ferramentas%'

GROUP BY t3.descUF
ORDER BY qteProdutoVendido DESC

-- COMMAND ----------

/* 10. Qual estado tem mais compras por cliente? */

SELECT COUNT(DISTINCT t1.idPedido) AS qtePedidos, 
       COUNT(DISTINCT t2.idClienteUnico) AS qteClienteUnico,
       COUNT(DISTINCT t1.idPedido) / COUNT(DISTINCT t2.idClienteUnico) AS avgPedidoCliente,
       t2.descUF

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.cliente AS t2
ON t1.idCliente = t2.idCliente
GROUP BY t2.descUF
ORDER BY qtePedidos DESC

-- COMMAND ----------


