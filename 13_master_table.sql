-- Question 61: Create the master analytical table.

CREATE TABLE master_table AS

WITH usage_summary AS
(
    SELECT
        subscription_id,
        AVG(usage_count) AS avg_usage,
        AVG(usage_duration_secs) AS avg_duration,
        AVG(error_count) AS avg_errors
    FROM feature_usage
    GROUP BY subscription_id
),

support_summary AS
(
    SELECT
        account_id,
        COUNT(ticket_id) AS total_tickets,
        AVG(NULLIF(satisfaction_score,-1)) AS avg_satisfaction,
        AVG(resolution_time_hours) AS avg_resolution_time
    FROM support_tickets
    GROUP BY account_id
),

churn_summary AS
(
    SELECT
        account_id,
        1 AS churn_flag,
        MAX(refund_amount_usd) AS refund_amount
    FROM churn_events
    GROUP BY account_id
)

SELECT
    a.account_id,
    a.account_name,
    a.industry,
    a.country,
    a.plan_tier,

    AVG(s.seats) AS avg_seats,
    AVG(s.mrr_amount) AS avg_mrr,
    AVG(s.arr_amount) AS avg_arr,
    AVG(s.tenure_days) AS avg_tenure_days,

    AVG(u.avg_usage) AS avg_usage,
    AVG(u.avg_duration) AS avg_duration,
    AVG(u.avg_errors) AS avg_errors,

    ss.total_tickets,
    ss.avg_satisfaction,
    ss.avg_resolution_time,

    COALESCE(c.churn_flag,0) AS churn_flag,
    COALESCE(c.refund_amount,0) AS refund_amount

FROM accounts a

LEFT JOIN subscriptions s
ON a.account_id = s.account_id

LEFT JOIN usage_summary u
ON s.subscription_id = u.subscription_id

LEFT JOIN support_summary ss
ON a.account_id = ss.account_id

LEFT JOIN churn_summary c
ON a.account_id = c.account_id

GROUP BY
    a.account_id,
    a.account_name,
    a.industry,
    a.country,
    a.plan_tier,
    ss.total_tickets,
    ss.avg_satisfaction,
    ss.avg_resolution_time,
    c.churn_flag,
    c.refund_amount;
    
--  Question 62: Check the master table.
SELECT *
FROM master_table
LIMIT 10;

-- Question 63: Count rows in the master table.
SELECT COUNT(*)
FROM master_table;

-- Question 64: Check churn distribution.
SELECT
    churn_flag,
    COUNT(*) AS customers
FROM master_table
GROUP BY churn_flag;

-- Question 65: Average revenue by churn status.
SELECT
    churn_flag,
    AVG(avg_mrr) AS avg_mrr
FROM master_table
GROUP BY churn_flag;

-- Question 66: Average satisfaction by churn status.
SELECT
    churn_flag,
    AVG(avg_satisfaction) AS avg_score
FROM master_table
GROUP BY churn_flag;

-- Question 67: Which industries have the highest churn?
SELECT
    industry,
    AVG(churn_flag) * 100 AS churn_rate
FROM master_table
GROUP BY industry
ORDER BY churn_rate DESC;

-- Question 68: Examine customer tenure patterns.
SELECT avg_tenure_days
FROM master_table
LIMIT 10;

-- Question 69: What is the average customer tenure by churn status?
SELECT
    churn_flag,
    AVG(avg_tenure_days) AS avg_tenure
FROM master_table
GROUP BY churn_flag;