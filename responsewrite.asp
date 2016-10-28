<!--#include file ="Init.asp"-->
<%
BROWSERNUMBER = Request("BROWSERNUMBER")
refnum = Request("refnum")
stepnum = Request("stepnum")
levelnum = Request("levelnum")

if Request.QueryString("curpage") = "" then
	curpage = 1
else
	curpage = CInt(Request.QueryString("curpage"))
end if

set dbcon = server.createobject("adodb.connection")
    dbcon.open DBConString
set dbrec = server.createobject("adodb.recordset")
    dbrec.CursorType = 1

'----- 데이타조회
SQL = " select * from TB_BROWSERBOARD               " & vbcrlf & _
      "  where BROWSERNUMBER = "& BROWSERNUMBER &"  " & vbcrlf & _
      "    and stepnum = "& stepnum &"              " & vbcrlf & _
      "    and levelnum = "& levelnum &"            "  
dbrec.open SQL, dbcon

BROWSERNUMBER	= DbRec("BROWSERNUMBER")
ID		= DbRec("ID")
NAME	= DbRec("NAME")
TITLE	= DbRec("TITLE")
DETAIL	= DbRec("DETAIL")
CREATEDDATE	= DbRec("CREATEDDATE")
READCOUNT = DbRec("READCOUNT")
PASSWORD = dbrec("password")

a = mid(cstr(CREATEDDATE),1,4)
b = mid(cstr(CREATEDDATE),6,2) 
c = mid(cstr(CREATEDDATE),9,2) 

dbrec.Close
Set dbrec = Nothing
dbcon.Close
Set dbcon = Nothing
%>

<html>
<head>
<title>답변쓰기</title>
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

<Script language="JavaScript">
<!--
  function onregist() {
   
    if ( document.form2.NAME.value == "") {
       alert("이름을 입력해 주십시요");
       return;
    }   
    if ( document.form2.EMAIL.value == "") {
       alert("E메일을 입력해 주십시요");
       return;
    }     
    if ( document.form2.TITLE.value == "") {
       alert("제목을 입력해 주십시요");
       return;
    }   
   
    if ( document.form2.PASSWORD.value == "") {
       alert("패스워드를 입력해 주십시요");
       return;
    }   
    if ( document.form2.DETAIL.value == "") {
       alert("내용을을 입력해 주십시요");
       return;
    } 
    
        document.form2.submit();
  }
//-->
</script>

