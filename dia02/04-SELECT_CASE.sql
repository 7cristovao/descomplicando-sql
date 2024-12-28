-- Databricks notebook source
/* Criando faixas de preços */
/* Criar faixas e fatiar nossos preços */
/* Ao usar o CASE encerrar com a cláusula END */

SELECT *,
       CASE WHEN vlPreco <= 100 THEN '000 -| 100'
       END

FROM silver.olist.item_pedido

-- COMMAND ----------

/* Selecionar faixas de preços */
/* Criar faixas e fatiar nossos preços */
/* Ao usar o CASE encerrar com a cláusula END */
         /*   Etapa de teste */   /* Etapa de atribuição */

SELECT *,
       CASE WHEN vlPreco <= 100 THEN '000 -| 100'
            WHEN vlPreco <= 200 THEN '100 -| 200'
            WHEN vlPreco <= 200 THEN '200 -| 300'
            WHEN vlPreco <= 200 THEN '300 -| 400'
            WHEN vlPreco <= 200 THEN '400 -| 500'
            WHEN vlPreco <= 200 THEN '500 -| 600'
            WHEN vlPreco <= 200 THEN '600 -| 700'
            WHEN vlPreco <= 200 THEN '700 -| 800'
            WHEN vlPreco <= 200 THEN '800 -| 900'
            WHEN vlPreco <= 200 THEN '900 -| 1000'
            ELSE '> 1000'
       END as fxPreco

FROM silver.olist.item_pedido
/* colocar o alias (uso do as fxPreco) para não ficar com o título de coluna horripilante */

-- COMMAND ----------

/* Níveis de frete */

/* Análise de dados */

/* Se valor do frete dividido pela soma de frete e preço igual a zero, então o frete é gratuito */
/* Se valor do frete dividido pela soma de frete mais preço menor que 20%, então o frete é baixo */
/* Se valor do frete dividido pela soma de frete mais preço for menor que 40%, então o frete é médio */
/* Caso contrário, colocar frete alto*/

/* Usar isso para ver quanto no nosso cliente está pagando no produto em relação ao frete */


SELECT *,
       CASE
           WHEN vlFrete / (vlFrete + vlPreco) = 0 THEN 'Frete Gratuito'
           WHEN vlFrete / (vlFrete + vlPreco) <= 0.2 THEN 'Frete Baixo'
           WHEN vlFrete / (vlFrete + vlPreco) <= 0.4 THEN 'Frete Médio'
           ELSE 'Frete Alto'
       END AS descFrete

FROM silver.olist.item_pedido

-- COMMAND ----------

SELECT *,
       CASE
         WHEN descUF = 'SC' THEN 'Sul'
         WHEN descUF = 'RS' THEN 'Sul'
         WHEN descUF = 'PR' THEN 'Sul'
         ELSE 'Outros'
       END as descRegiao

FROM silver.olist.cliente

-- COMMAND ----------

/* Filtro de regiões do Brasil */ 

SELECT *,
       CASE
         WHEN descUF IN ('SC', 'PR', 'RS') THEN 'Sul'
         WHEN descUF IN ('SP', 'MG', 'ES', 'RJ') THEN 'Sudeste'
         WHEN descUF IN ('BA', 'AL', 'SE', 'PE', 'PB', 'RN', 'PI', 'CE', 'MA') THEN 'Nordeste'
         WHEN descUF IN ('GO', 'MT', 'MS', 'DF') THEN 'Centro-Oeste'
         WHEN descUF IN ('AC', 'AM', 'AP', 'PA', 'RO', 'RR', 'TO') THEN 'Norte'
         ELSE 'UF Incorreta'
       END as descRegiao

FROM silver.olist.cliente

-- COMMAND ----------

/* Filtro por naturalidade */

SELECT *,
       CASE 
         WHEN descUF = 'SP' THEN 'Paulista'
         WHEN descUF = 'RJ' THEN 'Carioca'
         WHEN descUF = 'MG' THEN 'Mineiro'
         WHEN descUF = 'AC' THEN 'Acreano'
         WHEN descUF = 'BA' THEN 'Baiano'
         ELSE 'Não mapeado'
       END as descNaturalidade

FROM silver.olist.vendedor
       
