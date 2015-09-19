USE [Blissgig]
GO

/****** Object:  StoredProcedure [dbo].[spGetArticle]    Script Date: 05/11/2010 10:27:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetArticle]
	@iIdent int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN
		UPDATE tbArticle
			SET Hits = (Hits + 1)
			WHERE Ident = @iIdent
	END
	
	BEGIN
	SELECT Title, Body, CreateDate
		FROM tbArticle
		WHERE Ident = @iIdent
	END	
	
	BEGIN
	SELECT 
		tbArticle.Ident,
		tbArticle.Title
		FROM tbArticle
		INNER JOIN lkArticleType ON tbArticle.Ident = lkArticleType.ArticleIdent
		WHERE lkArticleType.TypeIdent = 1
		ORDER BY tbArticle.Title
	END
END

GO

