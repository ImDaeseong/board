<!--#include file ="Init.asp"-->

<%
NAME = replace(trim(Request("NAME")),"'","''")
EMAIL = replace(trim(request("EMAIL")),"'","''")
TITLE = replace(trim(Request("TITLE")),"'","''")
PASSWORD = replace(trim(Request("PASSWORD")),"'","''")
DETAIL = replace(trim(Request("DETAIL")),"'","''")

BROWSERNUMBER = Request("BROWSERNUMBER")
CURPAGE = Request("curpage")
REFNUM = Request("REFNUM")
STEPNUM = Request("STEPNUM")
LEVELNUM = Request("LEVELNUM")

set dbcon = server.createobject("adodb.connection")
    dbcon.open DBConString
set dbrec = server.createobject("adodb.recordset")
    dbrec.CursorType = 1

SQL = " select PASSWORD                             " & vbcrlf & _  
      "   from TB_BROWSERBOARD                      " & vbcrlf & _ 
      "  where BROWSERNUMBER = "& BROWSERNUMBER &"    "
dbrec.Open SQL,dbcon

if dbrec("password") <> Request("password") then
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
SQL = " update TB_BROWSERBOARD                      " & vbcrlf & _
      "    set TITLE = '"& TITLE &"'                " & vbcrlf & _ 
      "       , DETAIL    = '"& DETAIL &"'      " & vbcrlf & _
      "  where BROWSERNUMBER = "& BROWSERNUMBER &"      " 
dbcon.execute(SQL)

Response.Redirect "list.asp?curpage=" & curpage 

end if

dbcon.Close
set dbcon=Nothing
%>


