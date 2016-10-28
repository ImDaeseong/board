<!--#include file ="Init.asp"-->
<%
Response.Expires = 0 

const LinePerPage=10
'---- CursorTypeEnum Values ----
Const adOpenForwardOnly = 0
Const adOpenKeyset = 1
Const adOpenDynamic = 2
Const adOpenStatic = 3

'---- LockTypeEnum Values ----
Const adLockReadOnly = 1
Const adLockPessimistic = 2
Const adLockOptimistic = 3
Const adLockBatchOptimistic = 4
 
'--------답변
REFNUM = Request("REFNUM")
STEPNUM = Request("STEPNUM")
LEVELNUM = Request("LEVELNUM")

'----- 찾기
DKEYWORD = Request.form("keyword")
if DKEYWORD <> "" then
  target = Request.form("target")
end if
if DKEYWORD = "" then 
  DKEYWORD = Request.QueryString("keyword")
end if

Set dbcon = server.createobject("adodb.connection")
    dbcon.open DBConString
Set dbrec = server.createobject("adodb.recordset")
    dbrec.CursorType = 1

SQL = " select  count(*)        " & vbcrlf & _ 
      "   from TB_BROWSERBOARD  " 
Set dbrec =dbcon.Execute(SQL)
cnt=dbrec(0)
   
dbrec.Close 

'---------검색 유무
if dkeyword = "" then
SQL = " select                                                       " & vbcrlf & _  
      "         BROWSERNUMBER                                        " & vbcrlf & _
      "       , ID                                                   " & vbcrlf & _
      "       , PASSWORD                                             " & vbcrlf & _
      "       , EMAIL                                                " & vbcrlf & _
      "       , NAME                                                 " & vbcrlf & _
      "       , TITLE                                                " & vbcrlf & _
      "       , DETAIL                                               " & vbcrlf & _
      "       , READCOUNT                                            " & vbcrlf & _
      "       , convert(char(16),CREATEDDATE,20) as recdate          " & vbcrlf & _
      "       , REFNUM                                               " & vbcrlf & _
      "       , STEPNUM                                              " & vbcrlf & _
      "       , LEVELNUM                                             " & vbcrlf & _
      "   from TB_BROWSERBOARD                                       " & vbcrlf & _ 
      "  order by REFNUM desc, STEPNUM asc  "
else

SQL = " select                                                       " & vbcrlf & _  
      "         BROWSERNUMBER                                        " & vbcrlf & _
      "       , ID                                                   " & vbcrlf & _
      "       , PASSWORD                                             " & vbcrlf & _
      "       , EMAIL                                                " & vbcrlf & _
      "       , NAME                                                 " & vbcrlf & _
      "       , TITLE                                                " & vbcrlf & _
      "       , DETAIL                                               " & vbcrlf & _
      "       , READCOUNT                                            " & vbcrlf & _
      "       , convert(char(16),CREATEDDATE,20) as recdate          " & vbcrlf & _
      "       , REFNUM                                               " & vbcrlf & _
      "       , STEPNUM                                              " & vbcrlf & _
      "       , LEVELNUM                                             " & vbcrlf & _
      "   from TB_BROWSERBOARD                                       " & vbcrlf & _ 
      "  where "& target &" LIKE '%" & dkeyword &  "%' order by BROWSERNUMBER  desc " & vbcrlf & _   
      "       ,STEPNUM,LEVELNUM,REFNUM  "                                 

end if

dbrec.Open SQL,Dbcon,adOpenKeyset ,adLockReadOnly 

total_page=(cnt-1)\LinePerPage+1

if ( dbrec.BOF = True and dbrec.EOF = True)  then
else
	dbrec.PageSize  = LinePerPage

	dcurpage = Request("curpage") 
	if dcurpage <> "" Then
		curPage = dcurpage
   	  if curPage < 1 Then 
		curPage = 1
	  end if
	else
		curPage = 1
		dcurpage=1
	end if
	dbrec.AbsolutePage = curpage
