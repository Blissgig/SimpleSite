USE [Blissgig]
GO

/****** Object:  StoredProcedure [dbo].[spSaveArticle]    Script Date: 07/13/2010 11:20:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spSaveArticle]
	@iIdent			int,  -- This value equals zero, then add new record, else update existing
	@sTitle			varchar(50),
	@sBody			text,
	@dCreateDate	datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @iIdent = 0
		BEGIN
			INSERT INTO tbArticle (Title, Body, CreateDate, Hits)
				VALUES (@sTitle, @sBody, @dCreateDate, 1)
				
			SELECT @iIdent = @@IDENTITY
			INSERT INTO lkArticleType (ArticleIdent, TypeIdent) VALUES (@iIdent, 1)
		END
	ELSE
		BEGIN
			UPDATE tbArticle SET
				Title = @sTitle,
				Body = @sBody,
				CreateDate = @dCreateDate
				WHERE Ident = @iIdent
		END	
END

GO

