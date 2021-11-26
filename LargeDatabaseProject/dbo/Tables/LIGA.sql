CREATE TABLE [dbo].[LIGA] (
    [ID_Liga]              INT           IDENTITY (1, 1) NOT NULL,
    [Verband]              VARCHAR (100) NULL,
    [Erstaustragung]       DATE          NULL,
    [Rekordspieler]        VARCHAR (255) NULL,
    [Rekordspieler_Spiele] INT           NULL,
    [Aktueller_Spieltag]   TINYINT       NULL,
    CONSTRAINT [PK_LIGA] PRIMARY KEY CLUSTERED ([ID_Liga] ASC)
);

