<!--#include file ="Init.asp"-->
<%
Response.Expires = 0
	
BROWSERNUMBER = Request("BROWSERNUMBER")
curpage = Request("curpage")

set dbcon = server.createobject("adodb.connection")
    dbcon.open DBConString
set dbrec = server.createobject("adodb.recordset")
    dbrec.CursorType = 1

SQL = " select DETAIL,REFNUM,STEPNUM,LEVELNUM        " & vbcrlf & _ 
      "   from TB_BROWSERBOARD                       " & vbcrlf & _ 
      "  where BROWSERNUMBER = "& BROWSERNUMBER &"   "
dbrec.Open SQL,dbcon

DETAIL = dbrec("DETAIL")
REFNUM = dbrec("REFNUM")
STEPNUM = dbrec("STEPNUM")
LEVELNUM =dbrec("LEVELNUM")

dbrec.Close 
Set dbrec = Nothing
%>

<script language="javascript">
<!--
function send(form) {
if (form.password.value == "") {
alert("\볶朱橘廢８� 입력해 주세요");
document.inputform.password.focus();
return; }
form.submit();
}
-->
</script>

<html>
<head>
<title>삭제</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type="text/css">
<!--
a:link {  color: #333333; text-decoration: none; }
a:visited {  color: #333333; text-decoration: none;}
a:active {  text-decoration: none; color: #0000FF;}
a:hover {  text-decoration: none; color: #0000FF;}
INPUT {  font-family: "굴림"; font-size: 9pt; color: #333333; }
td {  font-family: "굴림"; font-size: 9pt; color: #000000;}
-->
</style>
</head>
<body bgcolor="#FFFFFF">
  <table width="750" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
 <td width="601" valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="8">&nbsp;</td>
            <td width="601" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">                
                <tr> 
                  <td height="30"> 
                    <div align="left"><img src="image/icon.gif" border="0"> <b><font color="#051920">삭제</font></b></div>
                  </td>
                </tr>
                <tr> 
                  <td valign="top"> 
  <table width="100%"  border=1 borderColorDark=#ffffff  borderColorLight=#999999 cellPadding=1 cellSpacing=0  align="center">
                      <tr> 
                      <td colspan="4" bgcolor="E6E8FF" height="118"> 
                      <pre><%=DETAIL%></pre></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <div align="center"><img src="image/Blank.gif" width="1" height="20"><b><font color="333333"> 
                     위의 글을 정말 삭제 하시겠습니까?
<%
SQL = " select *                                    " & vbcrlf & _                   
      "   from TB_BROWSERBOARD                      " & vbcrlf & _ 
      "  where BROWSERNUMBER > "& BROWSERNUMBER &"  " & vbcrlf & _ 
      "    and  REFNUM = "& REFNUM &"               "
Set dbrec=dbcon.Execute (SQL)

if not dbrec.EOF  then
%>            
<HTML>
<HEAD></HEAD>
<BODY OnLoad="open();">
<script language="JavaScript">
function open()
		{
		alert("답변 글이 있습니다.");
		history.back();
		}
</script>
</BODY>
</HTML>
<%Response.End %>
                  
<% else%>
<form method="post" action="Deleteok.asp?BROWSERNUMBER=<%=BROWSERNUMBER%>&curpage=<%=curpage%>&refnum=<%=refnum%>&stepnum=<%=stepnum%>&levelnum=<%=levelnum%>" name="inputform">
<input type=hidden text=REFNUM value=<%=REFNUM%> >
<input type=hidden text=STEPNUM value=<%=STEPNUM%> >
<input type=hidden text=LEVELNUM value=<%=LEVELNUM%> >                          
비밀번호&nbsp;&nbsp;<input type="password" name="password">
<input type="image" src="image/del.gif" value="삭제하기" onclick="send(this.form)"> 
</form>
<%end if%>    

</font></b></div>
</td>
<%
dbcon.Close
Set dbcon = Nothing
%>                      
</tr>         
<tr><td ><img src="image/line.gif" ></td></tr>
<tr><td ><div align="center">테스트 게시판</div ></td></tr>
         </table>
            </td>
          </tr>
        </table>
      </td>
  </tr>
</table>
</body>
</html>
