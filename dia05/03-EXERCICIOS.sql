-- Databricks notebook source
/* 
1.  Qual a nota (média, mínima e máxima) de cada vendedor que tiveram vendas no ano de 2017? E o percentual de pedidos avaliados com nota 5?
2. Calcule o valor do pedido médio, o valor do pedido mais caro e mais barato de cada vendedor que realizaram vendas entre 2017-01-01 e 2017-06-30.
3. Calcule a quantidade de pedidos por meio de pagamento que cada vendedor teve em seus pedidos entre 2017-01-01 e 2017-06-30.
4. Combine a query do exercício 2 e 3 de tal forma, que cada linha seja um vendedor, e que haja colunas para cada meio de pagamento (com a quantidade de pedidos) e as colunas das estatísticas do pedido do exercício 2 (média, maior valor e menor valor).
*/

-- COMMAND ----------

/* 
1.  Qual a nota (média, mínima e máxima) de cada vendedor que tiveram vendas no ano de 2017? E o percentual de pedidos avaliados com nota 5? */

SELECT DISTINCT t2.idVendedor,
       AVG(t3.vlNota) AS mediaNota,
       MIN(t3.vlNota) AS minNota,
       MAX(t3.vlNota) AS maxNota

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.avaliacao_pedido AS t3
ON t1.idPedido = t3.idPedido

WHERE date_trunc('year', t1.dtPedido) = '2017-01-01' 

GROUP BY t2.idVendedor

/* INCORRETO verificar porque houve essa diferença mínima nos valores da média da nota */

-- COMMAND ----------

/* 
1.  Qual a nota (média, mínima e máxima) de cada vendedor que tiveram vendas no ano de 2017? E o percentual de pedidos avaliados com nota 5? */
/* Lista do percentual de pedidos avaliados com nota 5 */

SELECT DISTINCT idVendedor,
       totalPedidosAvaliadosIgualA5 / totalPedidos AS percentualPedidosAvaliadosIgualA5

FROM ( SELECT t2.idVendedor,
       COUNT(DISTINCT t1.idPedido) AS totalPedidos,
       COUNT(DISTINCT CASE WHEN t3.vlNota = 5 THEN t1.idPedido END) AS totalPedidosAvaliadosIgualA5

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.avaliacao_pedido AS t3
ON t1.idPedido = t3.idPedido

WHERE date_trunc('year', t1.dtPedido) = '2017-01-01'

GROUP BY t2.idVendedor )

-- CORRETO

-- COMMAND ----------

/* 2. Calcule o valor do pedido médio, o valor do pedido mais caro e mais barato de cada vendedor que realizaram vendas entre 2017-01-01 e 2017-06-30. */

WITH tabelaPedidosPrimeiroSemestre2017 AS (

SELECT *,
       date(dtPedido) AS diaPedido
  
FROM silver.olist.pedido

WHERE date(dtPedido) BETWEEN '2017-01-01' AND '2017-06-30'

)

SELECT t3.idVendedor,
       AVG(t2.vlPreco + t2.vlFrete) AS valorPedidoMedio,
       MAX(t2.vlPreco + t2.vlFrete) AS valorPedidoMaisCaro,
       MIN(t2.vlPreco + t2.vlFrete) AS valorPedidoMaisBarato

FROM tabelaPedidosPrimeiroSemestre2017 as t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

GROUP BY t3.idVendedor
ORDER BY valorPedidoMedio DESC

-- INCORRETO a análise foi feita verificando o valor do pedido médio por item, mas a média deveria ser feita por pedido

-- COMMAND ----------

/* 3. Calcule a quantidade de pedidos por meio de pagamento que cada vendedor teve em seus pedidos entre 2017-01-01 e 2017-06-30. */

WITH tabelaPedidosPrimeiroSemestre2017 AS (

SELECT *,
       date(dtPedido) AS diaPedido
  
FROM silver.olist.pedido

WHERE date(dtPedido) BETWEEN '2017-01-01' AND '2017-06-30'

)

SELECT t2.idVendedor,
       t3.descTipoPagamento,
       COUNT(t1.idPedido) AS qtePedidos

FROM tabelaPedidosPrimeiroSemestre2017 AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.pagamento_pedido AS t3
ON t1.idPedido = t3.idPedido

GROUP BY t2.idVendedor, t3.descTipoPagamento
ORDER BY t2.idVendedor

-- INCORRETO pois foi feito por itens de pedido ao invés de fazer por pedido distinto

-- COMMAND ----------

/* 4. Combine a query do exercício 2 e 3 de tal forma, que cada linha seja um vendedor, e que haja colunas para cada meio de pagamento (com a quantidade de pedidos) e as colunas das estatísticas do pedido do exercício 2 (média, maior valor e menor valor). */

WITH tabelaPedidosPrimeiroSemestre2017 AS (

SELECT *,
       date(dtPedido) AS diaPedido
  
FROM silver.olist.pedido

WHERE date(dtPedido) BETWEEN '2017-01-01' AND '2017-06-30'

), tabelaPedidosPrimeiroSemestre2017ComVendedoresETipoDePagamento AS (

SELECT *

FROM tabelaPedidosPrimeiroSemestre2017 as t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.pagamento_pedido AS t3
ON t1.idPedido = t3.idPedido
)

SELECT 
       DISTINCT idVendedor,
       COUNT(CASE WHEN descTipoPagamento = 'credit_card' THEN 1 END) AS totalCartaoCredito,
       COUNT(CASE WHEN descTipoPagamento = 'debit_card' THEN 1 END) AS totalCartaoDebito,
       COUNT(CASE WHEN descTipoPagamento = 'voucher' THEN 1 END) AS totalVoucher,
       COUNT(CASE WHEN descTipoPagamento = 'boleto' THEN 1 END) AS totalBoleto,
       AVG(vlPreco + vlFrete) AS valorPedidoMedio,
       MAX(vlPreco + vlFrete) AS valorPedidoMaisCaro,
       MIN(vlPreco + vlFrete) AS valorPedidoMaisBarato

FROM tabelaPedidosPrimeiroSemestre2017ComVendedoresETipoDePagamento GROUP BY idVendedor

-- COMMAND ----------


