
create procedure p_test_3
as 
begin
	declare @table table (id tinyint, name varchar(256))
	insert into @table
	exec p_test_1 -- insert should fail with different datatypes
end
