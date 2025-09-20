{{ config(materialized='view') }}

select
    transaction_id,
    customer_id,
    transaction_date,
    amount,
    current_timestamp as _loaded_at
from {{ source('postgres', 'sales_transactions') }}