<script language="JavaScript">
<!--
function check() 
{
         if(document.searchform.keyword.value.length==0)
        {
          alert('검색어를 입력하세요');
          return false;   
        }
              
        document.searchform.submit();
        return false;
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
  <table width="750" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
    <br>
    <td width="601" valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="8"></td>
            <td width="601"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                    <td width="573" bgcolor="#E2EDF6"> 
                    <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center">
                      <FORM name="searchform" action="List.asp"  method=post >
                      <tr> 
                        <td width="21%">
                          <div align="right"><b><font color="F04E23">검색</font></b></div>
                        </td>
                        <td width="34%" valign="top"> 
                          <input type="text" name="keyword" size="20">
                        </td>
                        <td width="21%" valign="bottom"> 
                         <select name="target">
                            <option selected value="TITLE" >::제목::</option>
                            <option value="NAME" >::이름::</option>
                            <option value="DETAIL">::내용::</option>
                            <option value="BROWSERNUMBER" >::번호::</option>
                          </select>
                        </td>
                        <td width="24%" valign="middle">
  <input src="image/search.gif" type="image" onclick="return check();" align="absbottom" border="0"  id=image1 name=image1> 
                        </td>
                      </tr>
                      </FORM>
                      </table>
                  </td>
                 
                </tr>
              </table>
            </td>
          </tr>         
          <tr> 
            <td width="8">&nbsp;</td>
            <td width="601" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="30"> 
                    <div align="left"><img src="image/icon.gif" border="0"> <b><font color="#051920">답변쓰기</font></b></div>
                  </td>
                </tr>
                <tr> 
                  <td valign="top"> 
<table width="100%"  border=1 borderColorDark=#ffffff borderColorLight=#999999 cellPadding=1 cellSpacing=0  align="center">
                      <tr> 
                        <td align="center" bgcolor="D5D6FF"><b><font color="051920">제목</font></b></td>
                        <td bgcolor="E6E8FF"><%=CharLength (TITLE, 20)%></td>
                        <td align="center" bgcolor="D5D6FF"><b><font color="051920">날짜</font></b></td>
                        <td width="193" bgcolor="E6E8FF"><%=a%> 년 <%=b%> 월 <%=c%> 일</td>
                      </tr>
                      <tr> 
                        <td width="40" align="center" bgcolor="D5D6FF"><b><font color="051920">이름</font></b></td>
                        <td width="160" bgcolor="E6E8FF"><%=name%></td>
                        <td align="center" bgcolor="D5D6FF"><b><font color="051920">조회수</font></b></td>
                        <td width="194" bgcolor="E6E8FF"><%=readcount%></td>
                      </tr>
                      <tr> 
                        <td align="center" bgcolor="D5D6FF" height="118"><b><font color="051920">내용</font></b></td>
                        <td colspan="3" bgcolor="E6E8FF" height="118"> 
                          <pre><%=detail%></pre>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                
                <tr> 
                  <td height="30"> 
                    <img src="image/icon.gif" border="0"> <b><font color="D706B1">답변쓰기</font></b></td>
                </tr>
                <tr> 
                  <td height="30"> 
<table width="100%"  border=1 bordercolordark=#ffffff bordercolorlight=#999999 cellpadding=1  cellspacing=0  align="center" height="174">
<FORM NAME="form2" action="Insert.asp?BROWSERNUMBER=<%=BROWSERNUMBER%>&refnum=<%=refnum%>&stepnum=<%=stepnum%>&levelnum=<%=levelnum%>&curpage=<%=curpage%>" METHOD="POST" > 
<input type="hidden" text="curpage" value="<%=curpage%>" > 
<input type="hidden" text="refnum" value="<%=refnum%>" >
<input type="hidden" text="stepnum" value="<%=stepnum%>" >
<input type="hidden" text="levelnum" value="<%=levelnum%>">
<input type="hidden" text="BROWSERNUMBER" value="<%=BROWSERNUMBER%>" >
                    
                      <tr> 
                        <td align="center" bgcolor="D5D6FF" width="58"><b><font color="051920">이름</font></b></td>
                        <td bgcolor="E6E8FF" width="156"> 
                          <div align="left"> 
                            <input type="text" name="NAME" value="">
                          </div>
                        </td>
                        <td align="center" bgcolor="D5D6FF" width="136"><b><font color="051920">E-mail</font></b></td>
                        <td width="231" bgcolor="E6E8FF"> 
                          <div align="left"> 
                            <input type="text" name="EMAIL">
                          </div>
                        </td>
                      </tr>
                           
                      <tr> 
                        <td width="58" align="center" bgcolor="D5D6FF"><b><font color="051920">제목</font></b></td>
                        <td width="156" bgcolor="E6E8FF"> 
                          <div align="left">
                            <input type="text" name="TITLE">
                          </div>
                        </td>
                        <td align="center" bgcolor="D5D6FF" width="136"><b><font color="051920">비밀번호</font></b></td>
                        <td width="231" bgcolor="E6E8FF"> 
                          <div align="left">
                            <input type="password" name="PASSWORD">
                          </div>
                        </td>
                      </tr>
                                   
                      <tr> 
                        <td align="center" bgcolor="D5D6FF" width="58"><b><font color="051920">답변</font></b></td>
                        <td colspan="3" bgcolor="E6E8FF" valign="top"> 
                          <p align="left"> 
                            <textarea name="DETAIL" cols="50" rows="10" wrap="VIRTUAL"></textarea>
                            <br>
                          </p>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td height="30"> 
                    <div align="center"><b><font color="333333"> 
                     <a href="List.asp?CURPAGE=<%=CURPAGE%>"> <img src="image/list.gif" border="0"></a>
                     <a href="JavaScript:onregist()"><img src="image/reg.gif" border="0"></a></font></b></div>
                  </td>
                </tr>
 <tr><td ><img src="image/line.gif" ></td></tr>
 <tr><td ><div align="center">테스트 게시판</div ></td></tr>
              </table>
              </form>
            </td>
          </tr>
        </table>
      </td>
  </tr>
</table>
</body>
</html>
