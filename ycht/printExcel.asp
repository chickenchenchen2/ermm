<%
set conn=server.createobject("adodb.connection")
connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("data.mdb")
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("test.mdb")
conn.open connstr
%>

<%
'导出到excel
Set rs = Server.CreateObject("ADODB.RecordSet")
sqlstr="select * from projectData" '这里是你的查询语句
rs.open sqlstr,conn,1,3
%>
<%
Set fs = server.CreateObject("scripting.filesystemobject")
'--假设你想让生成的EXCEL文件做如下的存放
filename="excel.xls"
temp=filename
filename=Request.ServerVariables("APPL_PHYSICAL_PATH")&"\"+filename
'--如果原来的EXCEL文件存在的话删除它
'if fs.FileExists(filename) then
'fs.DeleteFile(filename)
'end if

'Response.write(Server.MapPath(temp))

'--创建EXCEL文件
set myfile = fs.CreateTextFile(Server.MapPath(temp),true)
dim strLine,responsestr
strLine=""
For each x in rs.fields
	if x.name = "id" then
		row = "编码"
	elseif x.name = "objectName" then
		row = "项目名称"
	elseif x.name = "startTime" then
		row = "开始时间"
	elseif x.name = "endTime" then
		row = "竣工时间"
	elseif x.name = "lng" then
		row = "项目位置经度"
	elseif x.name = "lat" then
		row = "项目位置纬度"
	elseif x.name = "projectPrincipal" then
		row = "项目负责人"
	elseif x.name = "belongToBranch" then
		row = "所属分公司"
	elseif x.name = "iconColor" then
		row = "图标"
	elseif x.name = "info" then
		row = "备注"
	end if
	if x.name <> "v1" then
		strLine= strLine & row & chr(9)
	end if
	'strLine= strLine & x.name & chr(9)
Next
'--将表的列名先写入EXCEL
myfile.writeline strLine
while not rs.eof
	strLine=""
	for each x in rs.Fields
		if x.name <> "v1" then
			strLine= strLine & x.value & chr(9)
		end if
	next
	'--将表的数据写入EXCEL
	myfile.writeline strLine
	rs.movenext
wend
response.redirect "excel.xls"
'link="<A HREF=\" & temp & " title=将数据保存至Eecel表中><font color=red><b>导出excel文件</b></font></a>"
Response.write link
set myfile = nothing
Set fs=Nothing
rs.close
%>