<!--#include file ="Init.asp"-->
<%
Response.Expires = 0 

REFNUM = Request.QueryString("REFNUM")
STEPNUM = Request.QueryString("STEPNUM")
LEVELNUM = Request.QueryString("LEVELNUM")
BROWSERNUMBER = Request.QueryString("BROWSERNUMBER")
CURPAGE = Request.QueryString("curpage")

set dbcon = server.createobject("adodb.connection")
dbcon.open DBConString
set dbrec = server.createobject("adodb.recordset")
dbrec.CursorType = 1

'----- 이전글
SQL = " select top 1 BROWSERNUMBER as nextnum ,TITLE  " & vbcrlf & _
      "   from TB_BROWSERBOARD                        " & vbcrlf & _
      "  where BROWSERNUMBER > "& BROWSERNUMBER &"    " & vbcrlf & _
      "    and STEPNUM = 0                            " & vbcrlf & _ 
      "    and LEVELNUM = 0  order by 1               "
dbrec.open SQL, dbcon
if dbrec.recordcount > 0 then
  nextnum = dbrec("nextnum")
  nextsubject = dbrec("TITLE")
end if
dbrec.close

'----- 다음글
SQL = " select  top 1 BROWSERNUMBER  as prenum  ,TITLE  " & vbcrlf & _  
      "   from TB_BROWSERBOARD                          " & vbcrlf & _
      "  where BROWSERNUMBER < "& BROWSERNUMBER &"      " & vbcrlf & _
      "    and STEPNUM = 0                              " & vbcrlf & _
      "    and LEVELNUM = 0 order by 1 desc             "
dbrec.open SQL, dbcon
if dbrec.recordcount > 0 then
  prenum = dbrec("prenum")
  presubject = dbrec("TITLE")
end if
dbrec.close

'----- 조회수+1
SQL = " update TB_BROWSERBOARD                        " & vbcrlf & _
      "    set READCOUNT  = READCOUNT  + 1            " & vbcrlf & _   
      "  where BROWSERNUMBER  = "& BROWSERNUMBER  &"  " 
DbCon.Execute(SQL)

'----- 데이타조회
SQL = " select *                                     " & vbcrlf & _
      "   from TB_BROWSERBOARD                       " & vbcrlf & _
      "  where BROWSERNUMBER = "& BROWSERNUMBER &"   "
dbrec.open SQL, dbcon

BROWSERNUMBER = DbRec("BROWSERNUMBER")
ID = DbRec("ID")
NAME = DbRec("NAME")
TITLE = DbRec("TITLE")
DETAIL = DbRec("DETAIL")
READCOUNT = DbRec("READCOUNT")
EMAIL = DbRec("EMAIL")
CREATEDDATE  = DbRec("CREATEDDATE")  

REFNUM = DbRec("REFNUM")
STEPNUM = DbRec("STEPNUM")
LEVELNUM = DbRec("LEVELNUM")


a = mid(cstr(CREATEDDATE),1,4)
b = mid(cstr(CREATEDDATE),6,2) 
c = mid(cstr(CREATEDDATE),9,2) 

DETAIL = replace(DETAIL , "&nbsp;", chr(32))
DETAIL = replace(DETAIL , "&nbsp&nbsp",chr(32)+chr(32))
DETAIL = replace(DETAIL ,"<br>",chr(13))

TITLE = replace(TITLE ,"'","''")
TITLE = replace(TITLE ,"&nbsp;",chr(32))

'레코드가 하나도 없다면
if dbrec.EOF or dbrec.BOF then
NoData=True
else 
NoData=false
end if

'레코드가 있을때 처리
if NoData=false then

'--- 전체자료수 ---**
totrecord = dbrec.recordcount


'--- 총페이지수 ---**
totpage = cint(totrecord/dbrec.PageSize)
if right(cstr(totrecord),1) <> "0" or totrecord = 0 then
  totpage = cint(totpage+1)
end if

'--- page setting ---**
if request.Querystring("curpage") = "" then
  CURPAGE = 1
else 
  CURPAGE = cint(request.Querystring("curpage"))
end if

'--- 지정된 페이지로 레코드의 현재위치를 이동 ---**
if totrecord > 0 then
  dbrec.absolutepage=CURPAGE
end if

end if

dbrec.close
Set dbrec = Nothing
dbcon.Close
Set dbcon = Nothing
%>


