-- Databricks notebook source
/* Quais são os TOP 10 vendedores que mais venderam (em quantidade) no mês com maior número de vendas no Olist? */
/* Para descobrir o mês com maior número de vendas manualmente*/

SELECT date(date_trunc('month', dtPedido)) AS dtMonth,
       COUNT(DISTINCT idPedido) AS qtePedido

FROM silver.olist.pedido

GROUP BY dtMonth
ORDER BY qtePedido DESC

LIMIT 1

-- COMMAND ----------

/* Quais são os TOP 10 vendedores que mais venderam (em quantidade) no mês com maior número de vendas no Olist? */
/* Para encontrar os 10 melhores vendedores manualmente */

SELECT idVendedor,
       COUNT(*) AS qteItens

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01' 

GROUP BY idVendedor
ORDER BY qteItens DESC

LIMIT 10

-- COMMAND ----------

/* Identificando o mês */

SELECT date(date_trunc('month', dtPedido)) AS dtMonth

FROM silver.olist.pedido

GROUP BY dtMonth
ORDER BY COUNT(DISTINCT idPedido) DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Identifica vendedores com SUBQUERY
/* Utilizando uma consulta dentro de outra consulta */
/* Exemplo básico de uma SUBQUERY */

SELECT idVendedor,
       COUNT(*) AS qteItens

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE date(date_trunc('month', t1.dtPedido)) = (

  --Identifica mês com mais vendas
  SELECT date(date_trunc('month', dtPedido)) AS dtMonth

  FROM silver.olist.pedido

  GROUP BY dtMonth
  ORDER BY COUNT(DISTINCT idPedido) DESC

  LIMIT 1
) 

GROUP BY idVendedor
ORDER BY qteItens DESC

LIMIT 10

/* Observação: nesta query aqui a gente utilizou o igual no lugar o IN, no resultado entre os parenteses é esperado apenas uma linha e uma coluna obtido com o LIMIT 1, se retornar mais de uma linha vai dar erro */

-- COMMAND ----------

/* Exemplo de SUBQUERY FROM*/

SELECT *

FROM (

SELECT date(date_trunc('month', dtPedido)) AS dtMonth,
       COUNT(DISTINCT idPedido) AS qtePedido

FROM silver.olist.pedido

GROUP BY dtMonth
ORDER BY qtePedido DESC

)

WHERE dtMonth >= '2018-01-01'

-- COMMAND ----------

-- DBTITLE 1,Identifica vendedores BlackFriday e categoria bebes
/* Total de vendas históricas (independente da categoria) dos vendedores que venderam ao menos um produto da categoria PCS na blackfriday de 2017-11-01 */

SELECT t2.idVendedor

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.produto AS t3
ON t2.idProduto = t3.idProduto

WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
AND t3.descCategoria = 'pcs'

-- COMMAND ----------

/* Total de vendas históricas (independente da categoria) dos vendedores que venderam ao menos um produto da categoria bebes na blackfriday de 2017-11-01 */

SELECT DISTINCT t2.idVendedor

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.produto AS t3
ON t2.idProduto = t3.idProduto

WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
AND t3.descCategoria = 'bebes'

-- COMMAND ----------

/* Fazendo a QUERY manualmente com cada vendedor */

SELECT *

FROM silver.olist.item_pedido

WHERE idVendedor IN ('7aa4334be125fcdd2ba64b3180029f14', '537eb890efff034a88679788b647c564')

-- COMMAND ----------

-- DBTITLE 1,Histórico de vendas completo dos vendedores
/* Fazendo a QUERY com a SUBQUERY para não ficar repetindo manualmente as informações dos vendedores */

SELECT idVendedor,
       COUNT(DISTINCT idPedido) AS qtePedido

FROM silver.olist.item_pedido

WHERE idVendedor IN (

  SELECT DISTINCT t2.idVendedor

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
  AND t3.descCategoria = 'bebes'

)

GROUP BY idVendedor
ORDER BY qtePedido DESC

-- COMMAND ----------

/* Fazendo a QUERY com a SUBQUERY para não ficar repetindo manualmente as informações dos vendedores e realizar agrupamento */

SELECT idVendedor,
       COUNT(DISTINCT idPedido) AS qtePedido

FROM silver.olist.item_pedido

WHERE idVendedor IN (

  SELECT DISTINCT t2.idVendedor

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
  AND t3.descCategoria = 'bebes'

)

GROUP BY idVendedor

/* Observação: nesta query a gente está esperando o resultado com mais de uma linha, diferente da SUBQUERY com FROM */

-- COMMAND ----------

/* Subquery utilizando o resultado de uma tabela para fazer um RIGHT JOIN, ou seja, considerando uma tabela da direita como referência para fazer um filtro, que são os vendedores que venderam na blackfriday na categoria bebes */

SELECT t1.idVendedor,
       COUNT(DISTINCT t1.idPedido) AS qtePedido

FROM silver.olist.item_pedido AS t1

RIGHT JOIN (

  SELECT DISTINCT t2.idVendedor
  FROM silver.olist.pedido AS t1
  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido
  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto
  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
  AND t3.descCategoria = 'bebes'

) AS t2
ON t1.idVendedor = t2.idVendedor

GROUP BY t1.idVendedor

-- COMMAND ----------

/* Subquery com o mesmo resultado da query acima */

SELECT t1.idVendedor,
       COUNT(DISTINCT t2.idPedido) AS qtePedido

FROM (

  SELECT DISTINCT t2.idVendedor
  FROM silver.olist.pedido AS t1
  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido
  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto
  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
  AND t3.descCategoria = 'bebes'

) AS t1

LEFT JOIN silver.olist.item_pedido as t2
ON t1.idVendedor = t2.idVendedor

GROUP BY t1.idVendedor
ORDER BY qtePedido DESC


-- COMMAND ----------


