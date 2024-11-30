-- Databricks notebook source
/* Data no SQL */
SELECT '2023-01-01' -- ano-mes-dia

-- COMMAND ----------

/* Trinta dias adicionado a essa data */
SELECT date_add('2023-01-01', 30) -- ano-mes-dia

-- COMMAND ----------



-- COMMAND ----------

/* Subtração de dias */
SELECT date_add('2023-01-01', -15)

-- COMMAND ----------

/* Subtração de dias - segunda forma*/
SELECT date_sub('2023-01-01', 15)

-- COMMAND ----------

/* Navegando em meses */
SELECT add_months('2023-01-01', -1)

-- COMMAND ----------

/* Descobrir o ano de uma data */
SELECT year('2023-01-01')

-- COMMAND ----------

/* Descobrir o mês de uma data */
SELECT month('2023-01-01')

-- COMMAND ----------

/* Descobrir o dia de uma data */
SELECT day('2023-01-01')

-- COMMAND ----------

/* Descobrir o dia da semana de uma data */
SELECT dayofweek('2023-01-01')

-- COMMAND ----------

/* Calcular a diferença em dias entre duas datas */
SELECT datediff('2023-06-01', '2023-01-01')

-- COMMAND ----------

/* Descobrir quantos meses tem entre uma data e outra */
SELECT months_between('2023-06-01', '2023-01-01')

-- COMMAND ----------

/* Descobrir quantos dias demorou para um pedido ser entregue */
SELECT idPedido,
       idCliente,
       dtPedido,
       dtEntregue,
       datediff(dtEntregue, dtPedido)

FROM silver.olist.pedido

-- COMMAND ----------


