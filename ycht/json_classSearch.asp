<%
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
'projectKeyWord=request("projectKeyWord")
goodstypeId=request("goodstypeId")
'types=request("type")

'�������id
''if (IsEmpty(request("goodstypeId")) or request("goodstypeId")="" ) then
	'goodstypeId=55
''else
	'goodstypeId=cint(trim(request("goodstypeId")))
'end if

Response.Charset="utf-8"
set json = new jsonclass
if  goodstypeId <> "" then
	'times=split(startTime,",")
	where_0 = " and ( goodstypeId= "&goodstypeId&" or goodstypeId in (select departmentTypeID from department2 where departmentTypeID="&goodstypeId&"))"
end if
	'response.Write "1111111111111111111111111"



'response.Write(json.sql)
json.sql="select * from projectData where 1=1 " + where_0
json.root = "projectData"
'json.root = "projectData"
'ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
start = cint(request("start"))
limit = cint(request("limit"))
'�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
response.Write((json.getjson(start,limit)))

%>