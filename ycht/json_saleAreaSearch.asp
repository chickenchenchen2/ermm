<%
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
saleType=request("saleType")
owenAreaId=request("owenAreaId")
saleAreaNameKeyWord=request("saleAreaNameKeyWord")
Response.Charset="utf-8"
set json = new jsonclass
if cint(saleType)=1 then
	if saleAreaNameKeyWord="" then
		json.sql="select * from saleAreaLv1"
	else
		json.sql = "select * from saleAreaLv1 where saleAreaName like '%"+saleAreaNameKeyWord+"%'"
	end if
else
	if saleAreaNameKeyWord="" then
		json.sql="select * from saleAreaLv2 where saleAreaLv1 = '"+owenAreaId+"'"
	else
		json.sql = "select * from saleAreaLv2 where saleAreaName like '%"+saleAreaNameKeyWord+"%' and  saleAreaLv1 = '"+owenAreaId+"'"
	end if
end if
json.root = "saleAreaLv"
'ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
start = cint(request("start"))
limit = cint(request("limit"))
'�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
response.Write((json.getjson(start,limit)))
%>