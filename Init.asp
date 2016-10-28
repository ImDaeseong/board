<%
const DBConString = "Provider=SQLOLEDB;Data Source=127.0.0.1;Initial Catalog=Dbname;User ID=id;Password=pwd"
%>

<%
	Function CharLength (Text, Length)
		Dim cnt,tempLength

		CharLength = Text
		
		for cnt = 1 to len(Text)
			if asc(mid(Text,cnt,1)) < 0 then
				tempLength = tempLength + 2
			else
				tempLength = tempLength + 1
			end if
			
			if tempLength > Length then
				CharLength = left(Text,cnt) & ".."
				exit for
			end if
		next
	End Function
%>    