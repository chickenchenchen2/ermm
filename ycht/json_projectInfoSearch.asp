<%
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
projectKeyWord=request("projectKeyWord")
projectKeyWordType=request("projectKeyWordType")
types=request("type")

Response.Charset="utf-8"
set json = new jsonclass
if Cint(types)=0 then
	'response.Write "000000000000000000000000"
	if projectKeyWord="" then
		json.sql="select * from projectData"
	else
		json.sql = "select * from projectData where businessname like '%"+projectKeyWord+"%'"
	end if
else
	'response.Write "1111111111111111111111111"
	if projectKeyWordType="" then
		json.sql="select * from projectData"
	else
		json.sql = "select * from projectData where goodstype = '"+projectKeyWordType+"'"
	end if
end if

'response.Write(json.sql)

json.root = "projectData"
'ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
start = cint(request("start"))
limit = cint(request("limit"))
'�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
response.Write((json.getjson(start,limit)))

%>