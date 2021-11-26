
create view [dbo].[v_ResourceCache] as
SELECT [Id]
      ,[Value]
      ,[ExpiresAtTime]
      ,[SlidingExpirationInSeconds]
      ,[AbsoluteExpiration]
  FROM [$(Utilities)].[dbo].[ResourceCache]