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
businessname= request("businessname")
lng=request("lng")
lat=request("lat")
'departmentTypeName=request("departmentTypeName")
'departmentTypeID = owenAreaId




		
		if id>0 then    'update
			sql="update projectData set businessname='"&businessname&"',lng='"&lng&"',lat='"&lat&"', where id="&id
			'response.write sql
			conn.execute(sql)
			if err.number=0 then
				response.write "{success:true,msg:3}"
			else
				response.write "{success:false,msg:4}"
			end if
		else
			sql="insert into projectData(businessname,lng,lat) values ('"&businessname&"',"&lng&"','"&lat&"')"
			conn.execute(sql)
			if err.number=0 then
				response.write "{success:true,msg:0}"
			else
				response.write "{success:false,msg:1}"
			end if
		end if
	
	
	
	


conn.close

%>