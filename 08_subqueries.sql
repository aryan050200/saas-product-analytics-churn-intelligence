-- Question 41: Find customers with above-average MRR.

SELECT
    account_id,
    mrr_amount

FROM subscriptions

WHERE mrr_amount >
(
    SELECT AVG(mrr_amount)
    FROM subscriptions
);

-- Question 42: Find customers that churned.

SELECT
    account_name,
    industry

FROM accounts

WHERE account_id IN
(
    SELECT account_id
    FROM churn_events
);

-- Question 43: Find customers with high seat counts.

SELECT
    account_id,
    seats

FROM subscriptions

WHERE seats >
(
    SELECT AVG(seats)
    FROM subscriptions
);

-- Question 44: Find industries with above-average revenue.

SELECT
    industry,
    total_revenue

FROM
(
    SELECT
        a.industry,
        SUM(s.mrr_amount) AS total_revenue

    FROM accounts a

    JOIN subscriptions s
    ON a.account_id = s.account_id

    GROUP BY a.industry
) AS industry_revenue

WHERE total_revenue >
(
    SELECT AVG(total_revenue)

    FROM
    (
        SELECT
            SUM(s.mrr_amount) AS total_revenue

        FROM accounts a

        JOIN subscriptions s
        ON a.account_id = s.account_id

        GROUP BY a.industry
    ) AS avg_table
);

-- Question 45: Find customers with more tickets than average.

SELECT
    account_id,
    COUNT(ticket_id) AS ticket_count

FROM support_tickets

GROUP BY account_id

HAVING COUNT(ticket_id) >
(
    SELECT AVG(ticket_total)

    FROM
    (
        SELECT
            COUNT(ticket_id) AS ticket_total

        FROM support_tickets

        GROUP BY account_id
    ) AS ticket_avg
);