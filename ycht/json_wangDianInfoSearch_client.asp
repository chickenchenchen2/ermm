<%
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
xtype=request("xtype")
searchWayWangDianValue=request("searchWayWangDianValue")
customerKeyWordWangDian=request("customerKeyWordWangDian")

Response.Charset="utf-8"
set json = new jsonclass

where_0 = ""
where_1 = ""
if cint(xtype) = 1 then
	where_0 = " and wangdianAreaOwen = '"+searchWayWangDianValue+"'"
	if customerKeyWordWangDian <> "" then
		where_1 = " and wangdianName like '%"+customerKeyWordWangDian+"%'"
	end if
	json.sql="select * from wangdian where v1='0' " + where_0 + where_1
end if

if cint(xtype) = 2 then
	where_0 = " and province like '%"+searchWayWangDianValue+"%'"
	if customerKeyWordWangDian <> "" then
		where_1 = " and wangdianName like '%"+customerKeyWordWangDian+"%'"
	end if
	json.sql="select * from wangdian where v1='0' " + where_0 + where_1
end if

if cint(xtype) = 4 then
	where_0 = " and province like '%"+searchWayWangDianValue+"%'"
	if customerKeyWordWangDian <> "" then
		where_1 = " and wangdianName like '%"+customerKeyWordWangDian+"%'"
	end if
	json.sql="select * from wangdian where v1='0' " + where_0 + where_1
end if

if cint(xtype) = 5 then
	where_0 = " and wangdianAreaOwen like '%"+searchWayWangDianValue+"%'"
	if customerKeyWordWangDian <> "" then
		where_1 = " and wangdianName like '%"+customerKeyWordWangDian+"%'"
	end if
	json.sql="select * from wangdian where v1='0' " + where_0 + where_1
end if

''response.Write(json.sql)
json.root = "wangdian"
'response.Write(json.sql)
'ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
start = cint(request("start"))
limit = cint(request("limit"))
'�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
response.Write((json.getjson(start,limit)))
%>