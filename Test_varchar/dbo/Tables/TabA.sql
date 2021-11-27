CREATE TABLE [dbo].[TabA] (
    [id]   TINYINT       IDENTITY (1, 1) NOT NULL,
    [name] VARCHAR (256) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO

create trigger tg_TabA_del1 on TabA 
AFTER DELETE 
as begin
	insert into TabA_hist1 (id, name)
	select id, name from deleted
end

GO

create trigger tg_TabA_del2 on TabA 
AFTER DELETE 
as begin
	insert into TabA_hist2 
	select id, name from deleted
end
