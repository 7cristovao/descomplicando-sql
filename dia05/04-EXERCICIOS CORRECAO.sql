-- Databricks notebook source
/* 
1.  Qual a nota (média, mínima e máxima) de cada vendedor que tiveram vendas no ano de 2017? E o percentual de pedidos avaliados com nota 5?
2. Calcule o valor do pedido médio, o valor do pedido mais caro e mais barato de cada vendedor que realizaram vendas entre 2017-01-01 e 2017-06-30.
3. Calcule a quantidade de pedidos por meio de pagamento que cada vendedor teve em seus pedidos entre 2017-01-01 e 2017-06-30.
4. Combine a query do exercício 2 e 3 de tal forma, que cada linha seja um vendedor, e que haja colunas para cada meio de pagamento (com a quantidade de pedidos) e as colunas das estatísticas do pedido do exercício 2 (média, maior valor e menor valor).
*/

-- COMMAND ----------

/* 1.  Qual a nota (média, mínima e máxima) de cada vendedor que tiveram vendas no ano de 2017? E o percentual de pedidos avaliados com nota 5? */
/* Código para obter a média de cada vendedor */

WITH tb_pedidos AS (

  SELECT DISTINCT
         t1.idPedido,
         idVendedor

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE year(dtPedido) = 2017

), tb_avaliacoes AS (

SELECT * 
FROM tb_pedidos AS t1

INNER JOIN silver.olist.avaliacao_pedido AS t2
ON t1.idPedido = t2.idPedido

)

SELECT idVendedor,
       AVG(vlNota) AS avgNota,
       MAX(vlNota) AS maxNota,
       MIN(vlNota) AS minNota
       
FROM tb_avaliacoes 
GROUP BY idVendedor

-- COMMAND ----------

/* 1.  Qual a nota (média, mínima e máxima) de cada vendedor que tiveram vendas no ano de 2017? E o percentual de pedidos avaliados com nota 5? */
/* Código para obter o percentual */

WITH tb_pedidos AS (

  SELECT DISTINCT
         t1.idPedido,
         idVendedor

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE year(dtPedido) = 2017

), tb_avaliacoes AS (

SELECT *,
       CASE WHEN vlNota = 5 THEN 1 ELSE 0 END AS flNota5
FROM tb_pedidos AS t1

INNER JOIN silver.olist.avaliacao_pedido AS t2
ON t1.idPedido = t2.idPedido

)

SELECT idVendedor,
       AVG(vlNota) AS avgNota,
       MAX(vlNota) AS maxNota,
       MIN(vlNota) AS minNota,
       AVG(flNota5) AS pctNota5,
       AVG(CASE WHEN vlNota = 5 THEN 1 ELSE 0 END) AS pctNota5_v2
       
FROM tb_avaliacoes   
GROUP BY idVendedor

-- COMMAND ----------

/* 2. Calcule o valor do pedido médio, o valor do pedido mais caro e mais barato de cada vendedor que realizaram vendas entre 2017-01-01 e 2017-06-30. */

-- tb_item_pedido representa todos os itens vendidos dentro do intervalo de tempo

WITH tb_item_pedido AS (

SELECT t2.idPedido,
       t2.idVendedor,
       t2.vlPreco
       
FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE dtPedido >= '2017-01-01'
AND dtPedido < '2017-07-01'

), tb_pedido_receita AS (

SELECT idVendedor,
       idPedido,
       SUM(vlPreco) AS vlTotal,
       COUNT(*)

FROM tb_item_pedido

GROUP BY idVendedor, idPedido

)

SELECT idVendedor,
       AVG(vlTotal) AS avgValorPedido,
       MIN(vlTotal) AS minValorPedido,
       MAX(vlTotal) AS maxValorPedido

FROM tb_pedido_receita

GROUP BY idVendedor

-- COMMAND ----------

-- DBTITLE 1,Exercício 02 PLUS
/* 2. Calcule o valor do pedido médio, o valor do pedido mais caro e mais barato de cada vendedor que realizaram vendas entre 2017-01-01 e 2017-06-30. */

