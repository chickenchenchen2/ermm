<%
connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
saleKeyWord=request("saleKeyWord")

Response.Charset="utf-8"
set json = new jsonclass
if saleKeyWord="" then
	json.sql="select * from sale"
else
	json.sql = "select * from sale where name like '%"+saleKeyWord+"%'"
end if

json.root = "sale"
'ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
start = cint(request("start"))
limit = cint(request("limit"))
'�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
response.Write((json.getjson(start,limit)))
%>