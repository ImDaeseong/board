<!--#include file ="Init.asp"-->
<%

BROWSERNUMBER = Request("BROWSERNUMBER")
curpage = Request("curpage")
REFNUM = Request ("REFNUM")
STEPNUM = Request ("STEPNUM")
LEVELNUM = Request ("LEVELNUM")

set dbcon = server.createobject("adodb.connection")
    dbcon.open DBConString
set dbrec = server.createobject("adodb.recordset")
    dbrec.CursorType = 1

SQL = " select *                                     " & vbcrlf & _
      "   from TB_BROWSERBOARD                       " & vbcrlf & _
      "  where BROWSERNUMBER = "& BROWSERNUMBER &"   "
dbrec.open SQL, dbcon

if dbrec("password") <> Request.Form("password") then
%>
<html><head><title>비밀번호가 이상합니다</title>
<script>
window.alert('비밀번호가 이상합니다')  
history.go (-2)
</script>
</head>
<body></body>
</html>
<%
else

SQL = " delete from TB_BROWSERBOARD                      " & vbcrlf & _ 
      "       where BROWSERNUMBER = "& BROWSERNUMBER &"  " 
dbcon.Execute(SQL)

end if

dbrec.Close
Set dbrec = Nothing
dbcon.Close
Set dbcon = Nothing

Response.Redirect "list.asp?CURPAGE=" & CURPAGE 

%>

