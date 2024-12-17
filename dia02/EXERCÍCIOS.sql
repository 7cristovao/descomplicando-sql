-- Databricks notebook source
/* Exercício 1. Selecione todos os clientes paulistanos. */
SELECT *,
       CASE descCidade 
           WHEN 'sao paulo' THEN 'paulistanos'
           ELSE 'outros'
       END as naturalidadeClientes

FROM silver.olist.cliente

WHERE descCidade = 'sao paulo'

-- COMMAND ----------

/* Exercício 2. Selecione todos os clientes paulistas */

SELECT *,
       CASE descUF
           WHEN 'SP' THEN 'paulista'
           ELSE 'outros'
       END as ufClientes

FROM silver.olist.cliente

WHERE descUF = 'SP'

-- COMMAND ----------

/* Exercício 3. Selecione todos os vendedores cariocas e paulistas. */

SELECT *,
       CASE descUF
           WHEN 'SP' THEN 'paulista'
           WHEN 'RJ' THEN 'carioca'
           ELSE 'outros'
       END as ufVendedor

FROM silver.olist.vendedor

WHERE descUF = 'SP' OR descUF = 'RJ'

-- COMMAND ----------

/* Exercício 4. Selecione produtos de perfumaria e bebes com altura maior que 5 cm. */

SELECT *

FROM silver.olist.produto

WHERE (descCategoria = 'perfumaria' 
OR descCategoria = 'bebes')
AND vlAlturaCm > 5 

-- COMMAND ----------

/* Exercício 5. Selecione os pedidos com mais de um item. */

SELECT *

FROM silver.olist.item_pedido

WHERE idPedidoItem > 1

-- COMMAND ----------

/* Exercício 6. Selecione os pedidos que o frete é mais caro que o item. */

SELECT *

FROM silver.olist.item_pedido

WHERE vlFrete > vlPreco

-- COMMAND ----------

/* Exercício 7. Lista de pedidos que ainda não foram enviados. */

SELECT *

FROM silver.olist.pedido

WHERE dtEnvio IS NULL

-- COMMAND ----------

/* Exercício 8. Lista de pedidos que foram entregues com atraso. */

SELECT *,
        CASE dtEntregue
            WHEN dtEntregue THEN date(dtEntregue)
        END as dtEntregueLimpo,

        CASE dtEstimativaEntrega
            WHEN dtEstimativaEntrega THEN date(dtEstimativaEntrega)
        END as dtEstimativaEntregaLimpo

FROM silver.olist.pedido

WHERE date(dtEntregue) > date(dtEstimativaEntrega)

-- COMMAND ----------

/* Exercício 
9. Lista de pedidos que foram entregues com 2 dias de antecedência.
 */

 SELECT *,
        CASE dtEntregue
            WHEN dtEntregue THEN date(dtEntregue)
        END as dtEntregueLimpo,

        CASE dtEstimativaEntrega
            WHEN dtEstimativaEntrega THEN date(dtEstimativaEntrega)
        END as dtEstimativaEntregaLimpo,

        CASE dtEntregue - dtEstimativaEntrega
             WHEN dtEntregue - dtEstimativaEntrega THEN date(dtEntregue) - date(dtEstimativaEntrega)
        END as diasParaEntrega

 FROM silver.olist.pedido

 WHERE date(dtEntregue) IS NOT NULL

-- COMMAND ----------

/* Exercício 10. Selecione os pedidos feitos em dezembro de 2017 e entregues com atraso. */

 SELECT *

 FROM silver.olist.pedido

 WHERE year(dtPedido) = 2017
 AND (date(dtEntregue) > date(dtEstimativaEntrega))

-- COMMAND ----------

/* Exercício 11. Selecione os pedidos com avaliação maior ou igual que 4. */

SELECT *

FROM silver.olist.avaliacao_pedido

WHERE vlNota >= 4

-- COMMAND ----------

/* Exercício 12. Selecione os pedidos pagos com cartão de crédito com duas ou mais parcelas menores do que 40 reais */

SELECT *

FROM silver.olist.pagamento_pedido

WHERE descTipoPagamento = 'credit_card'
AND nrParcelas >= 2
AND vlPagamento / nrParcelas < 40
