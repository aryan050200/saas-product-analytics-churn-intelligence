-- Question 51: Rank customers by MRR.

SELECT
    account_id,
    mrr_amount,

    RANK() OVER(
        ORDER BY mrr_amount DESC
    ) AS revenue_rank

FROM subscriptions;

-- Question 52: Dense rank customers.

SELECT
    account_id,
    mrr_amount,

    DENSE_RANK() OVER(
        ORDER BY mrr_amount DESC
    ) AS customer_rank

FROM subscriptions;

-- Question 53: Assign row numbers.

SELECT
    account_id,
    mrr_amount,

    ROW_NUMBER() OVER(
        ORDER BY mrr_amount DESC
    ) AS row_num

FROM subscriptions;

-- Question 54: Compare revenue with previous customer.

SELECT
    account_id,
    mrr_amount,

    LAG(mrr_amount)
    OVER(
        ORDER BY mrr_amount
    ) AS previous_revenue

FROM subscriptions;

-- Question 55: Compare revenue with next customer.

SELECT
    account_id,
    mrr_amount,

    LEAD(mrr_amount)
    OVER(
        ORDER BY mrr_amount
    ) AS next_revenue

FROM subscriptions;

-- Question 56: Find top customers within each plan.

SELECT
    account_id,
    plan_tier,
    mrr_amount,

    RANK() OVER(
        PARTITION BY plan_tier
        ORDER BY mrr_amount DESC
    ) AS plan_rank

FROM subscriptions;