-- Databricks notebook source
/* Consultando Tabelas */
SELECT * 
FROM silver.olist.pedido 
LIMIT 10

-- COMMAND ----------

SELECT *
FROM silver.olist.item_pedido

-- COMMAND ----------



-- COMMAND ----------

/* Todas colunas + 1 */
SELECT *, 
        vlPreco + vlFrete AS vlTotal

FROM silver.olist.item_pedido

-- COMMAND ----------

/* Seleciona apenas algumas colunas */
SELECT idPedido,
       idProduto,
       vlPreco,
       vlFrete,
       vlPreco + vlFrete AS vlTotal

FROM silver.olist.item_pedido
