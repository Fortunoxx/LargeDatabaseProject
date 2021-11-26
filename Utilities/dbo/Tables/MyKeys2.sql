CREATE TABLE [dbo].[MyKeys2] (
    [KeyId]       INT            IDENTITY (1, 1) NOT NULL,
    [KeyTypeId]   INT            NOT NULL,
    [KeyValue]    NVARCHAR (256) NOT NULL,
    [ParentKeyId] INT            NULL,
    PRIMARY KEY CLUSTERED ([KeyId] ASC),
    CONSTRAINT [FK_MyKeys2_MyKeys2] FOREIGN KEY ([ParentKeyId]) REFERENCES [dbo].[MyKeys2] ([KeyId]),
    CONSTRAINT [FK_MyKeys2_MyKeyTypes] FOREIGN KEY ([KeyTypeId]) REFERENCES [dbo].[MyKeyTypes] ([KeyTypeId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_UQ_Type_Value_Parent]
    ON [dbo].[MyKeys2]([KeyTypeId] ASC, [KeyValue] ASC, [ParentKeyId] ASC);

