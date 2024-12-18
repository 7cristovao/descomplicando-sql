-- Databricks notebook source
/* Combinando comandos com WHERE */
/* Primeiro filtra a tabela */
/* Conta a quantidade de vendedores do RJ */
SELECT count(idVendedor),
       count(DISTINCT idVendedor)
FROM silver.olist.vendedor
WHERE descUF = 'RJ'

-- COMMAND ----------

/* Para descobrir a quantidade de clientes únicos */

SELECT count(DISTINCT idCliente),
       count(DISTINCT idClienteUnico)
FROM silver.olist.cliente
WHERE descUF = 'SP'

-- COMMAND ----------

/* Filtrar por produtos */
/* Saber a média de peso dos produtos da categoria bebes */
SELECT count(*),
       avg(vlPesoGramas),
       percentile(vlPesoGramas, 0.5),
       std(vlPesoGramas)

FROM silver.olist.produto

WHERE descCategoria = 'bebes'

-- COMMAND ----------

/* Filtrar por produtos */
/* Saber a média de peso dos produtos da categoria perfumaria */
SELECT count(*),
       avg(vlPesoGramas),
       percentile(vlPesoGramas, 0.5),
       std(vlPesoGramas)

FROM silver.olist.produto

WHERE descCategoria = 'perfumaria'


-- COMMAND ----------

/* Calcular a amplitude estatística (a diferença do máximo pelo mínimo) */
SELECT max(vlPesoGramas) - min(vlPesoGramas)

FROM silver.olist.produto

WHERE descCategoria = 'perfumaria'

-- COMMAND ----------


