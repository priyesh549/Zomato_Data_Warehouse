-- =====================================================
-- File: 01_environment_setup.sql
-- Purpose: Snowflake warehouse, database, and schema setup
-- =====================================================

USE ROLE ACCOUNTADMIN;

-- -------------------------------
-- Warehouse
-- -------------------------------
CREATE OR REPLACE WAREHOUSE WH_ZOMATO
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND   = 60
    AUTO_RESUME    = TRUE
    INITIALLY_SUSPENDED = TRUE;

-- -------------------------------
-- Database
-- -------------------------------
CREATE OR REPLACE DATABASE ZOMATO_DWH;

-- -------------------------------
-- Context
-- -------------------------------
USE WAREHOUSE WH_ZOMATO;
USE DATABASE  ZOMATO_DWH;

-- -------------------------------
-- Schemas (Layered Architecture)
-- -------------------------------
CREATE OR REPLACE SCHEMA INGESTION;
CREATE OR REPLACE SCHEMA RAW;
CREATE OR REPLACE SCHEMA STG;
CREATE OR REPLACE SCHEMA INT;
CREATE OR REPLACE SCHEMA MARTS;

-- -------------------------------
-- Supporting Schemas
-- -------------------------------
CREATE OR REPLACE SCHEMA UTIL;
CREATE OR REPLACE SCHEMA APP;
