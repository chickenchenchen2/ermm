<!-- #include file="conn.asp" -->
<%
Session.CodePage=65001
Response.Charset="utf-8"

sType = request("sType")

if (IsEmpty(request("id")) or request("id")="" ) then
	id=0
else
	id=cint(trim(request("id")))
end if

username=request("username")
password1=request("password")
permission=request("permission")

'p=""
'response.write password1
if sType = "add" then
	'on error resume next
	if id>0 then    'update
		'sql="UPDATE [userInfo] set [username]='"&username&"',[password]='"&password1&"' where id="&id
		if username <> "admin" then
			sql="UPDATE [userInfo] set [username]='"&username&"',[password]='"&password1&"',[p]='0',[permission]='"&permission&"' where id="&id
		else
			sql="UPDATE [userInfo] set [username]='"&username&"',[password]='"&password1&"',[p]='1',[permission]='"&permission&"' where id="&id
		end if

		conn.execute(sql)
		'sql="delete from userInfo where id="&id
		'conn.execute(sql)
		'sql="insert into userInfo ([username],[password],[p]) values ('"&username&"','"&password&"','"&p&"')"
		'conn.execute(sql)
		if err.number=0 then
			response.write "{success:true,msg:3}"
		else
			response.write "{success:false,msg:4}"
		end if
	else
		'if username = "admin" then
		'	response.write "{success:true,msg:1}"
		'else
			sqlstr = "select count(*) as cc from userInfo where username='"&username&"'"
			set rs= server.createobject("adodb.recordset")
			rs.open sqlstr,conn,1,1
			if rs("cc") = 0 then
				
				sql="insert into userInfo ([username],[password],[p],[permission]) values ('"&username&"','"&password1&"','0','"&permission&"')"
				'response.write sql
				conn.execute(sql)
				if err.number=0 then
					response.write "{success:true,msg:0}"
				else
					response.write "{success:true,msg:1}"
				end if
			else
					response.write "{success:true,msg:1}"
			end if
		'end if
	end if
elseif sType = "del" then
'	arrvalue=split(id,",")
'    for i=0 to ubound(arrvalue)
'      	on error resume next
'	  	sql="delete from user where id=" & arrvalue(i)
'		conn.execute(sql)
'    next
    sql="delete from userInfo where id=" & cint(request("id"))
	conn.execute(sql)
else
end if

conn.close

%>