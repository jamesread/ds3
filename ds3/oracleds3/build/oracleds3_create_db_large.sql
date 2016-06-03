
-- DS3 Database Build Scripts
-- Dave Jaffe  Todd Muirhead 8/31/05
-- Copyright Dell Inc. 2010

-- User

SET TERMOUT OFF
DROP USER DS3 CASCADE;
SET TERMOUT ON

CREATE USER DS3
  IDENTIFIED BY ds3 
  TEMPORARY TABLESPACE "TEMP"
  DEFAULT TABLESPACE "DS_MISC"
  ;

GRANT CONNECT, RESOURCE TO "DS3";

ALTER user DS3 quota unlimited on DS_MISC;
ALTER user DS3 quota unlimited on CUSTTBS;
ALTER user DS3 quota unlimited on INDXTBS;
ALTER user DS3 quota unlimited on ORDERTBS;
ALTER user DS3 quota unlimited on REVIEWTBS;
ALTER user DS3 quota unlimited on MEMBERTBS;


-- Tables

CREATE TABLE "DS3"."CUSTOMERS"
  (
  "CUSTOMERID" NUMBER NOT NULL, 
  "FIRSTNAME" VARCHAR2(50 byte) NOT NULL, 
  "LASTNAME" VARCHAR2(50 byte) NOT NULL, 
  "ADDRESS1" VARCHAR2(50 byte) NOT NULL, 
  "ADDRESS2" VARCHAR2(50 byte), 
  "CITY" VARCHAR2(50 byte) NOT NULL, 
  "STATE" VARCHAR2(50 byte), 
  "ZIP" NUMBER, 
  "COUNTRY" VARCHAR2(50 byte) NOT NULL, 
  "REGION" NUMBER NOT NULL,
  "EMAIL" VARCHAR2(50 byte),
  "PHONE" VARCHAR2(50 byte),
  "CREDITCARDTYPE" NUMBER NOT NULL,
  "CREDITCARD" VARCHAR2(50 byte), 
  "CREDITCARDEXPIRATION" VARCHAR2(50 byte) NOT NULL, 
  "USERNAME" VARCHAR2(50 byte) NOT NULL, 
  "PASSWORD" VARCHAR2(50 byte) NOT NULL, 
  "AGE" NUMBER, 
  "INCOME" NUMBER,
  "GENDER" VARCHAR2(6 byte)
  )
  TABLESPACE "CUSTTBS"
  PARTITION BY RANGE (REGION)
    (
    PARTITION US_PART VALUES LESS THAN (2),
    PARTITION ROW_PART VALUES LESS THAN (3),
    PARTITION MAXVAL VALUES LESS THAN (MAXVALUE)
    )
  ;

CREATE TABLE "DS3"."CUST_HIST"
  (
  "CUSTOMERID" NUMBER NOT NULL, 
  "ORDERID" NUMBER NOT NULL, 
  "PROD_ID" NUMBER NOT NULL 
  )
  TABLESPACE "CUSTTBS";

CREATE TABLE "DS3"."MEMBERSHIP"
  (
  "CUSTOMERID" NUMBER NOT NULL,
  "MEMBERSHIPTYPE" NUMBER NOT NULL,
  "EXPIREDATE" DATE NOT NULL
  )
  TABLESPACE "MEMBERTBS";

