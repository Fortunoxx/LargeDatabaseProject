CREATE TABLE [dbo].[SPIELER] (
    [ID_Spieler] INT           IDENTITY (1, 1) NOT NULL,
    [ID_Verein]  INT           NOT NULL,
    [Trikot_Nr]  INT           NOT NULL,
    [Name]       VARCHAR (255) NOT NULL,
    [Land]       VARCHAR (100) NULL,
    [Spiele]     INT           NULL,
    [Vorlagen]   INT           NULL,
    [Tore]       INT           NULL,
    CONSTRAINT [PK_SPIELER] PRIMARY KEY CLUSTERED ([ID_Spieler] ASC),
    CONSTRAINT [FK_SPIELER_VEREIN] FOREIGN KEY ([ID_Verein]) REFERENCES [dbo].[VEREIN] ([ID_Verein])
);

