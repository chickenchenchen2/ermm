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
'取得客户端传过来的开始记录号和每页记录数
start = cint(request("start"))
limit = cint(request("limit"))
'输出从start开始到start+limit（类中已加入判断，如果start+limit大于总记录数，就输出到最后一条记录为止）的json格式的所有记录！
response.Write((json.getjson(start,limit)))
%>