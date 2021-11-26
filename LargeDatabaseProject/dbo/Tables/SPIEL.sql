CREATE TABLE [dbo].[SPIEL] (
    [ID_Spiel]       INT      IDENTITY (1, 1) NOT NULL,
    [Spieltag]       INT      NOT NULL,
    [Datum]          DATE     NULL,
    [Uhrzeit]        TIME (7) NULL,
    [ID_Verein_Heim] INT      NOT NULL,
    [ID_Verein_Gast] INT      NOT NULL,
    [Tore_Heim]      INT      NOT NULL,
    [Tore_Gast]      INT      NOT NULL,
    CONSTRAINT [PK_SPIEL] PRIMARY KEY CLUSTERED ([ID_Spiel] ASC),
    CONSTRAINT [FK_SPIEL_VEREIN_GAST] FOREIGN KEY ([ID_Verein_Gast]) REFERENCES [dbo].[VEREIN] ([ID_Verein]),
    CONSTRAINT [FK_SPIEL_VEREIN_HEIM] FOREIGN KEY ([ID_Verein_Heim]) REFERENCES [dbo].[VEREIN] ([ID_Verein])
);

