<%
set conn=server.createobject("adodb.connection")
connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("data.mdb")
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("test.mdb")
conn.open connstr
%>

<%
'������excel
Set rs = Server.CreateObject("ADODB.RecordSet")
sqlstr="select * from projectData" '��������Ĳ�ѯ���
rs.open sqlstr,conn,1,3
%>
<%
Set fs = server.CreateObject("scripting.filesystemobject")
'--�������������ɵ�EXCEL�ļ������µĴ��
filename="excel.xls"
temp=filename
filename=Request.ServerVariables("APPL_PHYSICAL_PATH")&"\"+filename
'--���ԭ����EXCEL�ļ����ڵĻ�ɾ����
'if fs.FileExists(filename) then
'fs.DeleteFile(filename)
'end if

'Response.write(Server.MapPath(temp))

'--����EXCEL�ļ�
set myfile = fs.CreateTextFile(Server.MapPath(temp),true)
dim strLine,responsestr
strLine=""
For each x in rs.fields
	if x.name = "id" then
		row = "����"
	elseif x.name = "objectName" then
		row = "��Ŀ����"
	elseif x.name = "startTime" then
		row = "��ʼʱ��"
	elseif x.name = "endTime" then
		row = "����ʱ��"
	elseif x.name = "lng" then
		row = "��Ŀλ�þ���"
	elseif x.name = "lat" then
		row = "��Ŀλ��γ��"
	elseif x.name = "projectPrincipal" then
		row = "��Ŀ������"
	elseif x.name = "belongToBranch" then
		row = "�����ֹ�˾"
	elseif x.name = "iconColor" then
		row = "ͼ��"
	elseif x.name = "info" then
		row = "��ע"
	end if
	if x.name <> "v1" then
		strLine= strLine & row & chr(9)
	end if
	'strLine= strLine & x.name & chr(9)
Next
'--�����������д��EXCEL
myfile.writeline strLine
while not rs.eof
	strLine=""
	for each x in rs.Fields
		if x.name <> "v1" then
			strLine= strLine & x.value & chr(9)
		end if
	next
	'--���������д��EXCEL
	myfile.writeline strLine
	rs.movenext
wend
response.redirect "excel.xls"
'link="<A HREF=\" & temp & " title=�����ݱ�����Eecel����><font color=red><b>����excel�ļ�</b></font></a>"
Response.write link
set myfile = nothing
Set fs=Nothing
rs.close
%>