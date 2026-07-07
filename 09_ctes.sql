-- Question 46: Find high revenue customers using a CTE.

WITH revenue_cte AS
(
    SELECT
        account_id,
        SUM(mrr_amount) AS total_revenue
    FROM subscriptions
    GROUP BY account_id
)

SELECT *
FROM revenue_cte
WHERE total_revenue > 10000;

-- Question 47: Find industries with average revenue.

WITH industry_revenue AS
(
    SELECT
        a.industry,
        AVG(s.mrr_amount) AS avg_revenue

    FROM accounts a

    JOIN subscriptions s
    ON a.account_id = s.account_id

    GROUP BY a.industry
)

SELECT *
FROM industry_revenue
ORDER BY avg_revenue DESC;

-- Question 48: Find countries with high churn.

WITH churn_country AS
(
    SELECT
        a.country,
        COUNT(c.churn_event_id) AS churn_count

    FROM accounts a

    JOIN churn_events c
    ON a.account_id = c.account_id

    GROUP BY a.country
)

SELECT *
FROM churn_country
ORDER BY churn_count DESC;

-- Question 49: Find industries with highest satisfaction.

WITH satisfaction_cte AS
(
    SELECT
        a.industry,
        AVG(t.satisfaction_score) AS avg_score

    FROM accounts a

    JOIN support_tickets t
    ON a.account_id = t.account_id

    WHERE t.satisfaction_score > 0

    GROUP BY a.industry
)

SELECT *
FROM satisfaction_cte
ORDER BY avg_score DESC;

-- Question 50: Calculate average seats by plan.

WITH seats_cte AS
(
    SELECT
        plan_tier,
        AVG(seats) AS avg_seats

    FROM subscriptions

    GROUP BY plan_tier
)

SELECT *
FROM seats_cte;