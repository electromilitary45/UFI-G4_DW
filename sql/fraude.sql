----------------------------
-- PROYECTO UFIDELITAS G4 || DATAWAREHOUSE Q3 2023
-- TABLA ORIGEN DATOS FRAUDE
-- -------------------------

---------------------------BASE DE DATOS---------------------------------

-------DANGER-------
DROP DATABASE FRAUDE;

drop table t_card_holder;
drop table t_credit_card;
drop table t_merchant;
drop table t_merchant_category;
drop table t_transaction;

--------------------CREACION BASE DE DATOS-----------

use master;
create database FRAUDE;
use FRAUDE;

--------------------CREACION TABLAS----------------

-- Crear tabla "card_holder"
CREATE TABLE t_card_holder (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
);

-- Crear tabla "credit_card"
CREATE TABLE t_credit_card (
    card NVARCHAR(20) NOT NULL,
    id_card_holder INT NOT NULL,
    CONSTRAINT pk_credit_card PRIMARY KEY (card),
    CONSTRAINT fk_credit_card_id_card_holder FOREIGN KEY (id_card_holder) REFERENCES t_card_holder (id),
    CHECK (LEN(card) <= 20)
);

-- Crear tabla "merchant_category"
CREATE TABLE t_merchant_category (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
);

-- Crear tabla "merchant"
CREATE TABLE t_merchant (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    id_merchant_category INT NOT NULL,
    CONSTRAINT fk_merchant_id_merchant_category FOREIGN KEY (id_merchant_category) REFERENCES t_merchant_category (id)
);

-- Crear tabla "transaction"
CREATE TABLE t_transaction (
    id INT NOT NULL,
    date DATETIME NOT NULL,
    amount FLOAT NOT NULL,
    card NVARCHAR(20) NOT NULL,
    id_merchant INT NOT NULL,
    CONSTRAINT fk_transaction_card FOREIGN KEY (card) REFERENCES t_credit_card (card),
    CONSTRAINT fk_transaction_id_merchant FOREIGN KEY (id_merchant) REFERENCES t_merchant (id)
);