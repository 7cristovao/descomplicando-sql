-- Databricks notebook source
/* Selecionar a tabela de item_pedido sem aplicar nenhum filtro */

SELECT * 

FROM silver.olist.item_pedido

/* Aplicando filtro, itens superiores a 500 reais */

WHERE vlPreco >= 500

-- COMMAND ----------

/* Selecionar toda tabela onde valor de frete seja maior que o valor do preço */

SELECT *

FROM silver.olist.item_pedido

WHERE vlFrete > vlPreco

-- COMMAND ----------

/* Preço maior que 100 reais e frete maior que preço */

SELECT *

FROM silver.olist.item_pedido

WHERE vlFrete >= 100 
AND vlFrete > vlPreco

-- COMMAND ----------

/* Trazer para a gente todos os produtos que são de petshop, telefonia e bebes*/

SELECT * 
FROM silver.olist.produto

WHERE descCategoria = 'pet_shop'
OR descCategoria = 'telefonia'
OR descCategoria = 'bebes'

-- COMMAND ----------

/* Trazer para a gente todos os produtos que são de petshop, telefonia e bebes mais elegante */

SELECT *

FROM silver.olist.produto

WHERE descCategoria IN ('pet_shop', 'telefonia', 'bebes')

-- COMMAND ----------

/* Pegar informações dentro de um intervalo de datas */
/* Pode fazer com o SELECT * FROM tabela direto */

SELECT idPedido,
       idCliente,
       descSituacao,
       dtPedido,
       date(dtPedido)

FROM silver.olist.pedido

WHERE date(dtPedido) >= '2017-01-01'
AND date(dtPedido) <= '2017-01-31'

-- COMMAND ----------

/* Selecionando especificamente um mês de qualquer ano */

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND month(dtPedido) = 1

-- COMMAND ----------

/* Selecionar um mês e outro mês dentro de um ano */
/* OBSERVAÇÃO: obrigatório o uso dos parênteses para prioridade de operações lógicas */
/* Mês 01 e 06 de 2017 */

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND (month(dtPedido) = 1
OR month(dtPedido) = 6)

-- COMMAND ----------

/* Operações matemáticas e suas ordens */

SELECT 10 * 2 + 100

-- COMMAND ----------



-- COMMAND ----------

/* Outra forma de selecionar um mês e outro mês dentro de um ano (mais elegante) */
/* Mês 01 e 06 de 2017 */

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND month(dtPedido) IN (1, 6)
