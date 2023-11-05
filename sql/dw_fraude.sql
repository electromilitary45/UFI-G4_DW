--
-- PROYECTO UFIDELITAS GRUPO#4 || DATAWAREHOUSE Q3 2023
--

---------------------------BASE DE DATOS---------------------------------

-------DANGER-------

DROP DATABASE DW_FRAUDE;

DROP TABLE dim_card_holder;
DROP TABLE dim_credit_card;
DROP TABLE dim_merchant_category;
DROP TABLE dim_merchant;
DROP TABLE fact_transaction;
--------------------

----------------------------CREACION TABLAS-----------------------------
use master;
create database DW_FRAUDE;
use DW_FRAUDE;

-- DIM_CARD_HOLDER
CREATE TABLE Dim_CardHolder (
    CardHolderID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

-- DIM_CREDIT_CARD
CREATE TABLE Dim_CreditCard (
    CardNumber VARCHAR(20) PRIMARY KEY,
    CardHolderID INT NOT NULL,
    CONSTRAINT FK_CreditCard_CardHolder FOREIGN KEY (CardHolderID) REFERENCES Dim_CardHolder(CardHolderID),
    CONSTRAINT CK_CreditCard_Length CHECK (LEN(CardNumber) <= 20)
);

-- DIM_MERCHANT_CATEGORY
CREATE TABLE Dim_MerchantCategory (
    MerchantCategoryID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

-- DIM_MERCHANT
CREATE TABLE Dim_Merchant (
    MerchantID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    MerchantCategoryID INT NOT NULL,
    CONSTRAINT FK_Merchant_MerchantCategory FOREIGN KEY (MerchantCategoryID) REFERENCES Dim_MerchantCategory(MerchantCategoryID)
);


-- FACT_TRANSACTION
CREATE TABLE Fact_Transaction (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATETIME NOT NULL,
    Amount FLOAT NOT NULL,
    CardNumber VARCHAR(20) NOT NULL,
    MerchantID INT NOT NULL,
    CardHolderID INT NOT NULL,
    CONSTRAINT FK_Transaction_CreditCard FOREIGN KEY (CardNumber) REFERENCES Dim_CreditCard(CardNumber),
    CONSTRAINT FK_Transaction_Merchant FOREIGN KEY (MerchantID) REFERENCES Dim_Merchant(MerchantID)
);
