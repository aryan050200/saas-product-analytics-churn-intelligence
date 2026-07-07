-- Question 7: How many records are present in each table?

SELECT COUNT(*) FROM accounts;
SELECT COUNT(*) FROM subscriptions;
SELECT COUNT(*) FROM feature_usage;
SELECT COUNT(*) FROM support_tickets;
SELECT COUNT(*) FROM churn_events;

-- Question 8: Check active subscriptions.

SELECT *
FROM subscriptions
WHERE churn_flag = 0;

-- Question 9: Find customers without support ratings.

SELECT *
FROM support_tickets
WHERE satisfaction_score = -1;