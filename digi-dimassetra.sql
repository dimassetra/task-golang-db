CREATE TABLE IF NOT EXISTS auths (
    auth_id BIGSERIAL PRIMARY KEY,
    account_id BIGINT UNIQUE NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Buat tabel accounts
CREATE TABLE IF NOT EXISTS accounts (
    account_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    balance BIGINT NOT NULL,
    referral_account_id BIGINT NULL
);

-- Buat tabel transaction_categories
CREATE TABLE IF NOT EXISTS transaction_categories (
    transaction_category_id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Buat tabel transaction
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id BIGSERIAL PRIMARY KEY,
    transaction_category_id BIGINT NULL,
    account_id BIGINT NOT NULL,
    from_account_id BIGINT NULL,
    to_account_id BIGINT NULL,
    amount BIGINT NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Definisikan foreign key
    FOREIGN KEY (transaction_category_id) REFERENCES transaction_categories(transaction_category_id),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    FOREIGN KEY (from_account_id) REFERENCES accounts(account_id),
    FOREIGN KEY (to_account_id) REFERENCES accounts(account_id)
);

INSERT INTO accounts (name, balance, referral_account_id) VALUES
('John Doe', 100000, NULL),
('Jane Smith', 150000, NULL),
('Michael Johnson', 200000, 1),
('Emily Davis', 50000, 2),
('Chris Brown', 120000, 3);

INSERT INTO transaction_categories (name) VALUES
('Deposit'),
('Withdrawal');

INSERT INTO transactions (transaction_category_id, account_id, from_account_id, to_account_id, amount, transaction_date) VALUES
(1, 1, NULL, 1, 5000, '2024-01-01 00:00:00'),  -- Deposit for January
(2, 2, 2, NULL, 3000, '2024-02-01 00:00:00'),  -- Withdrawal for February
(1, 3, NULL, 3, 20000, '2024-03-01 00:00:00'), -- Deposit for March
(2, 4, 4, NULL, 1500, '2024-04-01 00:00:00'),  -- Withdrawal for April
(1, 5, NULL, 5, 10000, '2024-05-01 00:00:00'), -- Deposit for May
(2, 1, 1, NULL, 5000, '2024-06-01 00:00:00'),  -- Withdrawal for June
(1, 2, NULL, 2, 7000, '2024-07-01 00:00:00'),  -- Deposit for July
(2, 3, 3, NULL, 2500, '2024-08-01 00:00:00'),  -- Withdrawal for August
(1, 4, NULL, 4, 12000, '2024-09-01 00:00:00'), -- Deposit for September
(2, 5, 5, NULL, 8000, '2024-10-01 00:00:00'),  -- Withdrawal for October
(1, 1, NULL, 1, 6000, '2024-11-01 00:00:00'),  -- Deposit for November
(2, 2, 2, NULL, 4000, '2024-12-01 00:00:00');  -- Withdrawal for December

UPDATE accounts
SET name = 'New Name'
WHERE account_id = 1;


UPDATE accounts
SET balance = 200000
WHERE account_id = 1;

SELECT * FROM accounts;

SELECT t.transaction_id, t.transaction_category_id, t.account_id, t.from_account_id, t.to_account_id, t.amount, t.transaction_date, a.name AS account_name
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id;

SELECT * FROM accounts
ORDER BY balance DESC
LIMIT 1;

SELECT * FROM transactions
WHERE EXTRACT(MONTH FROM transaction_date) = 5;