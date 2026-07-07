-- Question 26: Classify customers according to MRR.

SELECT account_id,
       mrr_amount,

       CASE
           WHEN mrr_amount >= 10000
                THEN 'High Value'

           WHEN mrr_amount >= 5000
                THEN 'Medium Value'

           ELSE 'Low Value'
       END AS customer_segment

FROM subscriptions;

-- Question 27: Categorize customers by team size.

SELECT account_id,
       seats,

       CASE
           WHEN seats >= 100
                THEN 'Large Company'

           WHEN seats >= 50
                THEN 'Medium Company'

           ELSE 'Small Company'
       END AS company_size

FROM subscriptions;

-- Question 28: Determine subscription status.

SELECT subscription_id,

       CASE
           WHEN churn_flag = 1
                THEN 'Churned'

           ELSE 'Active'
       END AS status

FROM subscriptions;

-- Question 29: Classify support satisfaction.

SELECT ticket_id,
       satisfaction_score,

       CASE
           WHEN satisfaction_score >= 4
                THEN 'Satisfied'

           WHEN satisfaction_score >= 3
                THEN 'Neutral'

           ELSE 'Unsatisfied'
       END AS customer_feedback

FROM support_tickets
WHERE satisfaction_score != -1;