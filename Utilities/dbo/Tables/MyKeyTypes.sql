CREATE TABLE [dbo].[MyKeyTypes] (
    [KeyTypeId]   INT            IDENTITY (1, 1) NOT NULL,
    [ShortName]   VARCHAR (16)   NOT NULL,
    [Description] NVARCHAR (256) NOT NULL,
    [HasKey2]     BIT            CONSTRAINT [DF_MyKeyTypes_HasKey2] DEFAULT ((0)) NOT NULL,
    [HasKey3]     BIT            CONSTRAINT [DF_MyKeyTypes_HasKey3] DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([KeyTypeId] ASC)
);

