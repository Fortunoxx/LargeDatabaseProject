CREATE TABLE [dbo].[VEREIN] (
    [ID_Verein] INT           NOT NULL,
    [Name]      VARCHAR (255) NULL,
    [ID_Liga]   INT           NOT NULL,
    [Image_URL] VARCHAR (MAX) NULL,
    CONSTRAINT [PK_VEREIN] PRIMARY KEY CLUSTERED ([ID_Verein] ASC),
    CONSTRAINT [FK_VEREIN_LIGA] FOREIGN KEY ([ID_Liga]) REFERENCES [dbo].[LIGA] ([ID_Liga])
);


GO
create trigger tg_verein_ins_upd_del 
on verein
for insert, update, delete
as 
declare @tab sysname = 'tg_verein'
if exists(select 1 from ressources where resource = @tab)
	update ressources set data_ts = getdate() where resource = @tab 
else 
	insert into ressources (resource, data_ts) select @tab, getdate()
