-- Question 2: Create the accounts table.

CREATE TABLE accounts (
    account_id VARCHAR(20) PRIMARY KEY,
    account_name VARCHAR(100),
    industry VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE,
    referral_source VARCHAR(50),
    plan_tier VARCHAR(30),
    seats INT,
    is_trial BOOLEAN,
    churn_flag BOOLEAN
);

-- Question 3: Create the subscription table.

CREATE TABLE subscriptions (
    subscription_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20),
    start_date DATE,
    end_date VARCHAR(20),
    plan_tier VARCHAR(30),
    seats INT,
    mrr_amount INT,
    arr_amount INT,
    tenure_days INT,
    is_trial TINYINT,
    upgrade_flag TINYINT,
    downgrade_flag TINYINT,
    churn_flag TINYINT,
    billing_frequency VARCHAR(30),
    auto_renew_flag TINYINT
);

-- Question 4: Create the feature usage table.

CREATE TABLE feature_usage (
    usage_id VARCHAR(20) PRIMARY KEY,
    subscription_id VARCHAR(20),
    usage_date DATE,
    feature_name VARCHAR(50),
    usage_count INT,
    usage_duration_secs INT,
    error_count INT,
    is_beta_feature TINYINT
);

-- Question 5: Create the support tickets table.

CREATE TABLE support_tickets (
    ticket_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20),
    submitted_at DATETIME,
    closed_at DATETIME,
    resolution_time_hours DECIMAL(8,2),
    priority VARCHAR(20),
    first_response_time_minutes INT,
    satisfaction_score DECIMAL(4,2),
    escalation_flag TINYINT
);

-- Question 6: Create the churn events table.

CREATE TABLE churn_events (
    churn_event_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20),
    churn_date DATE,
    reason_code VARCHAR(50),
    refund_amount_usd DECIMAL(10,2),
    preceding_upgrade_flag TINYINT,
    preceding_downgrade_flag TINYINT,
    is_reactivation TINYINT,
    feedback_text TEXT
);