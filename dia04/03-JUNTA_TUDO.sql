-- Databricks notebook source
-- Quais são os vendedores de cada estado que tem mais de R$ 1000,00 em vendas durante o ano de 2017?

SELECT t2.idVendedor,
       t3.descUF,
       SUM(t2.vlPreco) AS totalVendido

FROM silver.olist.pedido AS t1

/* Todos os JOINS ficam entre o FROM e o WHERE */
INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

/*Para trazer a informação do Estado */
LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

WHERE year(t1.dtPedido) = 2017

GROUP BY t2.idVendedor, t3.descUF

HAVING totalVendido >= 1000 

ORDER BY descUF, totalVendido DESC

-- COMMAND ----------


