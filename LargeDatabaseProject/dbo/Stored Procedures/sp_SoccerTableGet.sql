
create procedure sp_SoccerTableGet 
(
	@id_liga smallint
	, @hinrunde bit = null
	, @rueckrunde bit = null
	, @customStartDay smallint = null
	, @customEndDay smallint = null
)
as 
begin

	declare @start smallint, @end smallint
	set @start = 1
	set @end = 128

	if (@customStartDay is not null and @customEndDay is not null)
		select @start = @customStartDay, @end = @customEndDay
	else begin
		if @hinrunde = convert(bit,0)
			select @start = count(*) from dbo.VEREIN where ID_Liga = @id_liga -- start ist dann das erste spiel der rückrunde, d.h. bei 18 mannschaften das 18. spiel

		if @rueckrunde = convert(bit,0)
			select @end = count(*) - 1 from dbo.VEREIN where ID_Liga = @id_liga
	end

	--select @start, @end

	-- use temp table for data type clarity
	declare @tmp table (
		Position smallint not null,
		ID tinyint not null,
		Name varchar(255) not null,
		ImageUrl varchar(max) null,
		Played smallint not null,
		Won_Home smallint not null,
		Won_Away smallint not null,
		Drawn_Home smallint not null,
		Drawn_Away smallint not null,
		Lost_Home smallint not null,
		Lost_Away smallint not null,
		Points_Home smallint not null,
		Points_Away smallint not null,
		Goals_For_Home smallint not null,
		Goals_For_Away smallint not null,
		Goals_Against_Home smallint not null,
		Goals_Against_Away smallint not null,
		Goal_Diff smallint not null
	)

	insert into @tmp
	select 
		rank() over (order by heim.Punkte + gast.Punkte desc, heim.Goals_For + gast.Goals_For - heim.Goals_Against - gast.Goals_Against desc, heim.Goals_For + gast.Goals_For desc) as Position
		, v.ID_Verein as ID, v.Name, v.Image_URL, heim.Played + gast.Played as [Played]
		--, heim.Won + gast.Won as [Won]
		, heim.Won as [Won_Home]
		, gast.Won as [Won_Away]
		, heim.Drawn as [Drawn_Home]
		, gast.Drawn as [Drawn_Away]
		, heim.Lost as [Lost_Home]
		, gast.Lost as [Lost_Away]
		, heim.Punkte as [Points_Home]
		, gast.Punkte as [Points_Away]
		, heim.Goals_For as [Goals_For_Home]
		, gast.Goals_For as [Goals_For_Away]
		, heim.Goals_Against as [Goals_Against_Home]
		, gast.Goals_Against as [Goals_Against_Away]
		--, heim.Drawn + gast.Drawn as [Drawn]
		--, heim.Lost + gast.Lost as [Lost]
		--, heim.Punkte, gast.Punkte
		--, heim.Punkte + gast.Punkte as [Points]
		--, heim.Goals_For + gast.Goals_For as [Goals_For]
		--, heim.Goals_Against + gast.Goals_Against as [Goals_Against]
		, heim.Goals_For + gast.Goals_For - heim.Goals_Against - gast.Goals_Against as [Goal_Diff]
	from dbo.VEREIN v 
	join dbo.LIGA l on l.ID_Liga = v.ID_Liga
	left join (
		select SUM(Punkte) as [Punkte], Name, ID_Verein, sum(Goals_For) as Goals_For, sum(Goals_Against) as Goals_Against, sum(Gewonnen) as [Won], sum(Unentschieden) as [Drawn], sum(Verloren) as [Lost], count(*) as [Played] from (
			select v.Name, v.ID_Verein, Tore_Heim as Goals_For, Tore_Gast as Goals_Against
				, Punkte = case when Tore_Heim > Tore_Gast then 3 when Tore_Heim = Tore_Gast then 1 else 0 end
				, Gewonnen = case when Tore_Heim > Tore_Gast then 1 else 0 end
				, Unentschieden = case when Tore_Heim = Tore_Gast then 1 else 0 end
				, Verloren = case when Tore_Heim < Tore_Gast then 1 else 0 end
			from dbo.SPIEL s
			join dbo.VEREIN v on v.ID_Verein = s.ID_Verein_Heim
			join dbo.LIGA l on l.ID_Liga = v.ID_Liga 
			where s.Spieltag >= @start and s.Spieltag <= @end
			and datediff(second, s.Uhrzeit, '00:00:00') <> 0
			and datediff(day, s.Datum, getdate()) > 0
		) as heim
		group by heim.Name, heim.ID_Verein
	) as heim on heim.ID_Verein = v.ID_Verein
	left join (
		select SUM(Punkte) as [Punkte], Name, ID_Verein, sum(Goals_For) as Goals_For, sum(Goals_Against) as Goals_Against, sum(Gewonnen) as [Won], sum(Unentschieden) as [Drawn], sum(Verloren) as [Lost], count(*) as [Played] from (
			select v.Name, v.ID_Verein, Tore_Gast as Goals_For, Tore_Heim as Goals_Against
				, Punkte = case when Tore_Gast > Tore_Heim then 3 when Tore_Heim = Tore_Gast then 1 else 0 end
				, Gewonnen = case when Tore_Gast > Tore_Heim then 1 else 0 end
				, Unentschieden = case when Tore_Heim = Tore_Gast then 1 else 0 end
				, Verloren = case when Tore_Gast < Tore_Heim then 1 else 0 end
			from dbo.SPIEL s
			join dbo.VEREIN v on v.ID_Verein = s.ID_Verein_Gast
			join dbo.LIGA l on l.ID_Liga = v.ID_Liga 
			where s.Spieltag >= @start and s.Spieltag <= @end
			and datediff(second, s.Uhrzeit, '00:00:00') <> 0
			and datediff(day, s.Datum, getdate()) > 0
		) as gast
		group by gast.Name, gast.ID_Verein
	) as gast on gast.ID_Verein = v.ID_Verein
	where l.ID_Liga = @id_liga

	select * from @tmp order by (Points_Away + Points_Home) desc, Goal_Diff desc
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[sp_SoccerTableGet] TO PUBLIC
    AS [dbo];

