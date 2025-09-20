{{ config(materialized='view') }}

select
    id as contact_id,
    first_name,
    last_name,
    email,
    current_timestamp as _loaded_at
from {{ source('salesforce', 'contact') }}