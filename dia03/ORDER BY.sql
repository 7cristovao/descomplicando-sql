-- Databricks notebook source
/* Ordenar do item mais barato para o mais caro  */ 
SELECT *
FROM silver.olist.item_pedido
ORDER BY vlPreco

-- COMMAND ----------

/* Ordem decresecente */
SELECT *
FROM silver.olist.item_pedido
ORDER BY vlPreco DESC

-- COMMAND ----------

/* Ordem crescente */
SELECT *
FROM silver.olist.item_pedido
ORDER BY vlPreco ASC

-- COMMAND ----------

/* Utilizar mais de uma coluna para ordenação */
SELECT *
FROM silver.olist.item_pedido
ORDER BY vlPreco ASC, vlFrete DESC

-- COMMAND ----------

/* Utilizar mais de uma coluna para ordenação e limitar a quantidade de registros em 3 resultados */
SELECT *
FROM silver.olist.item_pedido
ORDER BY vlPreco ASC, vlFrete DESC
LIMIT 3

-- COMMAND ----------

/* Filtra por categoria, ou seja, por dados de texto nas colunas e ordena por ordem decrescente exibindo 5 resultados*/

SELECT *
FROM silver.olist.produto
WHERE descCategoria = 'perfumaria'
ORDER BY nrTamanhoNome DESC
LIMIT 5

-- COMMAND ----------

/* Põe em ordem crescente o resultado da multiplicação de três colunas - Exemplo: cubagem */
SELECT *
FROM silver.olist.produto
WHERE descCategoria = 'perfumaria'
ORDER BY vlComprimentoCm * vlAlturaCm * vlLarguraCm

-- COMMAND ----------

/* Põe em ordem crescente o resultado da multiplicação de três colunas - Exemplo: cubagem */
SELECT *,
       vlComprimentoCm * vlAlturaCm * vlLarguraCm AS volumeCm
FROM silver.olist.produto
WHERE descCategoria = 'perfumaria'
ORDER BY vlComprimentoCm * vlAlturaCm * vlLarguraCm

-- COMMAND ----------

/* Põe em ordem decrescente o resultado da multiplicação de três colunas, mostrando o TOP 5 - Exemplo: cubagem */
SELECT *,
       vlComprimentoCm * vlAlturaCm * vlLarguraCm AS volumeCm
FROM silver.olist.produto 
WHERE descCategoria = 'perfumaria'
ORDER BY vlComprimentoCm * vlAlturaCm * vlLarguraCm DESC
LIMIT 5

-- COMMAND ----------


