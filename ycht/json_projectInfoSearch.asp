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
'取得客户端传过来的开始记录号和每页记录数
start = cint(request("start"))
limit = cint(request("limit"))
'输出从start开始到start+limit（类中已加入判断，如果start+limit大于总记录数，就输出到最后一条记录为止）的json格式的所有记录！
response.Write((json.getjson(start,limit)))

%>