end if
%>

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
<html>
<head>
<title>목록</title>
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
            <td width="601" bgcolor=#FFFBFF> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                   <td width="573" bgcolor="#E2EDF6"> 
                    <table width="80%"  border="0" cellspacing="0" cellpadding="0" align="center">
                     <FORM name="searchform" action="List.asp"  method=post >
                     <tr> 
                        <td width="21%"><div align="right"><b><font color="F04E23">검색</font></b></div></td>
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
 <td>
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
            <td width="591">&nbsp;</td>
          </tr>
          <tr> 
            <td width="8">&nbsp;</td>
            <td width="601" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="30"> 
                    <div align="left"><img src="image/icon.gif" border="0"> <b><font color="#051920">목록</font></b></div>
                  </td>
                </tr>
                <tr> 
                    <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="2" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" align="center">
                            <tr align="center"> 
                              <td width="53" bgcolor="D5D6FF"><b><font color="#051920">번호</font></b></td>
                              <td width="267" bgcolor="D5D6FF"><b><font color="#051920">제목</font></b></td>
                              <td width="95" bgcolor="D5D6FF"><b><font color="#051920">이름</font></b></td>
                              <td width="105" bgcolor="D5D6FF"><b><font color="#051920">날짜 
                                </font></b></td>
                              <td width="53" bgcolor="D5D6FF"><font color="#051920"><b>조회수</b> 
                                </font></td>
                            </tr>
<%
  RowCount = dbrec.PageSize 
  Do While Not dbrec.EOF  and rowcount > 0 
%>
<% 	
   for i=1 to dbrec.PageSize  
       	
    refnum = dbrec("refnum")
    stepnum = dbrec("stepnum")
    levelnum = dbrec("levelnum")
    refmark = ""
          	
    if levelnum >0 and dkeyword="" then
          for j=1 to levelnum
              refmark = refmark + "&nbsp;&nbsp;"
          next
    refmark = refmark + "<font size=1 color=black> <img src='image/icon_reply.gif' border=0></font><font size='-1' color='darkviolet'>Re:</font>&nbsp;"
    else
    refmark = ""
    end if
          	  
    title=refmark + dbrec("title")     
    titlelen =len(refmark) + 20
          	  
    if len(title) >= titlelen then
       title = left(title,titlelen -3) & "..."
    end if         	 
%>
<%if levelnum <> 0 then
   	      BROWSERNUMBER =""
      else
   	      BROWSERNUMBER = dbrec("BROWSERNUMBER")
      end if
%>     
<%
 yymmdd = dbrec("recdate")
 strNew = ""
 if datediff ("h",yymmdd,Now()) < 24 then 
    strNew = "<img src='image/new.gif' border=0 >"
 end if	
%>	
     
<% if i mod 2 = 0 then %>
<tr bgcolor="#FFFBFF">
<% else %> 
<tr bgcolor="E6E8FF">
<% end if %>
 
 <td align="center"  width="53"><%=BROWSERNUMBER%></td>
 
 <td align="left"  width="267">
 <a href=Read.asp?BROWSERNUMBER=<%=dbrec("BROWSERNUMBER")%>&curpage=<%=dcurpage%>><%=TITLE%><%=strNew%></a></td>
 
 <td align="center"  width="95"><%=DbRec("NAME")%></td>
 
 <td width="105" align="center"> 
 <%=mid(cstr(dbrec("recdate")),6,2)%>/<%=mid(cstr(dbrec("recdate")),9,2)%>&nbsp;<%=right(cstr(dbrec("recdate")),5)%></td>

 <td width="53" align="center" ><%=dbrec("READCOUNT")%></td>
 </tr>
<%	
  RowCount = RowCount - 1
  dbrec.MoveNext
		
  if dbrec.EOF then
  exit for
  end if
                         
  next
  Loop
%>              </table>
                        </td>
                      </tr>
                     
                    </table>
                  </td>
                </tr>
             <tr> 
<td height="30"> 
<div align="center">
<%
intNumOfPage=10

intStart=((curPage-1) \ intNumOfPage)*intNumOfPage + 1
intEnd	=(((curPage-1) + intNumOfPage) \ intNumOfPage ) * intNumOfPage

IF total_page <= intEnd THEN
	intEnd=total_page
END IF
%>
<font size="-1">

<% IF cint(curPage) > cint(intNumOfPage) THEN %>

<a href="list.asp?curpage=1">[1]</a>
<a href="list.asp?curpage=<%=intStart-intNumOfPage%>">[이전<%=intNumOfPage%>개]</a>
<% END IF %>

<% FOR i= intStart TO intEnd %>
	<% if i = int(curPage) then %>
		<b>[<font color="red"><%=i%></font>]</b>
	<% else %>
		[<a href="list.asp?curpage=<%=i%>"><%=i%></a>]
	<% end if%>
<% NEXT %>

<% IF cint(total_page) > cint(intEnd) Then %>
<a href="list.asp?curpage=<%=intEnd+1%>">[다음<%=intNumOfPage%>개]</a>
<a href="list.asp?curpage=<%=total_page%>">[<%= total_page %>]</a>
<% End IF %>

<a href="Write.asp?curpage=<%=CURPAGE%>"><img src="image/write.gif" border="0" align="absbottom"></a>

</div >
</td>
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