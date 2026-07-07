-- Question 60: Classify customer health.

SELECT
    s.account_id,
    AVG(s.mrr_amount) AS avg_mrr,
    AVG(NULLIF(t.satisfaction_score,-1)) AS avg_satisfaction,

    CASE
        WHEN AVG(s.mrr_amount) > 10000
             AND AVG(NULLIF(t.satisfaction_score,-1)) >= 4
        THEN 'Healthy'

        WHEN AVG(NULLIF(t.satisfaction_score,-1)) < 3
        THEN 'At Risk'

        ELSE 'Moderate'
    END AS customer_health

FROM subscriptions s

LEFT JOIN support_tickets t
ON s.account_id = t.account_id

GROUP BY s.account_id;