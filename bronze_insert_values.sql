
create or alter procedure bronze.load_bronze as
begin
	print ' start_time and end_time'
	declare @start_time DATETIME, @end_time DATETIME,@batch_start_time Datetime, @batch_end_time datetime;
	
	begin try

		print '====================================='
		print 'Loading Bronze Layer';
		print '====================================='

		print '====================================='
		print 'Loading CRM Tables';
		print '====================================='
		
		set @batch_start_time = getdate ()
		print '====================================='
		set @start_time = getdate();
		--file crm_cust_info
		truncate table bronze.crm_cust_info;

		bulk insert bronze.crm_cust_info
		from 'C:\Users\User\Downloads\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds';
		print '>> ---------------------';

		set @start_time = getdate();
		--file crm_prd_info
		truncate table bronze.crm_prd_id_info;

		bulk insert bronze.crm_prd_id_info
		from 'C:\Users\User\Downloads\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds';
		print '>> ---------------------';

		set @start_time = getdate();
		-- file crm_sales_details
		truncate table bronze.crm_sales_details

		bulk insert bronze.crm_sales_details
		from 'C:\Users\User\Downloads\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds';
		print '>> ---------------------';

		print '====================================='
		print 'Loading ERP Tables';
		print '====================================='

		set @start_time = getdate();
		-- file erp_cust_az12
		truncate table bronze.erp_cust_az12;

		bulk insert bronze.erp_cust_az12
		from 'C:\Users\User\Downloads\CUST_AZ12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds';
		print '>> ---------------------';

		set @start_time = getdate();
		-- file erp_LOC_A101
		truncate table bronze.erp_loc_a101;

		bulk insert bronze.erp_loc_a101
		from 'C:\Users\User\Downloads\loc_a101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds';
		print '>> ---------------------';
		
		set @start_time = getdate();
		-- file erp_PX_CAT_G1V2
		truncate table bronze.erp_px_cat_g1v2;

		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\User\Downloads\px_cat_g1v2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);

		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds';
		print '>> ---------------------';
		set @batch_end_time  = getdate()
		
		

	end try
	begin catch
		print '================================'
		print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		print 'Error Message' + ERROR_MESSAGE();
		print 'Error Message' + cast(ERROR_NUMBER() as nvarchar);
		print 'Error Message' + cast(ERROR_STATE() as nvarchar);
		print '================================'
	end catch
	print '================================'
	print 'Loading Bronze Layer is Completed'
		print '- Total Load Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as Nvarchar) + 'seconds';
	print '================================'
end
