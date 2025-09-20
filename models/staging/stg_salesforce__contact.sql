-- models/staging/stg_salesforce__contact.sql

SELECT account_id,
       first_name,
       last_name,
       email,
       mailing_street,
       mailing_city,
       mailing_state,
       mailing_postal_code,
       loyalty_tier__c
FROM {{ source('rma_salesforce', 'CONTACT') }}
WHERE is_deleted = FALSE