WITH tb_pedido_receita AS (

SELECT t2.idPedido,
       t2.idVendedor,
       SUM(t2.vlPreco) AS vlTotal
       
FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE dtPedido >= '2017-01-01'
AND dtPedido < '2017-07-01'

GROUP BY t2.idPedido, t2.idVendedor

), tb_final AS (

SELECT idVendedor,
       AVG(vlTotal) AS avgValorPedido,
       MIN(vlTotal) AS minValorPedido,
       MAX(vlTotal) AS maxValorPedido

FROM tb_pedido_receita

GROUP BY idVendedor

)

SELECT * FROM tb_final

-- COMMAND ----------

/* 3. Calcule a quantidade de pedidos por meio de pagamento que cada vendedor teve em seus pedidos entre 2017-01-01 e 2017-06-30. */

WITH tb_pedido_vendedor AS (

SELECT DISTINCT
       t2.idPedido,
       t2.idVendedor

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE dtPedido >= '2017-01-01'
AND dtPedido < '2017-07-01'

), tb_pedido_pagamento AS (

  SELECT t1.idVendedor,
        t1.idPedido,
        t2.descTipoPagamento

  FROM tb_pedido_vendedor AS t1

  LEFT JOIN silver.olist.pagamento_pedido AS t2
  ON t1.idPedido = t2.idPedido

)

SELECT idVendedor,
       descTipoPagamento,
       COUNT(DISTINCT idPedido)
       
FROM tb_pedido_pagamento 

GROUP BY idVendedor, descTipoPagamento
ORDER BY idVendedor, descTipoPagamento

-- COMMAND ----------

/* 4. Combine a query do exercício 2 e 3 de tal forma, que cada linha seja um vendedor, e que haja colunas para cada meio de pagamento (com a quantidade de pedidos) e as colunas das estatísticas do pedido do exercício 2 (média, maior valor e menor valor). */

WITH tb_pedido_receita AS (
  
  SELECT t2.idVendedor,
         t2.idPedido,
        SUM(vlPreco) AS vlReceita

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE dtPedido >= '2017-01-01'
  AND dtPedido < '2017-07-01'

  GROUP BY t2.idVendedor, t2.idPedido

), 

-- tabela temporária do exercício 2
tb_sumario_pedidos AS (

SELECT idVendedor,
       AVG(vlReceita) AS avgValorPedido,
       MIN(vlReceita) AS minValorPedido,
       MAX(vlReceita) AS maxValorPedido

FROM tb_pedido_receita

GROUP BY idVendedor

),

-- tabela temporária do exercício 03
tb_pedido_pagamento AS (

  SELECT t1.idVendedor,
         t2.descTipoPagamento,
         COUNT(DISTINCT t1.idPedido) AS qtePedido

  FROM tb_pedido_receita AS t1

  LEFT JOIN silver.olist.pagamento_pedido AS t2
  ON t1.idPedido = t2.idPedido

  GROUP BY t1.idVendedor, t2.descTipoPagamento
  ORDER BY t1.idVendedor, t2.descTipoPagamento
), 

tb_pagamento_coluna AS (

SELECT idVendedor,
       SUM(CASE WHEN descTipoPagamento = 'boleto' THEN qtePedido END) AS qteBoleto,
       SUM(CASE WHEN descTipoPagamento = 'credit_card' THEN qtePedido END) AS  qteCredit_card,
       SUM(CASE WHEN descTipoPagamento = 'voucher' THEN qtePedido END) AS qteVoucher,
       SUM(CASE WHEN descTipoPagamento = 'debit_card' THEN qtePedido END) AS qteDebit_card
       
FROM tb_pedido_pagamento 

GROUP BY idVendedor

)

SELECT t1.*,
       qteBoleto,
       qteCredit_card,
       qteVoucher,
       qteDebit_card

FROM tb_sumario_pedidos AS t1

LEFT JOIN tb_pagamento_coluna AS t2
ON t1.idVendedor = t2.idVendedor

-- COMMAND ----------