CREATE TABLE "DS3"."ORDERS"
  (
  "ORDERID" NUMBER NOT NULL, 
  "ORDERDATE" DATE NOT NULL, 
  "CUSTOMERID" NUMBER, 
  "NETAMOUNT" NUMBER(12, 2) NOT NULL, 
  "TAX" NUMBER(12, 2) NOT NULL, 
  "TOTALAMOUNT" NUMBER(12, 2) NOT NULL
  ) 
  TABLESPACE "ORDERTBS"
  PARTITION BY RANGE (ORDERDATE)
    (
    PARTITION JAN2013 VALUES LESS THAN (TO_DATE('2013/02/01', 'YYYY/MM/DD')),
    PARTITION FEB2013 VALUES LESS THAN (TO_DATE('2013/03/01', 'YYYY/MM/DD')),
    PARTITION MAR2013 VALUES LESS THAN (TO_DATE('2013/04/01', 'YYYY/MM/DD')),
    PARTITION APR2013 VALUES LESS THAN (TO_DATE('2013/05/01', 'YYYY/MM/DD')),
    PARTITION MAY2013 VALUES LESS THAN (TO_DATE('2013/06/01', 'YYYY/MM/DD')),
    PARTITION JUN2013 VALUES LESS THAN (TO_DATE('2013/07/01', 'YYYY/MM/DD')),
    PARTITION JUL2013 VALUES LESS THAN (TO_DATE('2013/08/01', 'YYYY/MM/DD')),
    PARTITION AUG2013 VALUES LESS THAN (TO_DATE('2013/09/01', 'YYYY/MM/DD')),
    PARTITION SEP2013 VALUES LESS THAN (TO_DATE('2013/10/01', 'YYYY/MM/DD')),
    PARTITION OCT2013 VALUES LESS THAN (TO_DATE('2013/11/01', 'YYYY/MM/DD')),
    PARTITION NOV2013 VALUES LESS THAN (TO_DATE('2013/12/01', 'YYYY/MM/DD')),
    PARTITION DEC2013 VALUES LESS THAN (TO_DATE('2014/01/01', 'YYYY/MM/DD')),
    PARTITION JAN2014 VALUES LESS THAN (TO_DATE('2014/02/01', 'YYYY/MM/DD')),
    PARTITION FEB2014 VALUES LESS THAN (TO_DATE('2014/03/01', 'YYYY/MM/DD')),
    PARTITION MAR2014 VALUES LESS THAN (TO_DATE('2014/04/01', 'YYYY/MM/DD')),
    PARTITION APR2014 VALUES LESS THAN (TO_DATE('2014/05/01', 'YYYY/MM/DD')),
    PARTITION MAY2014 VALUES LESS THAN (TO_DATE('2014/06/01', 'YYYY/MM/DD')),
    PARTITION JUN2014 VALUES LESS THAN (TO_DATE('2014/07/01', 'YYYY/MM/DD')),
    PARTITION JUL2014 VALUES LESS THAN (TO_DATE('2014/08/01', 'YYYY/MM/DD')),
    PARTITION AUG2014 VALUES LESS THAN (TO_DATE('2014/09/01', 'YYYY/MM/DD')),
    PARTITION SEP2014 VALUES LESS THAN (TO_DATE('2014/10/01', 'YYYY/MM/DD')),
    PARTITION OCT2014 VALUES LESS THAN (TO_DATE('2014/11/01', 'YYYY/MM/DD')),
    PARTITION NOV2014 VALUES LESS THAN (TO_DATE('2014/12/01', 'YYYY/MM/DD')),
    PARTITION DEC2014 VALUES LESS THAN (TO_DATE('2015/01/01', 'YYYY/MM/DD')),
    PARTITION JAN2015 VALUES LESS THAN (TO_DATE('2015/02/01', 'YYYY/MM/DD')),
    PARTITION MAXVAL VALUES LESS THAN (MAXVALUE)
    )
  ;

CREATE TABLE "DS3"."ORDERLINES"
  (
  "ORDERLINEID" NUMBER NOT NULL, 
  "ORDERID" NUMBER NOT NULL, 
  "PROD_ID" NUMBER NOT NULL, 
  "QUANTITY" NUMBER NOT NULL, 
  "ORDERDATE" DATE NOT NULL
  ) 
  TABLESPACE "ORDERTBS"
  PARTITION BY RANGE (ORDERDATE)
    (
    PARTITION JAN2013 VALUES LESS THAN (TO_DATE('2013/02/01', 'YYYY/MM/DD')),
    PARTITION FEB2013 VALUES LESS THAN (TO_DATE('2013/03/01', 'YYYY/MM/DD')),
    PARTITION MAR2013 VALUES LESS THAN (TO_DATE('2013/04/01', 'YYYY/MM/DD')),
    PARTITION APR2013 VALUES LESS THAN (TO_DATE('2013/05/01', 'YYYY/MM/DD')),
    PARTITION MAY2013 VALUES LESS THAN (TO_DATE('2013/06/01', 'YYYY/MM/DD')),
    PARTITION JUN2013 VALUES LESS THAN (TO_DATE('2013/07/01', 'YYYY/MM/DD')),
    PARTITION JUL2013 VALUES LESS THAN (TO_DATE('2013/08/01', 'YYYY/MM/DD')),
    PARTITION AUG2013 VALUES LESS THAN (TO_DATE('2013/09/01', 'YYYY/MM/DD')),
    PARTITION SEP2013 VALUES LESS THAN (TO_DATE('2013/10/01', 'YYYY/MM/DD')),
    PARTITION OCT2013 VALUES LESS THAN (TO_DATE('2013/11/01', 'YYYY/MM/DD')),
    PARTITION NOV2013 VALUES LESS THAN (TO_DATE('2013/12/01', 'YYYY/MM/DD')),
    PARTITION DEC2013 VALUES LESS THAN (TO_DATE('2014/01/01', 'YYYY/MM/DD')),
    PARTITION JAN2014 VALUES LESS THAN (TO_DATE('2014/02/01', 'YYYY/MM/DD')),
    PARTITION FEB2014 VALUES LESS THAN (TO_DATE('2014/03/01', 'YYYY/MM/DD')),
    PARTITION MAR2014 VALUES LESS THAN (TO_DATE('2014/04/01', 'YYYY/MM/DD')),
    PARTITION APR2014 VALUES LESS THAN (TO_DATE('2014/05/01', 'YYYY/MM/DD')),
    PARTITION MAY2014 VALUES LESS THAN (TO_DATE('2014/06/01', 'YYYY/MM/DD')),
    PARTITION JUN2014 VALUES LESS THAN (TO_DATE('2014/07/01', 'YYYY/MM/DD')),
    PARTITION JUL2014 VALUES LESS THAN (TO_DATE('2014/08/01', 'YYYY/MM/DD')),
    PARTITION AUG2014 VALUES LESS THAN (TO_DATE('2014/09/01', 'YYYY/MM/DD')),
    PARTITION SEP2014 VALUES LESS THAN (TO_DATE('2014/10/01', 'YYYY/MM/DD')),
    PARTITION OCT2014 VALUES LESS THAN (TO_DATE('2014/11/01', 'YYYY/MM/DD')),
    PARTITION NOV2014 VALUES LESS THAN (TO_DATE('2014/12/01', 'YYYY/MM/DD')),
    PARTITION DEC2014 VALUES LESS THAN (TO_DATE('2015/01/01', 'YYYY/MM/DD')),
    PARTITION JAN2015 VALUES LESS THAN (TO_DATE('2015/02/01', 'YYYY/MM/DD')),
    PARTITION MAXVAL VALUES LESS THAN (MAXVALUE)
    )
  ;


