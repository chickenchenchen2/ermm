<%
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
departmentKeyWord=request("departmentKeyWord")
leibieType=request("leibieType")
owenAreaId=request("owenAreaId")

Response.Charset="utf-8"
set json = new jsonclass
if Cint(leibieType) = 1 then
	if departmentKeyWord="" then
		json.sql="select * from department"
	else
		json.sql = "select * from department where departmentName like '%"+departmentKeyWord+"%'"
	end if
end if

if Cint(leibieType) = 2 then
	if departmentKeyWord="" then
		json.sql="select * from department2 where departmentTypeID = " + owenAreaId
	else
		json.sql = "select * from department2 where departmentName like '%"+departmentKeyWord+"%' and departmentTypeID = " + owenAreaId
	end if
end if

if Cint(leibieType) = 3 then
	if departmentKeyWord="" then
		json.sql="select * from department3 where departmentTypeID = " + owenAreaId
	else
		json.sql = "select * from department3 where departmentName like '%"+departmentKeyWord+"%' and departmentTypeID = " + owenAreaId
	end if
end if


json.root = "department"
'ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
start = cint(request("start"))
limit = cint(request("limit"))
'�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
response.Write((json.getjson(start,limit)))
%>