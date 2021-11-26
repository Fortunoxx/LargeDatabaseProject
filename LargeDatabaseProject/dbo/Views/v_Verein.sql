/****** Skript für SelectTopNRows-Befehl aus SSMS ******/
create view v_Verein as
SELECT [ID_Verein]
      ,[Name]
      ,[ID_Liga]
      ,[Image_URL]
  FROM [FUSSBALL_BUNDESLIGA_2014_2015].[dbo].[VEREIN]