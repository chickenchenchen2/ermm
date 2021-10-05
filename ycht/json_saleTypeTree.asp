<%
Session.CodePage=65001
Response.Charset="utf-8"
set conn=server.createobject("adodb.connection")
connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("data.mdb")
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("test.mdb")
conn.open connstr
'查询一级类别
set rs= server.createobject("adodb.recordset")
sqlstr = "select * from department"
rs.open sqlstr,conn,1,1
strSaleAreaTree = "[{text: '请选择类别',expanded:true,children: ["
if rs.RecordCount <> 0 then
	Do while not rs.eof or rs.bof
		strSaleAreaTree = strSaleAreaTree & "{text:'"&rs("departmentName")&"',soleId:'"&rs("id")&"'"
		'查询二级类别
		set rs1= server.createobject("adodb.recordset")
		sqlstr1 = "select * from department2 where departmentTypeID = "&rs("id")&""
		'response.Write(sqlstr1)
		rs1.open sqlstr1,conn,1,1
		if rs1.RecordCount <> 0 then
			strSaleAreaTree = strSaleAreaTree &",leaf:false"
			strSaleAreaTree = strSaleAreaTree &",children:["
			Do while not rs1.eof or rs1.bof
				strSaleAreaTree = strSaleAreaTree &"{text:'"&rs1("departmentName")&"',leaf:true,soleId:'"&rs1("id")&"'"
				
				'查询三级类别
				set rs2= server.createobject("adodb.recordset")
				sqlstr2 = "select * from department3 where departmentTypeID = "&rs1("id")&""
				'response.Write(sqlstr2)
				rs2.open sqlstr2,conn,1,1
				if rs2.RecordCount <> 0 then
					strSaleAreaTree = strSaleAreaTree &",leaf:false"
					strSaleAreaTree = strSaleAreaTree &",children:["
					Do while not rs2.eof or rs2.bof
						strSaleAreaTree = strSaleAreaTree &"{text:'"&rs2("departmentName")&"',leaf:true,soleId:'"&rs2("id")&"'},"
						rs2.movenext
					loop
					strSaleAreaTree = left(strSaleAreaTree,len(strSaleAreaTree)-1)
					strSaleAreaTree = strSaleAreaTree &"]"
				else
					strSaleAreaTree = strSaleAreaTree &",leaf:true"
				end if
				strSaleAreaTree = strSaleAreaTree &"},"
				
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
	strSaleAreaTree = strSaleAreaTree & "{text:'无',soleId:'',leaf:true}"
end if
strSaleAreaTree = strSaleAreaTree &"]}]"
conn.close
response.Write(strSaleAreaTree)
%>