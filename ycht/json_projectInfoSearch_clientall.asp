<%
Session.CodePage=65001
Response.Charset="utf-8"
set conn=server.createobject("adodb.connection")
connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("data.mdb")
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("test.mdb")
conn.open connstr
dim id, nameAddress

set rs= server.createobject("adodb.recordset")
sqlstr = "select * from projectData where stateDianPu <> '隐藏'"
rs.open sqlstr,conn,1,1

strSaleAreaTree = "["
if rs.RecordCount <> 0 then
	Do while not rs.eof or rs.bof
		''"&businessname&"','"&address&"','"&lng&"','"&lat&"','"&goodstype&"','"&url&"','"&info&"','"&icon&"','"&iconname&"','"&sFileName&"'
		strSaleAreaTree = strSaleAreaTree & "{state:true,businessname:'"&rs("businessname")&"',address:'"&rs("address")&"',lng:'"&rs("lng")&"',lat:'"&rs("lat")&"',goodstype:'"&rs("goodstype")&"',url:'"&rs("url")&"',info:'"&rs("info")&"',icon:'"&rs("icon")&"',iconname:'"&rs("iconname")&"',iconadress:'"&rs("iconadress")&"'"
		strSaleAreaTree = strSaleAreaTree &"},"
		rs.movenext
	loop
	'去掉最后一个逗号
	strSaleAreaTree = left(strSaleAreaTree,len(strSaleAreaTree)-1)
else
	strSaleAreaTree = strSaleAreaTree & "{state:false}"
end if
strSaleAreaTree = strSaleAreaTree & "]"
response.Write(strSaleAreaTree)
%>
