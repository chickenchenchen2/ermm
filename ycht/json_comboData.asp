<%@ codepage=65001%>
<!-- #include file="conn.asp" -->
<%
Session.CodePage=65001
Response.Charset="utf-8"

dim shangJiName
sType=request("sType")

if sType = "area" then
	sqlstr = "select * from saleAreaLv1"
elseif sType = "position" then
	sqlstr = "select * from positions"
elseif sType = "department" then
	sqlstr = "select * from department"
elseif sType = "superior" then
	
end if

set rs= server.createobject("adodb.recordset")
rs.open sqlstr,conn,1,1

returnStr = ""
if rs.RecordCount <> 0 then
	Do while not rs.eof or rs.bof
	if sType = "area" then
		returnStr = returnStr & ""&rs("id")&","&rs("name")&"|"
	elseif sType = "position" then
		returnStr = returnStr & ""&rs("id")&","&rs("positionName")&"|"
	elseif sType = "department" then
		returnStr = returnStr & ""&rs("id")&","&rs("departmentName")&"|"
	elseif sType = "superior" then
		'returnStr = returnStr & ""&rs("id")&","&rs("name")&"|"
	else
		'returnStr = returnStr & ""&rs("id")&","&rs("name")&"|"
	end if
		rs.movenext
	loop
	'去掉最后一个逗号
	returnStr = left(returnStr,len(returnStr)-1)
else
	returnStr = "[-1,'无']"
end if
response.Write(returnStr)

%>