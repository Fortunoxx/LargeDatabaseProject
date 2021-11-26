
/****** Skript für SelectTopNRows-Befehl aus SSMS ******/
CREATE view [dbo].[v_Verein] as
SELECT [ID_Verein]
      ,[Name]
      ,[ID_Liga]
      ,[Image_URL]
  FROM [dbo].[VEREIN]