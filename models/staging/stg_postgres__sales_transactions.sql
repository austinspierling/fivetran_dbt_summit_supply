-- models/staging/stg_postgres__sales_transactions.sql

SELECT transaction_id,
       salesforce_contact_id,
       total_amount,
       transaction_time::timestamp AS transaction_time
FROM {{ source('rma_postgres', 'SALES_TRANSACTIONS') }}
