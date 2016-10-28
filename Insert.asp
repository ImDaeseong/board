<!--#include file ="Init.asp"-->
<%
TITLE = replace(trim(Request("TITLE")),"'","''")
NAME = replace(trim(Request("NAME")),"'","''")
PASSWORD = replace(trim(Request("PASSWORD")),"'","''")
DETAIL = replace(trim(Request("DETAIL")),"'","''")
EMAIL = replace(trim(request("EMAIL")),"'","''")

'BROWSERNUMBER = Request("BROWSERNUMBER")
CURPAGE = Request("curpage")
REFNUM = Request("REFNUM")
STEPNUM = Request("STEPNUM")
LEVELNUM = Request("LEVELNUM")

set dbcon = server.createobject("adodb.connection")
    dbcon.open DBConString
set dbrec = server.createobject("adodb.recordset")
    dbrec.CursorType = 1

SQL = " select max(BROWSERNUMBER)  " & vbcrlf & _ 
      "   from TB_BROWSERBOARD     " 
dbrec.Open SQL,dbcon

if IsNull(dbrec(0)) then
BROWSERNUMBER = 1
else
BROWSERNUMBER = dbrec(0) + 1
end if

if request("BROWSERNUMBER") <>"" then

SQL= " update TB_BROWSERBOARD          " & vbcrlf & _
     "    set STEPNUM = STEPNUM + 1    " & vbcrlf & _
     "  where REFNUM = "& REFNUM &"    " & vbcrlf & _
     "    and STEPNUM > "& STEPNUM &"  "
dbcon.Execute (SQL)

STEPNUM = STEMPNUM + 1
LEVELNUM = LEVELNUM + 1
else
REFNUM = BROWSERNUMBER
STEPNUM = 0
LEVELNUM = 0
end if

'Response.Write "aa" & BROWSERNUMBER  & "<br>"
'Response.Write "aa" & curpage & "<br>"
'Response.Write REFNUM  & "<br>"
'Response.Write STEPNUM  & "<br>"
'Response.Write LEVELNUM  & "<br>"
'Response.Write TITLE & "<br>"
'Response.Write NAME  & "<br>"
'Response.Write PASSWORD & "<br>"
'Response.Write DETAIL  & "<br>"
'Response.Write EMAIL  & "<br>"
'Response.End

SQL = " insert into  TB_BROWSERBOARD       " & vbcrlf & _
      "           (   BROWSERNUMBER        " & vbcrlf & _
      "             , ID                   " & vbcrlf & _  
      "             , PASSWORD             " & vbcrlf & _ 
      "             , EMAIL                " & vbcrlf & _
      "             , NAME                 " & vbcrlf & _ 
      "             , TITLE                " & vbcrlf & _  
      "             , CREATEDDATE          " & vbcrlf & _
      "             , READCOUNT            " & vbcrlf & _  
      "             , DETAIL               " & vbcrlf & _ 
      "             , REFNUM               " & vbcrlf & _
      "             , STEPNUM              " & vbcrlf & _ 
      "             , LEVELNUM )           " & vbcrlf & _                
	  "      values ( "& BROWSERNUMBER  &" " & vbcrlf & _
	  "             , '"& ID   &"'         " & vbcrlf & _ 
	  "             , '"& PASSWORD &"'     " & vbcrlf & _
	  "             , '"& EMAIL   & "'     " & vbcrlf & _
	  "             , '"& NAME  &"'        " & vbcrlf & _
	  "             , '"& TITLE &"'        " & vbcrlf & _
	  "             , getdate(),0          " & vbcrlf & _
	  "             , '"&  DETAIL &"'      " & vbcrlf & _
	  "             , "& REFNUM  &"        " & vbcrlf & _
	  "             , "& STEPNUM &"        " & vbcrlf & _ 
	  "             , "& LEVELNUM &" )     "
dbcon.execute(SQL)

dbrec.Close
Set dbrec = Nothing
dbcon.Close
Set dbcon = Nothing
%>

<html>
<body onload="onback()">
<script language="javascript">
function onback() {
document.location ="List.asp?curpage=<%=curpage%>";
}
</script>
</body>
</html> 



