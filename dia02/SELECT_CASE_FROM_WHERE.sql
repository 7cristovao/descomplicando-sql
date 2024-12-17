-- Databricks notebook source
/* Cada CASE significa uma coluna */
/* Cada WHEN significa uma condição para uma coluna */
/* Para combinar as consultas */

SELECT *,

       CASE
           WHEN vlPreco <= 100 THEN '000 -| 100'
           WHEN vlPreco <= 200 THEN '100 -| 200'
           WHEN vlPreco <= 300 THEN '200 -| 300'
           WHEN vlPreco <= 400 THEN '300 -| 400'
           WHEN vlPreco <= 500 THEN '400 -| 500'
           WHEN vlPreco <= 600 THEN '500 -| 600'
           WHEN vlPreco <= 700 THEN '600 -| 700'
           WHEN vlPreco <= 800 THEN '700 -| 800'
           WHEN vlPreco <= 900 THEN '800 -| 900'
           WHEN vlPreco <= 1000 THEN '900 -| 1000'
           ELSE '+1000'
         END AS fxPreco,

       CASE
           WHEN vlFrete / (vlPreco + vlFrete) = 0 THEN 'Frete Gratuito'
           WHEN vlFrete / (vlPreco + vlFrete) = 0 THEN 'Frete Médio'
           WHEN vlFrete / (vlPreco + vlFrete) = 0 THEN 'Frete Alto'
           ELSE 'Frete Alto'
       END AS fxFrete

FROM silver.olist.item_pedido

/* Pegar itens que são mais caros do que 50 reais */
WHERE vlPreco >= 50


