CREATE TABLE card_holder(
	id INT PRIMARY KEY,
	name VARCHAR(50)
);

SELECT * FROM card_holder;

CREATE TABLE credit_card (
	card VARCHAR(20) PRIMARY KEY,
	id_card_holder INT,
	FOREIGN KEY (id_card_holder) REFERENCES card_holder(id)
);

SELECT * FROM credit_card;

CREATE TABLE merchant_category(
	id INT PRIMARY KEY,
	name VARCHAR(50)
);

SELECT * FROM merchant_category;

CREATE TABLE merchant (
	id INT PRIMARY KEY,
	name VARCHAR(50),
	id_merchant_category INT,
	FOREIGN KEY (id_merchant_category) REFERENCES merchant_category(id)
);

SELECT * FROM merchant;

CREATE TABLE transaction (
	id INT PRIMARY KEY,
	date TIMESTAMP,
	amount FLOAT,
	card VARCHAR(20),
	id_merchant INT,
	FOREIGN KEY (card) REFERENCES credit_card(card),
	FOREIGN KEY (id_merchant) REFERENCES merchant(id)	 
);

SELECT * FROM transaction;
