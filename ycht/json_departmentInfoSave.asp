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
departmentName = request("departmentName")
leibieType=request("leibieType")
owenAreaId=request("owenAreaId")
departmentTypeName=request("departmentTypeName")
departmentTypeID = owenAreaId



if sType = "add" then
	'on error resume next
	
	if Cint(leibieType) = 1 then
		
		if id>0 then    'update
			sql="update department set departmentTypeID=0,departmentName='"&departmentName&"' where id="&id
			'response.write sql
			conn.execute(sql)
			if err.number=0 then
				response.write "{success:true,msg:3}"
			else
				response.write "{success:false,msg:4}"
			end if
		else
			sql="insert into department ([departmentTypeID],[departmentName]) values (0,'"&departmentName&"')"
			conn.execute(sql)
			if err.number=0 then
				response.write "{success:true,msg:0}"
			else
				response.write "{success:false,msg:1}"
			end if
		end if
	end if
	
	if Cint(leibieType) = 2 then
		
		if id>0 then    'update
			sql="update department2 set departmentTypeID="&departmentTypeID&",departmentTypeName='"&departmentTypeName&"',departmentName='"&departmentName&"' where id="&id
			conn.execute(sql)
			if err.number=0 then
				response.write "{success:true,msg:3}"
			else
				response.write "{success:false,msg:4}"
			end if
		else
			sql="insert into department2 ([departmentTypeID],[departmentTypeName],[departmentName]) values ("&departmentTypeID&",'"&departmentTypeName&"','"&departmentName&"')"
			'response.write sql
			conn.execute(sql)
			if err.number=0 then
				response.write "{success:true,msg:0}"
			else
				response.write "{success:false,msg:1}"
			end if
		end if
	end if
	
	if Cint(leibieType) = 3 then
		if id>0 then    'update
			sql="update department3 set departmentTypeID="&departmentTypeID&",departmentTypeName='"&departmentTypeName&"',departmentName='"&departmentName&"' where id="&id
			conn.execute(sql)
			if err.number=0 then
				response.write "{success:true,msg:3}"
			else
				response.write "{success:false,msg:4}"
			end if
		else
			sql="insert into department3 ([departmentTypeID],[departmentTypeName],[departmentName]) values ("&departmentTypeID&",'"&departmentTypeName&"','"&departmentName&"')"
			'response.write sql
			conn.execute(sql)
			if err.number=0 then
				response.write "{success:true,msg:0}"
			else
				response.write "{success:false,msg:1}"
			end if
		end if
	end if
	
elseif sType = "del" then
	arrvalue=split(id,",")
    for i=0 to ubound(arrvalue)
      	'on error resume next
		if Cint(leibieType) = 1 then
			sql1="delete from department where id=" & arrvalue(i)
			conn.execute(sql1)
			
			
			set rs= server.createobject("adodb.recordset")
			sqlstr = "select * from department2 where departmentTypeID=" & arrvalue(i)
			rs.open sqlstr,conn,1,1
			if rs.RecordCount <> 0 then
				Do while not rs.eof or rs.bof
					sql3="delete from department3 where departmentTypeID=" & rs("id")
					conn.execute(sql3)
					rs.movenext
				loop
			else
				
			end if
			
			sql2="delete from department2 where departmentTypeID=" & arrvalue(i)
			conn.execute(sql2)
		end if
		
		if Cint(leibieType) = 2 then
			sql1="delete from department2 where id=" & arrvalue(i)
			conn.execute(sql1)
			sql2="delete from department3 where departmentTypeID=" & arrvalue(i)
			conn.execute(sql2)
		end if
		
		if Cint(leibieType) = 3 then
			sql="delete from department3 where id=" & arrvalue(i)
			conn.execute(sql)
		end if
    next
    
elseif sType = "update" then
else
end if

conn.close

%>