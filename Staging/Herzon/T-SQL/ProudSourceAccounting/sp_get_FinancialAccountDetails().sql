USE [ProudSourceAccounting]
GO
/****** Object:  StoredProcedure [dbo].[sp_get_FinancialAccountDetails]    Script Date: 5/15/2016 7:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Herzon Flores
-- Create date: 5/15/2016
-- Description:	This procedure procures data neccesray to show the user thier financial holdings
-- =============================================
ALTER PROCEDURE [dbo].[sp_get_FinancialAccountDetails] 
	-- Add the parameters for the stored procedure here
	@Account_ID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT T.[Transaction_ID], T.[Amount], T.[Date_of_Transaction], T.[Description], CT.[Currency], T.[Transaction_State]
	FROM Accounts A 
    JOIN Transactions T ON A.[Account_ID] = T.[Account_ID]
    JOIN Currency_Types CT ON T.[Currency_Type_ID] = CT.[Currency_Type_ID]
    WHERE A.[Account_ID] = @Account_ID
		AND T.[Transaction_State] = 'PENDING'

    SELECT T.[Transaction_ID], T.[Amount], T.[Date_of_Transaction], T.[Description], CT.[Currency], T.[Transaction_State]
    FROM Accounts A
    JOIN Transactions T ON A.[Account_ID] = T.[Account_ID]
    JOIN Currency_Types CT ON T.[Currency_Type_ID] = CT.[Currency_Type_ID]
    WHERE A.[Account_ID] = @Account_ID
		AND T.[Transaction_State] <> 'PENDING'
END
