-- Databricks notebook source
/* Cruzar tabelas para saber informações do nosso vendedor */
SELECT *
FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

/* Haverá pedidos que não serão encontrados na tabela de itens, pois só existem na tabela de pedidos */

/* Filtro para trazer apenas os pedidos realizados */
WHERE t2.idPedido IS NOT NULL

-- COMMAND ----------

/* Cruzar tabelas para saber informações do nosso vendedor primeiro passo */
SELECT *
FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

/* Haverá pedidos que não serão encontrados na tabela de itens, pois só existem na tabela de pedidos */

/* Ao invés de utilizar uma linha com WHERE, um filtro para trazer apenas os pedidos realizados faz mais sentido utilizar o INNER JOIN*/

-- COMMAND ----------

/* Cruzar tabelas para saber informações do nosso vendedor segundo passo*/
SELECT *
FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

-- COMMAND ----------

/* Cruzar tabelas para saber informações do nosso vendedor segundo passo*/
SELECT t1.idPedido,
       t1.idCliente,
       t4.descUF AS descUFCliente,
       t3.idVendedor,
       t3.descUF AS descUFVendedor
       
FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

LEFT JOIN silver.olist.cliente AS t4
ON t1.idCliente = t4.idCliente

-- COMMAND ----------


