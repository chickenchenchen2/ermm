<!-- #include file=conn.asp -->
<%
Session.CodePage=65001
if (IsEmpty(request("id")) or request("id")="" ) then
	id=0
else
	id=cint(trim(request("id")))
end if
objectName = request("objectName")
startTime = request("startTime")
endTime = request("endTime")
lng = request("lng")
lat = request("lat")
projectPrincipal = request("projectPrincipal")
belongToBranch = request("belongToBranch")
iconColor = request("iconColor")
info = request("info")

if id>0 then
	'rs.open "update [point_admin] set name='"&namea&"',address='"&address&"',lag="&lag&",lat="&lat&",riqi="&riqi&",icon='"&icon&"',file1='"&file1_name&"',type="&type1&",info='"&info&"' where id="&id,conn,1,3
	sql="update [projectData] set objectName='"&objectName&"',startTime='"&startTime&"',endTime='"&endTime&"',lng='"&lng&"',lat='"&lat&"',projectPrincipal='"&projectPrincipal&"',belongToBranch='"&belongToBranch&"',iconColor='"&iconColor&"',info='"&info&"' where id="&id
	
	'response.write sql
	conn.execute(sql)
	if err.number=0 then
		response.write "{success:true,msg:3}"
	else
		response.write "{success:false,msg:4}"
	end if
else
	MaxAID=conn.Execute("select max(ID) from projectData")(0)
	if isnull(MaxAID) or Not IsNumeric(MaxAID) then MaxAID=0
	InfoID=MaxAID+1
	sql="insert into [projectData] (id,objectName,startTime,endTime,lng,lat,projectPrincipal,belongToBranch,iconColor,info,v1) values ('"&InfoID&"','"&objectName&"','"&startTime&"','"&endTime&"','"&lng&"','"&lat&"','"&projectPrincipal&"','"&belongToBranch&"','"&iconColor&"','"&info&"','0')"
	'response.write sql
	conn.execute(sql)
	if err.number=0 then
		response.write "{success:true,msg:0}"
	else
		response.write "{success:false,msg:1}"
	end if
end if
%>