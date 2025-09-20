{{ config(materialized='table') }}

with customer_contacts as (
    select
        contact_id,
        first_name,
        last_name,
        email
    from {{ ref('stg_salesforce__contact') }}
),

customer_transactions as (
    select
        customer_id,
        count(*) as total_transactions,
        sum(amount) as total_amount,
        min(transaction_date) as first_transaction_date,
        max(transaction_date) as last_transaction_date
    from {{ ref('stg_postgres__sales_transactions') }}
    group by customer_id
)

select
    cc.contact_id as customer_id,
    cc.first_name,
    cc.last_name,
    cc.email,
    coalesce(ct.total_transactions, 0) as total_transactions,
    coalesce(ct.total_amount, 0) as total_amount,
    ct.first_transaction_date,
    ct.last_transaction_date,
    current_timestamp as _loaded_at
from customer_contacts cc
left join customer_transactions ct
    on cc.contact_id = ct.customer_id