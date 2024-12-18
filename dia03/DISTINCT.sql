-- Databricks notebook source
/* Consulta linhas distintas e ordena alfabeticamente */
/* Remove duplicidades */
SELECT DISTINCT descUF
FROM silver.olist.vendedor
ORDER BY descUF

-- COMMAND ----------

SELECT DISTINCT descCidade, descUF
FROM silver.olist.vendedor
ORDER BY descUF, descCidade

-- COMMAND ----------

/* Consulta linhas distintas e ordena alfabeticamente removendo duplicidades e dados em branco */

SELECT DISTINCT descCategoria
FROM silver.olist.produto
WHERE descCategoria IS NOT NULL
ORDER BY descCategoria

-- COMMAND ----------


