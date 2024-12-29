-- Databricks notebook source
/* Exemplo de Subquery já conhecido */ 

SELECT * 

FROM (

SELECT *
FROM silver.olist.pedido
WHERE descSituacao = 'delivered'
AND dtEntregue <= dtEstimativaEntrega

)

-- COMMAND ----------

/* Desta forma conseguimos trabalhar com QUERIES mais simples a seguir */

WITH tb_pedidos_sem_atraso AS (

SELECT *
FROM silver.olist.pedido
WHERE descSituacao = 'delivered'
AND dtEntregue <= dtEstimativaEntrega

)

/* E também invocar QUERIES mais simples como o exemplo abaixo */

SELECT * 

FROM tb_pedidos_sem_atraso

-- COMMAND ----------

/* Outro exemplo usando o WITH */
/* Observação: versões mais antigas que o MYSQL 5.7 não suportam a cláusula WITH */
/* Desta forma que está aqui o SQL não precisa gravar a informação em outro lugar para lê-la novamente */

WITH tb_pedidos_sem_atraso AS (

SELECT *
FROM silver.olist.pedido
WHERE descSituacao = 'delivered'
AND dtEntregue <= dtEstimativaEntrega

),

tb_produto_bebes AS (

  SELECT *
  FROM silver.olist.produto
  WHERE descCategoria = 'bebes'

),

tb_final AS (
  
  SELECT * 

  FROM tb_pedidos_sem_atraso AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  INNER JOIN tb_produto_bebes AS t3
  ON t2.idProduto = t3.idProduto 

)

SELECT * 
FROM tb_final

-- COMMAND ----------

-- DBTITLE 1,Identifica vendedores com CTE
/* Como resolver as subqueries do arquivo anterior utilizando estas CTEs */

/* Resultado igual ao quarto exemplo do arquivo SUB_QUERIES */

/* Quais são os TOP 10 vendedores que mais venderam (em quantidade) no mês com maior número de vendas no Olist */

WITH tb_mes AS (
  
  --Identifica mês com mais vendas
  SELECT date(date_trunc('month', dtPedido)) AS dtMonth

  FROM silver.olist.pedido

  GROUP BY dtMonth
  ORDER BY COUNT(DISTINCT idPedido) DESC

  LIMIT 1

)


SELECT idVendedor,
       COUNT(*) AS qteItens

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE date(date_trunc('month', t1.dtPedido)) = (SELECT * FROM tb_mes) 

GROUP BY idVendedor
ORDER BY qteItens DESC

LIMIT 10


-- COMMAND ----------

/* Outro exemplo de subquery do arquivo anterior, agora usando CTEs */
/* Resultado igual ao décimo exemplo do arquivo SUB_QUERIES */

WITH tb_vendedores (

  -- Vendedores que venderam categoria bebes na blackfriday 2017
  SELECT DISTINCT t2.idVendedor

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
  AND t3.descCategoria = 'bebes'

)

SELECT idVendedor,
       COUNT(DISTINCT idPedido) AS qtePedido

FROM silver.olist.item_pedido

WHERE idVendedor IN (SELECT * FROM tb_vendedores)

GROUP BY idVendedor
ORDER BY qtePedido DESC


-- COMMAND ----------

/* Exemplo de CTE com resultado igual ao exemplo 9 do arquivo SUB_QUERIES */

WITH tb_vendedores_bf_bebes AS (

  SELECT DISTINCT t2.idVendedor

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
  AND t3.descCategoria = 'bebes'

)

SELECT t1.idVendedor,
       COUNT(DISTINCT idPedido) AS qtePedido

FROM silver.olist.item_pedido AS t1

INNER JOIN tb_vendedores_bf_bebes AS t2

GROUP BY t1.idVendedor
ORDER BY qtePedido DESC

-- COMMAND ----------


