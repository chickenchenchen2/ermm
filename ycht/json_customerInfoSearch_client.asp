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
'ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
start = cint(request("start"))
limit = cint(request("limit"))
'�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
response.Write((json.getjson(start,limit)))
%>