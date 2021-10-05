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
positionName = request("positionName")
positionTypeID = request("positionTypeID")


if sType = "add" then
	on error resume next
	if id>0 then    'update
		sql="update positions set positionTypeID="&positionTypeID&",positionName='"&positionName&"' where id="&id
		conn.execute(sql)
		if err.number=0 then
			response.write "{success:true,msg:3}"
		else
			response.write "{success:false,msg:4}"
		end if
	else
		sql="insert into positions ([positionTypeID],[positionName]) values ("&positionTypeID&",'"&positionName&"')"
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
	  	sql="delete from positions where id=" & arrvalue(i)
		conn.execute(sql)
    next
    
elseif sType = "update" then
else
end if


conn.close

%>