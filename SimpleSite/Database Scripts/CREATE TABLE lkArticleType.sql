USE [Blissgig]
GO

/****** Object:  Table [dbo].[lkArticleType]    Script Date: 05/04/2010 14:04:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[lkArticleType](
	[ArticleIdent] [int] NOT NULL,
	[TypeIdent] [int] NOT NULL,
 CONSTRAINT [PK_lkArticleTypes] PRIMARY KEY CLUSTERED 
(
	[ArticleIdent] ASC,
	[TypeIdent] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[lkArticleType]  WITH CHECK ADD  CONSTRAINT [FK_lkArticleType_tbArticle] FOREIGN KEY([ArticleIdent])
REFERENCES [dbo].[tbArticle] ([Ident])
GO

ALTER TABLE [dbo].[lkArticleType] CHECK CONSTRAINT [FK_lkArticleType_tbArticle]
GO

ALTER TABLE [dbo].[lkArticleType]  WITH CHECK ADD  CONSTRAINT [FK_lkArticleType_tbArticleType] FOREIGN KEY([TypeIdent])
REFERENCES [dbo].[tbArticleType] ([Ident])
GO

ALTER TABLE [dbo].[lkArticleType] CHECK CONSTRAINT [FK_lkArticleType_tbArticleType]
GO

