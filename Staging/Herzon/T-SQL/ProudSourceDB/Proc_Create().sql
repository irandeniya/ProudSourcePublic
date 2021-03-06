USE [ProudSourceDB]
GO
/****** Object:  StoredProcedure [dbo].[Proc_Create]    Script Date: 1/27/2016 11:07:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Herzon Flores
-- Create date: 1/14/2016
-- Description:	This procedure will create Proc entires
-- =============================================
ALTER PROCEDURE [dbo].[Proc_Create] 
	-- Add the parameters for the stored procedure here
	@Investor_ID INT,
	@Project_ID INT,
	@Performance_BeginDate DATETIME,
	@Performance_EndDate DATETIME,
	@Investment_Ammount MONEY,
	@Revenue_Percentage DECIMAL(18,0)
AS
BEGIN
    -- Insert statements for procedure here
	BEGIN TRY
		BEGIN TRAN Create_Proc_Entry
			DECLARE @New_Proc_ID INT;
			INSERT INTO Procs 
			(
				[Investor_ID],
				[Project_ID],
				[Created_Date],
				[Performance_BeginDate],
				[Performance_EndDate],
				[Investment_Ammount],
				[Revenue_Percentage],
				[Payment_Interval],
				[Project_Accepted],
				[Investor_Accepted],
				[Mutually_Accepted],
				[Active]
			)
			(
				SELECT
				@Investor_ID,
				@Project_ID,
				GETDATE(),
				@Performance_BeginDate,
				@Performance_EndDate,
				@Investment_Ammount,
				@Revenue_Percentage,
				1,
				'FALSE',
				'FALSE',
				'FALSE',
				'FALSE'
			);
			SET @New_Proc_ID = SCOPE_IDENTITY();
		COMMIT TRAN Create_Proc_Entry
		SELECT @New_Proc_ID;
		RETURN 0
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @err_msg VARCHAR(MAX) = CONCAT('PROC_Create, ', ERROR_MESSAGE());

		RAISERROR (@err_msg, 16, 1);

		RETURN
	END CATCH
END
