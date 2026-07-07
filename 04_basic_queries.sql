-- Question 10: How many customers does the company have?

SELECT COUNT(*) AS total_customers
FROM accounts;

-- Question 11: How many subscriptions exist?

SELECT COUNT(*) AS total_subscriptions
FROM subscriptions;

-- Question 12: How many active subscriptions are there?

SELECT COUNT(*) AS active_subscriptions
FROM subscriptions
WHERE churn_flag = 0;

-- Question 13: How many churned subscriptions are there?

SELECT COUNT(*) AS churned_subscriptions
FROM subscriptions
WHERE churn_flag = 1;

-- Question 14: Show the top 10 customers by MRR.

SELECT 
    account_id, mrr_amount
FROM
    subscriptions
ORDER BY mrr_amount DESC
LIMIT 10;

-- Question 15: Find all Enterprise customers.

SELECT account_name,
       industry,
       country
FROM accounts
WHERE plan_tier = 'Enterprise';

-- Question 16: Find trial customers.

SELECT account_name,
       plan_tier
FROM accounts
WHERE is_trial = 1;

-- Question 17: Find subscriptions with auto-renew enabled.

SELECT subscription_id,
       account_id,
       mrr_amount
FROM subscriptions
WHERE auto_renew_flag = 1;