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

employee_name = trim(request("employee_name"))
employee_role = trim(request("employee_role"))
employee_tel = trim(request("employee_tel"))
employee_sex = trim(request("employee_sex"))
'salesPhone = trim(request("salesPhone"))
'owenArea = request("owenArea")


if sType = "add" then
	on error resume next
	if id>0 then    'update
		sql="update employee set employee_name='"&employee_name&"',employee_role='"&employee_role&"',employee_sex='"&employee_sex&"',employee_tel='"&employee_tel&"' where id="&id
		conn.execute(sql)
		if err.number=0 then
			response.write "{success:true,msg:3}"
		else
			response.write "{success:false,msg:4}"
		end if
	else
		sql="insert into employee ([employee_name],[employee_role],[employee_tel],[employee_sex]) values ('"&employee_name&"','"&employee_role&"','"&employee_tel&"','"&employee_sex&"')"
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
	  	sql="delete from employee where id=" & arrvalue(i)
		conn.execute(sql)
    next
    
elseif sType = "update" then
else
end if


conn.close

%>