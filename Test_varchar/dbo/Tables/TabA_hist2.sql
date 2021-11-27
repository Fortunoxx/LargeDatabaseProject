CREATE TABLE [dbo].[TabA_hist2] (
    [hist_id] TINYINT       IDENTITY (1, 1) NOT NULL,
    [id]      TINYINT       NOT NULL,
    [name]    VARCHAR (256) NULL,
    PRIMARY KEY CLUSTERED ([hist_id] ASC)
);

