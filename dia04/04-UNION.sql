-- Databricks notebook source
SELECT t2.idVendedor,
       t3.descUF,
       COUNT(t1.idPedido)

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

WHERE year(dtPedido) = 2017
AND t3.descUF = 'SP'

GROUP BY t2.idVendedor, t3.descUF

ORDER BY COUNT(t1.idPedido) DESC

LIMIT 5

-- COMMAND ----------

-- Query SP 
(SELECT t2.idVendedor,
       t3.descUF,
       COUNT(t1.idPedido)

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

WHERE year(dtPedido) = 2017
AND t3.descUF = 'SP'

GROUP BY t2.idVendedor, t3.descUF

ORDER BY COUNT(t1.idPedido) DESC

LIMIT 5)

/* Adicionar UNION ALL para juntar duas consultas, duas tabelas */
UNION ALL

-- Query RJ
(SELECT t2.idVendedor,
       t3.descUF,
       COUNT(t1.idPedido)

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

WHERE year(dtPedido) = 2017
AND t3.descUF = 'RJ'

GROUP BY t2.idVendedor, t3.descUF

ORDER BY COUNT(t1.idPedido) DESC

LIMIT 5)

-- COMMAND ----------

-- Query SP 
(SELECT t2.idVendedor,
       t3.descUF,
       COUNT(t1.idPedido)

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

WHERE year(dtPedido) = 2017
AND t3.descUF = 'SP'

GROUP BY t2.idVendedor, t3.descUF

ORDER BY COUNT(t1.idPedido) DESC

LIMIT 5)

/* Adicionar UNION ALL para juntar duas consultas, duas tabelas */
UNION -- este comando faz um DISTINCT das linhas

-- Query RJ
(SELECT t2.idVendedor,
       t3.descUF,
       COUNT(t1.idPedido)

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

WHERE year(dtPedido) = 2017
AND t3.descUF = 'RJ'

GROUP BY t2.idVendedor, t3.descUF

ORDER BY COUNT(t1.idPedido) DESC

LIMIT 5)

-- COMMAND ----------

/* A quantidade de colunas devem ser iguais para que não ocorra a mistura de dados como neste caso */
 
-- Query SP 
(SELECT t2.idVendedor,
       t3.descUF,
       COUNT(t1.idPedido),
       SUM(t2.vlPreco)

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

WHERE year(dtPedido) = 2017
AND t3.descUF = 'SP'

GROUP BY t2.idVendedor, t3.descUF

ORDER BY COUNT(t1.idPedido) DESC

LIMIT 5)

/* Adicionar UNION ALL para juntar duas consultas, duas tabelas */
UNION ALL

-- Query RJ
(SELECT t2.idVendedor,
       t3.descUF,
       SUM(vlPreco),
       COUNT(t1.idPedido)

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

WHERE year(dtPedido) = 2017
AND t3.descUF = 'RJ'

GROUP BY t2.idVendedor, t3.descUF

ORDER BY COUNT(t1.idPedido) DESC

LIMIT 5)

-- COMMAND ----------


