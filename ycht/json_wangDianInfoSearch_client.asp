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
'取得客户端传过来的开始记录号和每页记录数
start = cint(request("start"))
limit = cint(request("limit"))
'输出从start开始到start+limit（类中已加入判断，如果start+limit大于总记录数，就输出到最后一条记录为止）的json格式的所有记录！
response.Write((json.getjson(start,limit)))
%>