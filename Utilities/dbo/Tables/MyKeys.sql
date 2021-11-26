CREATE TABLE [dbo].[MyKeys] (
    [KeyId]     INT            IDENTITY (1, 1) NOT NULL,
    [KeyTypeId] INT            NOT NULL,
    [KeyPart1]  NVARCHAR (256) NOT NULL,
    [KeyPart2]  NVARCHAR (256) NULL,
    [KeyPart3]  NVARCHAR (256) NULL,
    PRIMARY KEY CLUSTERED ([KeyId] ASC),
    CONSTRAINT [FK_MyKeys_MyKeyTypes] FOREIGN KEY ([KeyTypeId]) REFERENCES [dbo].[MyKeyTypes] ([KeyTypeId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_UQ_KeyPart1]
    ON [dbo].[MyKeys]([KeyPart1] ASC) WHERE ([KeyTypeId]=(1));


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_UQ_KeyPart1_2]
    ON [dbo].[MyKeys]([KeyPart1] ASC, [KeyPart2] ASC) WHERE ([KeyTypeId]=(2));


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_UQ_KeyPart1_2_3]
    ON [dbo].[MyKeys]([KeyPart1] ASC, [KeyPart2] ASC, [KeyPart3] ASC) WHERE ([KeyTypeId]=(3));

