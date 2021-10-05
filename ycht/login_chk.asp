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
'response.Write"{success:false,message:'登录失败!你输入的帐号或密码不正确!'}"
response.Write "<script>alert(""登录失败!您输入的用户名或密码不正确!请重新登录"");location.href='login.asp';</script>"
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
		if loginType = "管理" then
			response.Write "<script>location.href='admin.asp';</script>"
		else
			response.Write "<script>location.href='search.asp';</script>"
		end if
	else
		response.Write "<script>location.href='search.asp';</script>"
	end if

'response.Redirect("manage.asp")
else
'response.Write "{success:false,message:'登录失败!你输入的密码不正确!'}"
response.Write "<script>alert(""登录失败!您输入的用户名或密码不正确!请重新登录"");location.href='login.asp';</script>"

'response.Write"本页为管理员专用页面"
end if

end if
%>