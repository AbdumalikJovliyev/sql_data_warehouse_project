/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema if they do not exist.
    Used for defining the structure of Bronze (raw ingestion) tables.
===============================================================================
*/

-- =====================================================
-- CRM CUSTOMER INFO
-- =====================================================

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NULL   -- IMPROVEMENT: prevent dropping historical data
CREATE TABLE bronze.crm_cust_info (

    bronze_id BIGINT IDENTITY(1,1),  -- IMPROVEMENT: surrogate ingestion key

    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE,

    load_dt DATETIME2 DEFAULT GETDATE()  -- IMPROVEMENT: ingestion timestamp
);
GO


-- =====================================================
-- CRM PRODUCT INFO
-- =====================================================

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NULL
CREATE TABLE bronze.crm_prd_info (

    bronze_id BIGINT IDENTITY(1,1),  -- IMPROVEMENT

    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     DECIMAL(18,2),  -- IMPROVEMENT: avoid losing money precision
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME,

    load_dt DATETIME2 DEFAULT GETDATE()  -- IMPROVEMENT
);
GO


-- =====================================================
-- CRM SALES DETAILS
-- =====================================================

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NULL
CREATE TABLE bronze.crm_sales_details (

    bronze_id BIGINT IDENTITY(1,1),  -- IMPROVEMENT

    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,

    sls_order_dt DATE,   -- IMPROVEMENT: replaced INT with DATE
    sls_ship_dt  DATE,   -- IMPROVEMENT
    sls_due_dt   DATE,   -- IMPROVEMENT

    sls_sales    DECIMAL(18,2), -- IMPROVEMENT
    sls_quantity INT,
    sls_price    DECIMAL(18,2), -- IMPROVEMENT

    load_dt DATETIME2 DEFAULT GETDATE() -- IMPROVEMENT
);
GO


-- =====================================================
-- ERP LOCATION
-- =====================================================

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NULL
CREATE TABLE bronze.erp_loc_a101 (

    bronze_id BIGINT IDENTITY(1,1),  -- IMPROVEMENT

    cid    NVARCHAR(50),
    cntry  NVARCHAR(50),

    load_dt DATETIME2 DEFAULT GETDATE() -- IMPROVEMENT
);
GO


-- =====================================================
-- ERP CUSTOMER
-- =====================================================

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NULL
CREATE TABLE bronze.erp_cust_az12 (

    bronze_id BIGINT IDENTITY(1,1),  -- IMPROVEMENT

    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50),

    load_dt DATETIME2 DEFAULT GETDATE() -- IMPROVEMENT
);
GO


-- =====================================================
-- ERP PRODUCT CATEGORY
-- =====================================================

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NULL
CREATE TABLE bronze.erp_px_cat_g1v2 (

    bronze_id BIGINT IDENTITY(1,1),  -- IMPROVEMENT

    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50),

    load_dt DATETIME2 DEFAULT GETDATE() -- IMPROVEMENT
);
GO
