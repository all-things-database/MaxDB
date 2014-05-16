﻿create function [fn].[StringToList] (@String varchar(8000), @Delimiter char(1))
returns @List table ( StringValue varchar(128) )
as
begin
 
    declare @TrimmedString varchar(8000)
 
    set @TrimmedString = ltrim(rtrim(@String))
 
    ;with _String (StartPos, EndPos)
    as
    (
        select 
			1 as StartPos, 
			charindex(@Delimiter, @TrimmedString + @Delimiter) as EndPos
        union all
        select 
			EndPos + 1 as StartPos, 
			charindex(@Delimiter, @TrimmedString + @Delimiter , EndPos + 1) as EndPos
        from _String
        where charindex(@Delimiter, @TrimmedString + @Delimiter, EndPos + 1) <> 0
    )
 
    insert @List
    select substring(@trimmedString, StartPos, EndPos - StartPos)
    from _String
    where len(ltrim(rtrim(substring(@trimmedString, StartPos, EndPos - StartPos)))) > 0
    option (MaxRecursion 8000);
 
    return

end


