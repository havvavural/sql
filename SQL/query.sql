/*How can you isolate (or group) the transactions of each cardholder?*/

SELECT ch.name, SUM(t.id) AS total_transaction
FROM card_holder AS ch
JOIN credit_card AS cc ON ch.id = cc.id_card_holder
JOIN transaction AS t ON t.card = cc.card
GROUP BY ch.name;

/*Consider the time period 7:00 a.m. to 9:00 a.m.
What are the 100 highest transactions during this time period?
Do you see any fraudulent or anomalous transactions?
If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.*/

SELECT amount, date_part('hour',date) AS hour
FROM transaction
WHERE date_part('hour',date) >= 7 AND date_part('hour',date) <= 9
ORDER BY amount DESC
LIMIT 100;

/*Some fraudsters hack a credit card by making several small payments (generally less than $2.00), 
which are typically ignored by cardholders. Count the transactions that are less than $2.00 per cardholder.
Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.*/
 

SELECT ch.name, COUNT(t.id) AS number_of_transaction
FROM card_holder AS ch
JOIN credit_card AS cc ON ch.id = cc.id_card_holder
JOIN transaction AS t ON t.card = cc.card
WHERE t.amount < '2.00'
GROUP BY ch.name;

/*What are the top five merchants prone to being hacked using small transactions?
 Once you have a query that can be reused, create a view for each of the previous queries.*/

SELECT merchant.name AS merchant_name, COUNT(transaction.id) AS number_of_small_transactions
FROM transaction
INNER JOIN merchant ON merchant.id = transaction.id_merchant
WHERE amount < '2.00'
GROUP BY merchant.name
ORDER BY number_of_small_transactions DESC
LIMIT 5;

 
/*Create a report for fraudulent transactions of some top customers of the firm. 
To achieve this task, perform a visual data analysis of fraudulent transactions using 
Pandas, Plotly Express, hvPlot, and SQLAlchemy to create the visualizations.
Verify if there are any fraudulent transactions in the history of two of the most important customers of the firm.
For privacy reasons, you only know that their cardholders' IDs are 18 and 2.
Using hvPlot, create a line plot representing the time series of transactions over the course of the year for each cardholder. 
In order to compare the patterns of both cardholders, create a line plot containing both lines.
What difference do you observe between the consumption patterns? Does the difference suggest a fraudulent transaction? 
Explain your rationale.*/


--cardholder = 2
SELECT ch.id, t.date,t.amount
FROM card_holder AS ch
JOIN credit_card AS cc ON ch.id = cc.id_card_holder
JOIN transaction AS t ON t.card = cc.card
WHERE ch.id = 2;

--cardholder = 18
SELECT ch.id, t.date,t.amount
FROM card_holder AS ch
JOIN credit_card AS cc ON ch.id = cc.id_card_holder
JOIN transaction AS t ON t.card = cc.card
WHERE ch.id = 18;

/*The CEO of the firm's biggest customer suspects that someone has used her corporate credit card without authorization 
in the first quarter of 2018 to pay for several expensive restaurant bills. You are asked to find any anomalous transactions 
during that period.Using Plotly Express, create a series of six box plots, one for each month, in order to 
identify how many outliers there are per month for cardholder ID 25.Do you notice any anomalies? Describe your 
observations and conclusions.*/


SELECT ch.id, ch.name, cc.card,t.date,t.amount,mc.name AS category
FROM card_holder AS ch
JOIN credit_card AS cc ON ch.id = cc.id_card_holder
JOIN transaction AS t ON t.card = cc.card
JOIN merchant AS m ON m.id = t.id_merchant
JOIN merchant_category AS mc ON mc.id = m.id_merchant_category
WHERE ch.id = 25 AND date BETWEEN '2018-01-01' AND  '2018-07-01';







