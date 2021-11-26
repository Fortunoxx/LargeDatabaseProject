CREATE TABLE [dbo].[ressources] (
    [id]       INT           IDENTITY (1, 1) NOT NULL,
    [resource] [sysname]     NOT NULL,
    [data_ts]  DATETIME2 (7) DEFAULT (getdate()) NOT NULL,
    [ts]       ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ResourceName]
    ON [dbo].[ressources]([resource] ASC);

