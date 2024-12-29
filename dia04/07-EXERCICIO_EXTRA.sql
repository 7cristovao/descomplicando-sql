-- Databricks notebook source
/* Exercício extra. Encontre o vendedor que vendeu mais. */
SELECT t3.idVendedor,
       COUNT(t3.idVendedor) AS totalVendedor
      

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t1.idVendedor = t3.idVendedor

GROUP BY t3.idVendedor
ORDER BY totalVendedor DESC

-- COMMAND ----------


