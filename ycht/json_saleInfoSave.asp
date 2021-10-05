<%@ codepage=65001%>
<!-- #include file="conn.asp" -->
<%
Session.CodePage=65001
Response.Charset="utf-8"

sType = request("sType")

id=request("id")
name = request("name")
positionID = request("positionID")
departmentID = request("departmentID")
superiorID = request("superiorID")
phone = request("phone")
owenArea = request("owenArea")


if sType = "add" then
	on error resume next
	sql="insert into sale ([name],[positionID],[departmentID],[superiorID],[phone],[OwenArea]) values ('"&name&"',"&positionID&","&departmentID&","&superiorID&",'"&phone&"','"&owenArea&"')"
	conn.execute(sql)

elseif sType = "del" then
	arrvalue=split(id,",")
    for i=0 to ubound(arrvalue)
      	on error resume next
	  	sql="delete from sale where id=" & arrvalue(i)
		conn.execute(sql)
    next
    
elseif sType = "update" then
	on error resume next
	sql="update sale set name='"&name&"',positionID="&positionID&",departmentID="&departmentID&",superiorID="&superiorID&",phone='"&phone&"',owenArea='"&owenArea&"' where id="&id
	conn.execute(sql)
else
end if

if err.number=0 then
	response.write "{success:true,msg:0}"
else
'response.write err.description
	response.write "{success:true,msg:2}"
end if
conn.close

%>