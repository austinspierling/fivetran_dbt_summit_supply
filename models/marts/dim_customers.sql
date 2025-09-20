-- models/marts/dim_customers.sql

WITH contacts AS (SELECT *
                  FROM {{ ref('stg_salesforce__contact') }}),

     customer_transactions AS (SELECT salesforce_contact_id,
                                      COUNT(transaction_id) AS total_transactions,
                                      SUM(total_amount)     AS lifetime_value,
                                      MIN(transaction_time) AS first_purchase_date,
                                      MAX(transaction_time) AS last_purchase_date
                               FROM {{ ref('stg_postgres__sales_transactions') }}
                               GROUP BY 1)

SELECT c.account_id,
       c.first_name,
       c.last_name,
       c.email,
       c.loyalty_tier,
       c.mailing_city,
       c.mailing_state,
       COALESCE(ct.total_transactions, 0) AS total_transactions,
       COALESCE(ct.lifetime_value, 0)     AS lifetime_value,
       ct.first_purchase_date,
       ct.last_purchase_date
FROM contacts c
         LEFT JOIN
     customer_transactions ct ON c.account_id = ct.salesforce_contact_id
