<%
CURPAGE = Request.QueryString("curpage")
%>
<html>
<head>
<title>�۾���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type="text/css">
<!--
a:link {  color: #333333; text-decoration: none; }
a:visited {  color: #333333; text-decoration: none;}
a:active {  text-decoration: none; color: #0000FF;}
a:hover {  text-decoration: none; color: #0000FF;}
INPUT {  font-family: "����"; font-size: 9pt; color: #333333; }
td {  font-family: "����"; font-size: 9pt; color: #000000;}
-->
</style>

<Script language="JavaScript">
<!--
  function onregist() {
  
    if ( document.form2.NAME.value == "") {
       alert("�̸��� �Է��� �ֽʽÿ�");
       return;
    }   
    if ( document.form2.EMAIL.value == "") {
       alert("�����ּҸ� �Է��� �ֽʽÿ�");
       return;
    }     
    if ( document.form2.TITLE.value == "") {
       alert("������ �Է��� �ֽʽÿ�");
       return;
    }   
    if ( document.form2.PASSWORD.value == "") {
       alert("�н����带 �Է��� �ֽʽÿ�");
       return;
    }   
    if ( document.form2.DETAIL.value == "") {
       alert("�������� �Է��� �ֽʽÿ�");
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
          alert('�˻�� �Է��ϼ���');
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
                        <td width="21%"><div align=right><b><font color="F04E23"> �˻�</font></b></div></td>
                        <td width="34%" valign="top"> 
                          <input type="text" name="keyword" size="20">
                        </td>
                        <td width="21%" valign="bottom"> 
                          <select name="target">
                            <option selected value="TITLE" >::����::</option>
                            <option value="NAME" >::�̸�::</option>
                            <option value="DETAIL">::����::</option>
                            <option value="BROWSERNUMBER" >::��ȣ::</option>
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
                    <div align="left"><img src="image/icon.gif" border="0"> <b><font color="#051920">�۾���</font></b></div>
                  </td>
                </tr>
<tr> 
<td valign="top"> 
<table width="100%"  border=1 borderColorDark=#ffffff  borderColorLight=#999999 cellPadding=1 cellSpacing=0  align="center" height="174">
<FORM NAME="form2" action="Insert.asp" METHOD="POST" > 
<input type="hidden" text="curpage" value="<%=curpage%>"> 
                      <tr> 
                        <td align="center" bgcolor="D5D6FF" width="58"><b><font color="051920">�̸�</font></b></td>
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
                        <td width="58" align="center" bgcolor="D5D6FF"><b><font color="051920">����</font></b></td>
                        <td width="156" bgcolor="E6E8FF"> 
                          <div align="left">
                            <input type="text" name="TITLE">
                          </div>
                        </td>
                        <td align="center" bgcolor="D5D6FF" width="136"><b><font color="051920">��й�ȣ</font></b></td>
                        <td width="231" bgcolor="E6E8FF"> 
                          <div align="left">
                            <input type="password" name="PASSWORD">
                          </div>
                        </td>
                      </tr>
                      <tr> 
                        <td align="center" bgcolor="D5D6FF" width="58"><b><font color="051920">����</font></b></td>
                        <td colspan="3" bgcolor="E6E8FF" valign="top"> 
                          <p align="left"> 
                            <textarea name="DETAIL" cols="50" rows="20" wrap="VIRTUAL"></textarea>
                            <br>
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
                      <a href="List.asp?curpage=<%=curpage%>"><img src="image/list.gif" border="0"></a> <a href="JavaScript:onregist()"><img src="image/reg.gif" border="0"></a>  </font></b></div>
                  </td>
                </tr>
                </form>
<tr><td ><img src="image/line.gif" ></td></tr>
<tr><td ><div align="center">�׽�Ʈ �Խ���</div ></td></tr>
         </table>
            </td>
          </tr>
      </table>
      </td>
  </tr>
</table>
</body>
</html>
