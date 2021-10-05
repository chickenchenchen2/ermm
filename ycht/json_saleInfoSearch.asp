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
'取得客户端传过来的开始记录号和每页记录数
start = cint(request("start"))
limit = cint(request("limit"))
'输出从start开始到start+limit（类中已加入判断，如果start+limit大于总记录数，就输出到最后一条记录为止）的json格式的所有记录！
response.Write((json.getjson(start,limit)))
%>