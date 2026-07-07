-- Question 57: Create revenue summary view.

CREATE VIEW revenue_summary AS

SELECT
    plan_tier,
    SUM(mrr_amount) AS total_revenue

FROM subscriptions

GROUP BY plan_tier;

-- Question 58: Create churn summary view.

CREATE VIEW churn_summary AS

SELECT
    reason_code,
    COUNT(*) AS churn_count

FROM churn_events

GROUP BY reason_code;

-- Question 59: Create customer satisfaction view.

CREATE VIEW customer_satisfaction AS

SELECT
    a.industry,
    AVG(t.satisfaction_score) AS avg_score

FROM accounts a

JOIN support_tickets t
ON a.account_id = t.account_id

WHERE t.satisfaction_score > 0

GROUP BY a.industry;