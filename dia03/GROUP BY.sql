-- Databricks notebook source
/* Agrupar, consolidar tabela por informação */
SELECT descUF,
       count(DISTINCT idVendedor)
FROM silver.olist.vendedor
GROUP BY descUF

-- COMMAND ----------

/* Agrupar, consolidar tabela por informação, colocar a segunda coluna em ordem decrescente */
SELECT descUF,
       count(DISTINCT idVendedor)
FROM silver.olist.vendedor
GROUP BY descUF
ORDER BY 2 DESC

-- COMMAND ----------

/* Subtotal de vendedores por UF em ordem decrescente*/

SELECT descUF,
       count(DISTINCT idVendedor) AS qtVendedor
FROM silver.olist.vendedor
GROUP BY descUF
ORDER BY qtVendedor DESC

-- COMMAND ----------

/* Fazendo a consulta contando um por um (contagem) */
SELECT count(idProduto)
FROM silver.olist.produto
WHERE descCategoria = 'artes'

-- COMMAND ----------

/* Total de produtos por categoria com a contagem*/
SELECT descCategoria, count(idProduto) AS qtProduto
FROM silver.olist.produto
GROUP BY descCategoria

-- COMMAND ----------

/* Total de produtos por categoria com a contagem, colocando a média do tamanho */
SELECT descCategoria, 
       count(idProduto) AS qtProduto,
       avg(vlPesoGramas) AS avgPeso,
       percentile(vlPesoGramas, 0.5) AS medianaPeso,

       avg(vlComprimentoCm * vlAlturaCm * vlLarguraCm) AS avgVolume,
       percentile(vlComprimentoCm * vlAlturaCm * vlLarguraCm, 0.5) AS medianaVolume

FROM silver.olist.produto
GROUP BY descCategoria
ORDER BY qtProduto DESC

-- COMMAND ----------

/* Total de produtos por categoria com a contagem, colocando a média do tamanho ordem decrescente por medianaPeso*/
SELECT descCategoria, 
       count(idProduto) AS qtProduto,
       avg(vlPesoGramas) AS avgPeso,
       percentile(vlPesoGramas, 0.5) AS medianaPeso,

       avg(vlComprimentoCm * vlAlturaCm * vlLarguraCm) AS avgVolume,
       percentile(vlComprimentoCm * vlAlturaCm * vlLarguraCm, 0.5) AS medianaVolume

FROM silver.olist.produto
GROUP BY descCategoria
ORDER BY medianaPeso DESC

-- COMMAND ----------

/* Quantidade de pedidos por ano em cada um dos anos */
SELECT year(dtPedido),
       count(idPedido)
FROM silver.olist.pedido
GROUP BY year(dtPedido)
ORDER BY year(dtPedido)

-- COMMAND ----------

/* Quantidade de pedidos por ano/mês em cada um dos anos */
SELECT year(dtPedido) || '-' || month(dtPedido) AS anoMes,
       count(idPedido)
FROM silver.olist.pedido
GROUP BY anoMes
ORDER BY anoMes

-- COMMAND ----------

/* Outra forma de obter a quantidade de pedidos por ano/mês em cada um dos anos convertendo o campo ano/mês para apenas ver a data*/
SELECT date(date_trunc('month', dtPedido)) AS anoMes,
       count(idPedido)
FROM silver.olist.pedido
GROUP BY anoMes
ORDER BY anoMes

-- COMMAND ----------


