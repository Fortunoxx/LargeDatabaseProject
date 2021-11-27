CREATE TABLE [dbo].[TabA_hist1] (
    [hist_id]   TINYINT       IDENTITY (1, 1) NOT NULL,
    [id]        TINYINT       NOT NULL,
    [name]      VARCHAR (256) NULL,
    [store_dat] DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([hist_id] ASC)
);

