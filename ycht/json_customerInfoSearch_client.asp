<%
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
provinceSearch=request("provinceSearch")
customerOfficeAdressSearch=request("customerOfficeAdressSearch")
customerStoreHouseSearch=request("customerStoreHouseSearch")
customerKeyWord=request("customerKeyWord")

if provinceSearch <> "" then
	where_0 = "  and province = '"+provinceSearch+"'"
end if

'if customerOfficeAdressSearch = "true" then
'	where_1 = "  and customerOfficeAdress = " + customerOfficeAdressSearch
'end if
'
'if customerStoreHouseSearch = "true" then
'	where_2 = "  and customerStoreHouse = " + customerStoreHouseSearch
'end if

if customerKeyWord <> "" then
	where_3 = "  and customerName like '%"+customerKeyWord+"%'"
end if

Response.Charset="utf-8"
set json = new jsonclass
json.sql="select * from customer where v1='0' " + where_0 + where_3
json.root = "customer"
'response.Write(json.sql)
'取得客户端传过来的开始记录号和每页记录数
start = cint(request("start"))
limit = cint(request("limit"))
'输出从start开始到start+limit（类中已加入判断，如果start+limit大于总记录数，就输出到最后一条记录为止）的json格式的所有记录！
response.Write((json.getjson(start,limit)))
%>