<html>
<head>
<title>읽기</title>
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
                   <td width="573" > 
                    <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center">
                 
                      <FORM name="searchform" action="List.asp"  method=post >
                      <tr> 
                        <td width="21%"><div align=right><b><font color="F04E23">검색</font></b></div></td>
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
                        <td width="24%" valign="middle"><input type=submit value="검색"></td>
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
            <td width="591">&nbsp;</td>
          </tr>
          <tr> 
            <td width="8">&nbsp;</td>
            <td width="601"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                 <tr> 
                  <td height="30"> 
                    <div align="left"><img src="image/icon.gif" border="0"> <b><font color="#051920">읽기</font></b></div>
                  </td>
                </tr>
                
                <tr> 
                  <td> 
                    <table width="100%"  border=1 borderColorDark=#ffffff 
                                borderColorLight=#999999 cellPadding=1 
                                cellSpacing=0  align="center">
                      <tr> 
                        <td align="center" bgcolor="D5D6FF"><b><font color="051920">제목</font></b></td>
                        <td bgcolor="E6E8FF"><%=CharLength (TITLE, 20)%></td>
                        <td align="center" bgcolor="D5D6FF"><b><font color="051920">E-메일</font></b></td>
                        <td width="193" bgcolor="E6E8FF"><%=EMAIL%></td>
                      </tr>
                      <tr> 
                        <td width="40" align="center" bgcolor="D5D6FF"><b><font color="051920">날짜</font></b></td>
                        <td width="160" bgcolor="E6E8FF"><%=a%> 년 <%=b%> 월 <%=c%> 일 </td>
                        <td align="center" bgcolor="D5D6FF"><b><font color="051920">조회수</font></b></td>
                        <td width="194" bgcolor="E6E8FF"><%=READCOUNT%></td>
                      </tr>
                      <tr> 
                        <td align="center" bgcolor="D5D6FF"><b><font color="051920">내용</font></b></td>
                        <td colspan="3" bgcolor="E6E8FF"> 
                         <pre><%=DETAIL%></pre>
                        </td>
                      </tr>
                      
<tr bgcolor="E6E8FF"> 
<td colspan="4" height="25"> 
<p align="left"><font size="1">◀ </font>
<% if prenum <> "" then %>	
<A HREF="Read.asp?BROWSERNUMBER=<%=prenum%>&REFNUM=<%=REFNUM%>&STEPNUM=<%=STEPNUM%>&LEVELNUM=<%=LEVELNUM%>&CURPAGE=<%=CURPAGE%>">
이전: <%=presubject %></p></a>
<%elseif prenum < 1 then%>
이전:
<% end if %>	  
</td>
</tr>
        
<tr bgcolor="E6E8FF"> 
<td colspan="4" height="20">
<p align="left"><font size="1">▶</font>
<% if nextnum <> "" then %>	
<A HREF="Read.asp?BROWSERNUMBER=<%=nextnum%>&REFNUM=<%=REFNUM%>&STEPNUM=<%=STEPNUM%>&LEVELNUM=<%=LEVELNUM%>&CURPAGE=<%=CURPAGE%>">
이후: <%=nextsubject %></p></a>
<%elseif nextnum < totpage then %>
이후:
<% end if %>
</td>
</tr>
                 </table>
                  </td>
                </tr>
                <tr> 
                  <td height="30"> 
                    <div align="center"><b><font color="333333"> 
                    <% if prenum <> "" then %> 
                    <A HREF="Read.asp?BROWSERNUMBER=<%=prenum%>&REFNUM=<%=REFNUM%>&STEPNUM=<%=STEPNUM%>&LEVELNUM=<%=LEVELNUM%>&CURPAGE=<%=CURPAGE%>">
                            [이전]</a>
                      <%elseif prenum < 1 then%>
                            [이전]
                      <% end if %>  
                      <% if nextnum <> "" then %>       
                       <A HREF="Read.asp?BROWSERNUMBER=<%=nextnum%>&REFNUM=<%=REFNUM%>&STEPNUM=<%=STEPNUM%>&LEVELNUM=<%=LEVELNUM%>&CURPAGE=<%=CURPAGE%>">
				            [이후]</a>
                      <%elseif nextnum < totpage then %>
                            [이후] 
                      <% end if %>
                   
<a href="List.asp?CURPAGE=<%=CURPAGE%>"> [목록]</a>
<a href="responsewrite.asp?BROWSERNUMBER=<%=BROWSERNUMBER%>&refnum=<%=refnum%>&stepnum=<%=stepnum%>&levelnum=<%=levelnum%>&curpage=<%=CURPAGE%>"> [답변쓰기]</a> 
<a href="modify.asp?refnum=<%=refnum%>&stepnum=<%=stepnum%>&levelnum=<%=levelnum%>&curpage=<%=CURPAGE%>&BROWSERNUMBER=<%=BROWSERNUMBER%>">[수정]</a>
<a href="delete.asp?BROWSERNUMBER=<%=BROWSERNUMBER%>&curpage=<%=CURPAGE%>">[삭제]</a> 
</font></b></div>                  
                   
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
  </tr>
</table>

</body>
</html>
