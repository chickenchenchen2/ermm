<%@ codepage=65001%>
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

salesName = trim(request("salesName"))
positionID = trim(request("positionID"))
departmentID = trim(request("departmentID"))
superiorID = trim(request("superiorID"))
salesPhone = trim(request("salesPhone"))
salesAddress = request("salesAddress")
owenArea = request("owenArea")


if sType = "add" then
	on error resume next
	set rsp= server.createobject("adodb.recordset")
	set rsd= server.createobject("adodb.recordset")
	pSql = "select id from positions where positionName = '" & positionID & "'"
	rsp.open pSql,conn,1,1
	positionID = rsp("id")
	dSql = "select id from department where departmentName = '" & departmentID & "'"
	rsd.open dSql,conn,1,1
	departmentID = rsd("id")
	
	if id>0 then    'update
		sql="update sale set salesName='"&salesName&"',positionID="&positionID&",departmentID="&departmentID&",superiorID='"&superiorID&"',salesPhone='"&salesPhone&"',salesAddress='"&salesAddress&"',owenArea='"&owenArea&"' where id="&id
		conn.execute(sql)
		if err.number=0 then
			response.write "{success:true,msg:3}"
		else
			response.write "{success:false,msg:4}"
		end if
	else
		sql="insert into sale ([salesName],[positionID],[departmentID],[superiorID],[salesPhone],[salesAddress],[owenArea]) values ('"&salesName&"',"&positionID&","&departmentID&",'"&superiorID&"','"&salesPhone&"','"&salesAddress&"','"&owenArea&"')"
		conn.execute(sql)
		if err.number=0 then
			response.write "{success:true,msg:0}"
		else
			response.write "{success:true,msg:1}"
		end if
	end if
elseif sType = "del" then
	arrvalue=split(id,",")
    for i=0 to ubound(arrvalue)
      	on error resume next
	  	sql="delete from sale where id=" & arrvalue(i)
		conn.execute(sql)
    next
    
else
end if

conn.close

%>