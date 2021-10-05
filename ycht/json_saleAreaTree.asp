<%
Session.CodePage=65001
Response.Charset="utf-8"
set conn=server.createobject("adodb.connection")
connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("data.mdb")
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("test.mdb")
conn.open connstr
'查询一级片区
set rs= server.createobject("adodb.recordset")
sqlstr = "select * from saleAreaLv1"
rs.open sqlstr,conn,1,1
strSaleAreaTree = "[{text: '销售片区',expanded:true,lnglat: '10444800,3514368',children: ["
if rs.RecordCount <> 0 then
	Do while not rs.eof or rs.bof
		strSaleAreaTree = strSaleAreaTree & "{text:'"&rs("saleAreaName")&"',soleId:'"&rs("id")&"',salerId:'"&rs("salerId")&"',areaColor:'"&rs("areaColor")&"'"
		'查询二级片区
		set rs1= server.createobject("adodb.recordset")
		sqlstr1 = "select * from saleAreaLv2 where saleAreaLv1 = '"&rs("id")&"'"
		rs1.open sqlstr1,conn,1,1
		if rs1.RecordCount <> 0 then
			strSaleAreaTree = strSaleAreaTree &",leaf:false"
			strSaleAreaTree = strSaleAreaTree &",children:["
			Do while not rs1.eof or rs1.bof
				strSaleAreaTree = strSaleAreaTree &"{text:'"&rs1("saleAreaName")&"',leaf:true,soleId:'"&rs1("id")&"',salerId:'"&rs1("salerId")&"',areaColor:'"&rs1("areaColor")&"'},"
				rs1.movenext
			loop
			strSaleAreaTree = left(strSaleAreaTree,len(strSaleAreaTree)-1)
			strSaleAreaTree = strSaleAreaTree &"]"
		else
			strSaleAreaTree = strSaleAreaTree &",leaf:true"
		end if
		strSaleAreaTree = strSaleAreaTree &"},"
		rs.movenext
	loop
	'去掉最后一个逗号
	strSaleAreaTree = left(strSaleAreaTree,len(strSaleAreaTree)-1)
else
	strSaleAreaTree = strSaleAreaTree & "{text:'无',soleId:'',salerId:'',areaColor:'',leaf:true}"
end if
strSaleAreaTree = strSaleAreaTree &"]}]"
conn.close
response.Write(strSaleAreaTree)
%>