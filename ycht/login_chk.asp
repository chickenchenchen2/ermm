<%
'Session.CodePage=936
'Response.Charset="gb2312"

Session.CodePage=65001
Response.Charset="utf-8"

Dim conn,rs
Set conn=Server.CreateObject("ADODB.Connection")
Set rs=Server.CreateObject("ADODB.RecordSet")
'sql="select * from user where userName='"&request.Form("username")&"'"
conn.Open "Driver={Microsoft Access Driver (*.mdb)}; DBQ="+server.mappath("data.mdb")
'sql="select count(*) from user where userName='"&request.Form("username")&"'"
sql="select * from userInfo where username='"&request.Form("username")&"'"

rs.open sql,conn,1,1
if rs.eof then 
'response.Write"{success:false,message:'��¼ʧ��!��������ʺŻ����벻��ȷ!'}"
response.Write "<script>alert(""��¼ʧ��!��������û��������벻��ȷ!�����µ�¼"");location.href='login.asp';</script>"
else
userName=trim(request.Form("username"))
password=request.Form("userpass")
loginType=request.Form("loginType")

if password=rs("password") then 
	session("login")="ok"
	session("admin")=rs("userName")
	session("p")=rs("p")
	session("permission")=rs("permission")
	
	if session("permission") = 1 then
		if loginType = "����" then
			response.Write "<script>location.href='admin.asp';</script>"
		else
			response.Write "<script>location.href='search.asp';</script>"
		end if
	else
		response.Write "<script>location.href='search.asp';</script>"
	end if

'response.Redirect("manage.asp")
else
'response.Write "{success:false,message:'��¼ʧ��!����������벻��ȷ!'}"
response.Write "<script>alert(""��¼ʧ��!��������û��������벻��ȷ!�����µ�¼"");location.href='login.asp';</script>"

'response.Write"��ҳΪ����Աר��ҳ��"
end if

end if
%>