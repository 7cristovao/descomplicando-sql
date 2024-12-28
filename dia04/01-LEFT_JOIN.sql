-- Databricks notebook source
/* Realizar consulta para relacionar as tabelas */
/* Verificar a chave de relacionamento das tabelas */
/* Campo que existe em comum nas duas tabelas */
SELECT *
FROM silver.olist.item_pedido

LEFT JOIN silver.olist.produto
ON silver.olist.item_pedido.idProduto = silver.olist.produto.idProduto

-- COMMAND ----------

/* Relacionamento */
SELECT *
FROM silver.olist.item_pedido as t1

LEFT JOIN silver.olist.produto as t2
ON t1.idProduto = t2.idProduto


-- COMMAND ----------

/* Relacionamento continuação */
/* Código com ERRO pois não está definida a tabela do campo que está nas duas tabelas */
SELECT idPedido,
       idPedidoItem,
       idProduto,
       vlPreco,
       vlFrete,
       descCategoria
       
FROM silver.olist.item_pedido as t1

LEFT JOIN silver.olist.produto as t2
ON t1.idProduto = t2.idProduto

-- COMMAND ----------

/* Relacionamento continuação*/

SELECT t1.*,
       t2.descCategoria

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

-- COMMAND ----------

/* Ralacionamento para inserir a Categoria de produtos vendidos */

SELECT *

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

-- COMMAND ----------

/* Ralacionamento para inserir a categoria de produtos vendidos */

SELECT t1.*,
       t2.descUF

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

-- COMMAND ----------

-- DBTITLE 1,Vendedor e item pedidos
/* Relacionar três tabelas */

SELECT *

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

LEFT JOIN silver.olist.produto AS t3
ON t1.idProduto = t3.idProduto

-- COMMAND ----------

/* Relacionar três tabelas filtrando por vendedores de SP*/

SELECT t1.*,
       t2.descUF AS descUFVendedor,
       t3.descCategoria,
       t3.vlPesoGramas

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

LEFT JOIN silver.olist.produto AS t3
ON t1.idProduto = t3.idProduto

WHERE t2.descUF = 'SP'

-- COMMAND ----------


