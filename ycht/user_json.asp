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
sql="select * from userInfo where username='"&request("username")&"'"

rs.open sql,conn,1,1
if rs.eof then 
'response.Write"{success:false,message:'登录失败!你输入的帐号或密码不正确!'}"
response.Write "{success:false,msg:1}"
else
userName=trim(request("username"))
password=request("userpass")

if password=rs("password") then 
	response.Write "{success:true,msg:3}"
	
	

'response.Redirect("manage.asp")
else
'response.Write "{success:false,message:'登录失败!你输入的密码不正确!'}"
response.Write "{success:false,msg:2}"
'response.Write"本页为管理员专用页面"
end if

end if
%>