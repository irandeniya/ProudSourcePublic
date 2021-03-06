USE [ProudSourceAccounting]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 5/17/2016 11:23:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[Account_ID] [int] IDENTITY(1,1) NOT NULL,
	[Profile_Account_ID] [int] NOT NULL,
	[Profile_Type_ID] [int] NOT NULL,
	[Date_Opened] [datetime] NOT NULL,
	[Date_Closed] [datetime] NULL,
	[Current_Balance] [money] NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[Account_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category_Types]    Script Date: 5/17/2016 11:23:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Category_Types](
	[Category_ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Category_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Currency_Types]    Script Date: 5/17/2016 11:23:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Currency_Types](
	[Currency_Type_ID] [int] IDENTITY(1,1) NOT NULL,
	[Currency] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Currency_Types] PRIMARY KEY CLUSTERED 
(
	[Currency_Type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_Types]    Script Date: 5/17/2016 11:23:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Profile_Types](
	[Profile_Type_ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](300) NOT NULL,
 CONSTRAINT [PK_Profile_Type_ID] PRIMARY KEY CLUSTERED 
(
	[Profile_Type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Transaction_Types]    Script Date: 5/17/2016 11:23:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Transaction_Types](
	[Transaction_Type_ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_Transaction_Types] PRIMARY KEY CLUSTERED 
(
	[Transaction_Type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 5/17/2016 11:23:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Transactions](
	[Transaction_ID] [int] IDENTITY(1,1) NOT NULL,
	[Account_ID] [int] NOT NULL,
	[Category_Type_ID] [int] NOT NULL,
	[Transaction_Type_ID] [int] NOT NULL,
	[Currency_Type_ID] [int] NOT NULL,
	[Date_of_Transaction] [datetime] NOT NULL,
	[Description] [varchar](8000) NOT NULL,
	[Amount] [money] NOT NULL,
	[Current_Balance] [money] NULL,
	[src_account_ID] [int] NULL,
	[Transaction_State] [varchar](250) NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Transactions] ADD [Outside_Transaction_ID] [varchar](250) NULL
ALTER TABLE [dbo].[Transactions] ADD [Outside_Financial_Platform] [varchar](250) NULL
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[Transaction_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_Profile_Types] FOREIGN KEY([Profile_Type_ID])
REFERENCES [dbo].[Profile_Types] ([Profile_Type_ID])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_Profile_Types]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Accounts] FOREIGN KEY([Account_ID])
REFERENCES [dbo].[Accounts] ([Account_ID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Accounts]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Category_Types] FOREIGN KEY([Category_Type_ID])
REFERENCES [dbo].[Category_Types] ([Category_ID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Category_Types]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Currency_Types] FOREIGN KEY([Currency_Type_ID])
REFERENCES [dbo].[Currency_Types] ([Currency_Type_ID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Currency_Types]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Transaction_Types] FOREIGN KEY([Transaction_Type_ID])
REFERENCES [dbo].[Transaction_Types] ([Transaction_Type_ID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Transaction_Types]
GO
/****** Object:  StoredProcedure [dbo].[sp_Create_Financial_Account]    Script Date: 5/17/2016 11:23:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Create_Financial_Account] 
	-- Add the parameters for the stored procedure here
	@profile_account_id INT,
	@profile_type_id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRY
		
		BEGIN TRAN Create_Account

			DECLARE @new_account_ID INT;

			INSERT INTO Accounts
			(
				[Profile_Account_ID],
				[Profile_Type_ID],
				[Date_Opened]
			)
			VALUES
			(
				@profile_account_id,
				@profile_type_id,
				GETDATE()
			)

			SET @new_account_ID = SCOPE_IDENTITY();

			SELECT @new_account_ID

		COMMIT TRAN Create_Account
		RETURN

	END TRY

	BEGIN CATCH
		
		ROLLBACK TRAN

		DECLARE @err_msg VARCHAR(MAX) = CONCAT('sp_Create_Financial_Account, ', ERROR_MESSAGE());

		RAISERROR (@err_msg, 16, 1);

		RETURN

	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[sp_get_FinancialAccountDetails]    Script Date: 5/17/2016 11:23:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Herzon Flores
-- Create date: 5/15/2016
-- Description:	This procedure procures data neccesray to show the user thier financial holdings
-- =============================================
CREATE PROCEDURE [dbo].[sp_get_FinancialAccountDetails] 
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

GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Financial_Transaction]    Script Date: 5/17/2016 11:23:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Herzon Flores
-- Create date: 2/25/2016
-- Description:	Will insert a new financial transaction record with a state of pending
-- =============================================
CREATE PROCEDURE [dbo].[sp_Insert_Financial_Transaction] 
	-- Add the parameters for the stored procedure here
	@Account_ID INT,
	@Category_Type_ID INT,
	@Transaction_Type_ID INT,
	@Amount MONEY,
	@Currency_Type_ID INT,
	@Src_Account_ID INT,
	@ThirdParty_Transaction_ID VARCHAR(250),
	@Financial_Platform VARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRY
		
		BEGIN TRAN New_Transaction

			IF(@Account_ID IS NULL OR @Account_ID = 0)
			BEGIN

				RAISERROR ('sp_Insert_Financial_Transaction, @Account_ID is unacceptable', -1, -1);

			END

			IF(@Category_Type_ID IS NULL OR @Category_Type_ID = 0)
			BEGIN

				RAISERROR ('sp_Insert_Financial_Transaction, @Category_Type_ID is unacceptable', -1, -1);

			END

			IF(@Transaction_Type_ID IS NULL OR @Transaction_Type_ID = 0)
			BEGIN

				RAISERROR ('sp_Insert_Financial_Transaction, @Transaction_Type_ID  is unacceptable', -1, -1);

			END

			IF(@Currency_Type_ID IS NULL OR @Currency_Type_ID = 0)
			BEGIN

				RAISERROR ('sp_Insert_Financial_Transaction, @Currency_Type_ID is unacceptable', -1, -1);

			END

			IF(@Amount IS NULL OR @Account_ID = 0)
			BEGIN

				RAISERROR ('sp_Insert_Financial_Transaction, @Amount is unacceptable', -1, -1);

			END

			-- We need to get the description based on the category of this transaction
			DECLARE @category_description AS VARCHAR(250) = (SELECT [Description] FROM Category_Types WHERE [Category_ID] = @Category_Type_ID)

			-- We need to get the description based on the transaction type
			DECLARE @transaction_description AS VARCHAR(250) = (SELECT [Description] FROM Transaction_Types WHERE [Transaction_Type_ID] = @Transaction_Type_ID)

			-- Control flow based on whether this transaction originated from an internal account.
			IF(@Src_Account_ID IS NULL OR @Src_Account_ID = 0)
			BEGIN

				INSERT INTO Transactions
				(
					[Account_ID],
					[Category_Type_ID],
					[Transaction_Type_ID],
					[Date_of_Transaction],
					[Description],
					[Amount],
					[Current_Balance],
					[Transaction_State],
					[Currency_Type_ID],
					[Outside_Transaction_ID],
					[Outside_Financial_Platform]
				)
				VALUES 
				(
					@Account_ID,
					@Category_Type_ID,
					@Transaction_Type_ID ,
					GETDATE(),
					CONCAT(@category_description, ' : ', @transaction_description, ' : ', (SELECT GETDATE() AS VARCHAR)),
					@Amount,
					(
						SELECT SUM([Amount]) 
						FROM Transactions 
						WHERE [Account_ID] = @Account_ID 
						AND [Transaction_State] = 'PROCESSED'
					),
					'PENDING',
					@Currency_Type_ID,
					@ThirdParty_Transaction_ID,
					@Financial_Platform

				)

				SELECT SCOPE_IDENTITY();

			END
			-- If it did record it in this record so we can keep track of all internal movements
			ELSE
			BEGIN

				INSERT INTO Transactions 
				(
					[Account_ID],
					[Category_Type_ID],
					[Transaction_Type_ID],
					[Date_of_Transaction],
					[Description],
					[Amount],
					[Current_Balance],
					[src_account_ID],
					[Transaction_State],
					[Currency_Type_ID]
				)
				VALUES 
				(
					@Account_ID,
					@Category_Type_ID,
					@Transaction_Type_ID ,
					GETDATE(),
					CONCAT(@category_description, ' : ', @transaction_description, ' : ', (SELECT GETDATE() AS VARCHAR)),
					@Amount,
					(
						SELECT SUM([Amount]) 
						FROM Transactions 
						WHERE [Account_ID] = @Account_ID 
						AND [Transaction_State] = 'Processed'
					),
					@Src_Account_ID,
					'PENDING',
					@Currency_Type_ID
				)

				SELECT SCOPE_IDENTITY();
			END

		COMMIT TRAN New_Transaction
		RETURN

	END TRY

	BEGIN CATCH

		ROLLBACK TRAN

		DECLARE @err_msg VARCHAR(MAX) = ERROR_MESSAGE();

		RAISERROR (@err_msg, 16, 1);

		RETURN

	END CATCH
END

GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 5/17/2016 11:23:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [rds_deny_backups_trigger] ON DATABASE WITH EXECUTE AS 'dbo' FOR
 ADD_ROLE_MEMBER, GRANT_DATABASE AS BEGIN
   SET NOCOUNT ON;
   SET ANSI_PADDING ON;
 
   DECLARE @data xml;
   DECLARE @user sysname;
   DECLARE @role sysname;
   DECLARE @type sysname;
   DECLARE @sql NVARCHAR(MAX);
   DECLARE @permissions TABLE(name sysname PRIMARY KEY);
   
   SELECT @data = EVENTDATA();
   SELECT @type = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'sysname');
    
   IF @type = 'ADD_ROLE_MEMBER' BEGIN
      SELECT @user = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'),
       @role = @data.value('(/EVENT_INSTANCE/RoleName)[1]', 'sysname');

      IF @role IN ('db_owner', 'db_backupoperator') BEGIN
         SELECT @sql = 'DENY BACKUP DATABASE, BACKUP LOG TO ' + QUOTENAME(@user);
         EXEC(@sql);
      END
   END ELSE IF @type = 'GRANT_DATABASE' BEGIN
      INSERT INTO @permissions(name)
      SELECT Permission.value('(text())[1]', 'sysname') FROM
       @data.nodes('/EVENT_INSTANCE/Permissions/Permission')
      AS DatabasePermissions(Permission);
      
      IF EXISTS (SELECT * FROM @permissions WHERE name IN ('BACKUP DATABASE',
       'BACKUP LOG'))
         RAISERROR('Cannot grant backup database or backup log', 15, 1) WITH LOG;       
   END
END


GO
ENABLE TRIGGER [rds_deny_backups_trigger] ON DATABASE
GO
