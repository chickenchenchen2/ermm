<%
connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
wangdianNameKeyWord=request("wangdianNameKeyWord")

set json = new jsonclass
if wangdianNameKeyWord="" then
	json.sql="select * from wangdian"
else
	json.sql = "select * from wangdian where wangdianName like '%"+wangdianNameKeyWord+"%'"
end if

json.root = "wangdian"
'ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
start = cint(request("start"))
limit = cint(request("limit"))
'�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
response.Charset="utf-8"
response.Write((json.getjson(start,limit)))
%>