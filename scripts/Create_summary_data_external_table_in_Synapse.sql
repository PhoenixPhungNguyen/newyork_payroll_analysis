CREATE DATABASE udacity

USE udacity;
GO 

--CREATE EXTERNAL FILE FORMAT
-- Use the same file format as used for creating the External Tables during the LOAD step.
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
FORMAT_OPTIONS (
FIELD_TERMINATOR = ',',
USE_TYPE_DEFAULT = FALSE
))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'abfss://synapsestorage-phung-n@synapsestoragephungn.dfs.core.windows.net') 
	CREATE EXTERNAL DATA SOURCE [abfss://synapsestorage-phung-n@synapsestoragephungn.dfs.core.windows.net] 
	WITH (
		LOCATION = 'abfss://synapsestorage-phung-n@synapsestoragephungn.dfs.core.windows.net' 
	)
GO

--Check dbo.NYC_Payroll_Summary table exists
IF OBJECT_ID('dbo.NYC_Payroll_Summary', 'U') IS NOT NULL
    DROP EXTERNAL TABLE dbo.NYC_Payroll_Summary;
GO

CREATE EXTERNAL TABLE [dbo].[NYC_Payroll_Summary](
    [AgencyName] [varchar](50) NULL,
    [FiscalYear] [int] NULL,
    [TotalPaid] [float] NULL
)
WITH (
LOCATION = 'dirstaging',
DATA_SOURCE = [abfss://synapsestorage-phung-n@synapsestoragephungn.dfs.core.windows.net],
FILE_FORMAT = [SynapseDelimitedTextFormat]
)
GO

--Check table 
SELECT TOP 10 * FROM dbo.NYC_Payroll_Summary;

SELECT * FROM sys.external_data_sources;
