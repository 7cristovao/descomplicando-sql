-- Databricks notebook source
/* Filtro para aplicar depois de agregar as informações para remover linhas que não temos interesse */
SELECT descCategoria,
       count(DISTINCT idProduto) AS qteProduto,
       avg(vlPesoGramas) AS avgPeso
FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'moveis_decoracao', 'perfumaria')

GROUP BY descCategoria

-- COMMAND ----------

/* Filtro para aplicar depois de agregar as informações para remover linhas que não temos interesse, uso do operador OU, aplicando um filtro depois do GROUP BY */
/* Estatística para filtro */
/* Categorias agrupadas tendo mais do que 100 itens */
SELECT descCategoria,
       count(DISTINCT idProduto) AS qteProduto,
       avg(vlPesoGramas) AS avgPeso
FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'perfumaria')
OR descCategoria like '%moveis%'

GROUP BY descCategoria

HAVING count(DISTINCT idProduto) > 100

-- COMMAND ----------

/* Filtro para aplicar depois de agregar as informações para remover linhas que não temos interesse, uso do operador OU, aplicando um filtro depois do GROUP BY */
/* Estatística para filtro */
/* Categorias agrupadas*/
SELECT descCategoria,
       count(DISTINCT idProduto) AS qteProduto,
       avg(vlPesoGramas) AS avgPeso
FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'perfumaria')
OR descCategoria like '%moveis%'

GROUP BY descCategoria

-- COMMAND ----------

/* Filtro para aplicar depois de agregar as informações para remover linhas que não temos interesse, uso do operador lógico OU, aplicando um filtro depois do GROUP BY */
/* Estatística para filtro */
/* Categorias agrupadas tendo mais do que 100 itens */
/* Com média de peso maior do que 1000 */
/* Uso do operador lógico E*/
SELECT descCategoria,
       count(DISTINCT idProduto) AS qteProduto,
       avg(vlPesoGramas) AS avgPeso
FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'perfumaria')
OR descCategoria like '%moveis%'

GROUP BY descCategoria

HAVING count(DISTINCT idProduto) > 100
AND avgPeso > 1000

-- COMMAND ----------

/* Filtro para aplicar depois de agregar as informações para remover linhas que não temos interesse, uso do operador lógico OU, aplicando um filtro depois do GROUP BY */
/* Estatística para filtro */
/* Categorias agrupadas tendo mais do que 100 itens */
/* Com média de peso maior do que 1000 */
/* Uso do operador lógico E*/
/* Ordem decrescente */
SELECT descCategoria,
       count(DISTINCT idProduto) AS qteProduto,
       avg(vlPesoGramas) AS avgPeso
FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'perfumaria')
OR descCategoria like '%moveis%'

GROUP BY descCategoria

HAVING count(DISTINCT idProduto) > 100
AND avgPeso > 1000

ORDER BY avgPeso DESC

-- COMMAND ----------