CREATE TABLE "DS3"."PRODUCTS"
  (
  "PROD_ID" NUMBER NOT NULL, 
  "CATEGORY" NUMBER NOT NULL, 
  "TITLE" VARCHAR2(50 byte) NOT NULL, 
  "ACTOR" VARCHAR2(50 byte) NOT NULL, 
  "PRICE" NUMBER(12, 2) NOT NULL, 
  "SPECIAL" NUMBER NOT NULL,
  "COMMON_PROD_ID" NUMBER NOT NULL,
  "MEMBERSHIP_ITEM" NUMBER NOT NULL
  )
  ;

CREATE TABLE "DS3"."REVIEWS"
  (
  "REVIEW_ID" NUMBER NOT NULL,
  "PROD_ID" NUMBER NOT NULL,
  "REVIEW_DATE" DATE NOT NULL,
  "STARS" NUMBER NOT NULL,
  "CUSTOMERID" NUMBER NOT NULL,
  "REVIEW_SUMMARY" VARCHAR2(50 byte) NOT NULL,
  "REVIEW_TEXT" VARCHAR2(1000 byte) NOT NULL
  )
  TABLESPACE "REVIEWTBS";

CREATE TABLE "DS3"."REVIEWS_HELPFULNESS"
  (
  "REVIEW_HELPFULNESS_ID" NUMBER NOT NULL,
  "REVIEW_ID" NUMBER NOT NULL,
  "CUSTOMERID" NUMBER NOT NULL,
  "HELPFULNESS" NUMBER NOT NULL
  )
  TABLESPACE "REVIEWTBS";

CREATE TABLE "DS3"."INVENTORY"
  (
  "PROD_ID" NUMBER NOT NULL,
  "QUAN_IN_STOCK" NUMBER NOT NULL,
  "SALES" NUMBER NOT NULL
  )
  ;

CREATE TABLE "DS3"."CATEGORIES"
  (
  "CATEGORY" NUMBER NOT NULL, 
  "CATEGORYNAME" VARCHAR2(50 byte) NOT NULL, 
  CONSTRAINT "PK_CATEGORIES" PRIMARY KEY("CATEGORY")
  )
  ;

  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (1,'Action');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (2,'Animation');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (3,'Children');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (4,'Classics');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (5,'Comedy');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (6,'Documentary');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (7,'Drama');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (8,'Family');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (9,'Foreign');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (10,'Games');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (11,'Horror');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (12,'Music');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (13,'New');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (14,'Sci-Fi');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (15,'Sports');
  INSERT INTO "DS3"."CATEGORIES" (CATEGORY, CATEGORYNAME) VALUES (16,'Travel');

CREATE TABLE "DS3"."REORDER" 
  (
  "PROD_ID" NUMBER NOT NULL, 
  "DATE_LOW" DATE NOT NULL, 
  "QUAN_LOW" NUMBER NOT NULL, 
  "DATE_REORDERED" DATE, 
  "QUAN_REORDERED" NUMBER, 
  "DATE_EXPECTED" DATE
  )  
  ;


-- Sequences

CREATE SEQUENCE "DS3"."CUSTOMERID_SEQ" 
  INCREMENT BY 1 
--START WITH 20001 
--START WITH 2000001
  START WITH 200000001
  MAXVALUE 1.0E28 
  MINVALUE 1 
  NOCYCLE 
  CACHE 1000000
  NOORDER
  ;

CREATE SEQUENCE "DS3"."ORDERID_SEQ" 
  INCREMENT BY 1 
--START WITH 20001
--START WITH 2000001
  START WITH 200000001 
  MAXVALUE 1.0E28 
  MINVALUE 1 
  NOCYCLE 
  CACHE 1000000 
  NOORDER
  ;

-- Data types

CREATE OR REPLACE  PACKAGE "DS3"."DS3_TYPES"  AS
  TYPE DS3_CURSOR IS REF CURSOR;
  TYPE ARRAY_TYPE IS TABLE OF VARCHAR2(50) INDEX BY BINARY_INTEGER;
  TYPE LONG_ARRAY_TYPE IS TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;
  TYPE N_TYPE IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
END DS3_TYPES;
/

COMMIT;

EXIT;
