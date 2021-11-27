
create procedure p_test_1 
(
	@name varchar(256)
)
as 
begin
	select *
	from TabA where name = @name -- where should fail with different datatypes
end
