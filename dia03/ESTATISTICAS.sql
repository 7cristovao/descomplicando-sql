-- Databricks notebook source
/* Chegar à média dos valores de uma coluna */

SELECT avg(vlPreco)
FROM silver.olist.item_pedido

-- COMMAND ----------

/* Verificar o valor mínimo de um campo */
SELECT min(vlPreco)
FROM silver.olist.item_pedido

-- COMMAND ----------

/* Verificar o valor máximo de um campo */
SELECT max(vlFrete)
FROM silver.olist.item_pedido

-- COMMAND ----------

/* Verificar o desvio padrão de um campo */
SELECT stddev(vlFrete)
FROM silver.olist.item_pedido

-- COMMAND ----------

/* Verificar o percentil de um campo - mediana*/
SELECT percentile(vlFrete, 0.5)
FROM silver.olist.item_pedido

-- COMMAND ----------

/* Verificar o primeiro quartil de um campo */
SELECT percentile(vlPreco, 0.25)
FROM silver.olist.item_pedido

-- COMMAND ----------

/* Uso da soma para calcular média manualmente */
SELECT sum(vlPreco) / count(vlPreco)
FROM silver.olist.item_pedido

-- COMMAND ----------


