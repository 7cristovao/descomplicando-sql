-- Databricks notebook source
/* Fazer contagem na query */
/* Contagem de linhas da tabela */
SELECT 
    count(*),
    count(1) 
FROM silver.olist.pedido

-- COMMAND ----------

/* Contagem de uma coluna específica */
/* Seleciona linhas não nulas do campo descSituacao */
SELECT count(descSituacao)
FROM silver.olist.pedido

-- COMMAND ----------

/* Quantas possibilidades de valores diferentes existem para campo descSituacao */
SELECT count(descSituacao), -- linhas não nulas deste campo (descSituacao)
       count(DISTINCT descSituacao) -- linhas distintas do campo descSituacao
FROM silver.olist.pedido

-- COMMAND ----------

/* Consulta SQL para contagem de linhas */
/* Dê preferência para os dois primeiros comandos (mais leve) */
SELECT count(idPedido), -- linhas não nulas para idPedido
       count(DISTINCT idPedido), -- linhas distintas para idPedido
       count(*), -- linhas totais da tabela
       count(1) -- linhas totais da tabela
FROM silver.olist.pedido

-- COMMAND ----------


