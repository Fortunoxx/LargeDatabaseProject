
create procedure p_test_2
as 
begin
	select *
	from TabA t
	join TabA_hist1 h on h.name = t.name -- join should fail with different datatypes
end
