-- models/staging/stg_salesforce__contact.sql

SELECT id                AS contact_id,
       name              AS full_name,
       email,
       mailingstreet     AS mailing_street,
       mailingcity       AS mailing_city,
       mailingstate      AS mailing_state,
       mailingpostalcode AS mailing_postal_code,
       loyalty_tier__c   AS loyalty_tier
FROM {{ source('rma_salesforce', 'contact') }}
WHERE is_deleted = FALSE
