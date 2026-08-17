
/*USE DataWarehouse;
GO*/

EXEC bronze.load_bronze;
 CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @start_time DATETIME,
            @end_time DATETIME;

    BEGIN TRY

        PRINT '=============================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '=============================';

        PRINT '-----------------------------';
        PRINT 'LOADING CRM TABLES';
        PRINT '-----------------------------';


        -------------------------------------------------------
        -- CRM CUSTOMER TABLE
        -------------------------------------------------------

        SET @start_time = GETDATE();

        PRINT 'TRUNCATING TABLE: bronze.crm_cust_info';

        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT 'LOADING DATA INTO: bronze.crm_cust_info';

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\saswa\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> LOADING DURATION: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';


        -------------------------------------------------------
        -- CRM PRODUCT TABLE
        -------------------------------------------------------

        SET @start_time = GETDATE();

        PRINT 'TRUNCATING TABLE: bronze.crm_prd_info';

        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT 'LOADING DATA INTO: bronze.crm_prd_info';

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\saswa\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> LOADING DURATION: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';


        -------------------------------------------------------
        -- CRM SALES DETAILS TABLE
        -------------------------------------------------------

        SET @start_time = GETDATE();

        PRINT 'TRUNCATING TABLE: bronze.crm_sales_details';

        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT 'LOADING DATA INTO: bronze.crm_sales_details';

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\saswa\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> LOADING DURATION: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';


        -------------------------------------------------------
        -- ERP TABLES
        -------------------------------------------------------

        PRINT '-----------------------------';
        PRINT 'LOADING ERP TABLES';
        PRINT '-----------------------------';


        -------------------------------------------------------
        -- ERP CUSTOMER TABLE
        -------------------------------------------------------

        SET @start_time = GETDATE();

        PRINT 'TRUNCATING TABLE: bronze.erp_cust_az12';

        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT 'LOADING DATA INTO: bronze.erp_cust_az12';

        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\saswa\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> LOADING DURATION: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';


        -------------------------------------------------------
        -- ERP LOCATION TABLE
        -------------------------------------------------------

        SET @start_time = GETDATE();

        PRINT 'TRUNCATING TABLE: bronze.erp_loc_a101';

        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT 'LOADING DATA INTO: bronze.erp_loc_a101';

        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\saswa\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> LOADING DURATION: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';


        -------------------------------------------------------
        -- ERP PRODUCT CATEGORY TABLE
        -------------------------------------------------------

        SET @start_time = GETDATE();

        PRINT 'TRUNCATING TABLE: bronze.erp_px_cat_g1v2';

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT 'LOADING DATA INTO: bronze.erp_px_cat_g1v2';

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\saswa\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> LOADING DURATION: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';


        -------------------------------------------------------
        -- SUCCESS MESSAGE
        -------------------------------------------------------

        PRINT '==========================================';
        PRINT 'BRONZE LAYER LOADED SUCCESSFULLY';
        PRINT '==========================================';

    END TRY

    BEGIN CATCH

        PRINT '==========================================';
        PRINT 'ERROR OCCURRED DURING BRONZE LAYER LOADING';
        PRINT '==========================================';

        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR);

        PRINT '==========================================';

        -- Re-raise the error so SQL Server also reports it
        THROW;

    END CATCH

END;
GO
