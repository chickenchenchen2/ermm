<%
Session.CodePage=65001
Response.Charset="utf-8"
set conn=server.createobject("adodb.connection")
connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("data.mdb")
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("test.mdb")
conn.open connstr

icon=request("icon")

set rs= server.createobject("adodb.recordset")
sqlstr = "select * from iconInfo"
rs.open sqlstr,conn,1,1

strSaleAreaTree = "["
if rs.RecordCount <> 0 then
	'strSaleAreaTree = strSaleAreaTree & "{boxLabel:'<img src=""icons/cm-11.png"" height=""16""/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-11.png',checked:true}"
	if icon <> "" then
		if icon = "cm10.png" then
			strSaleAreaTree = strSaleAreaTree & "{boxLabel:'<img src=""markerIcon/cm10.png"" height=""16""/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm10.png',checked:true},"
		else
			strSaleAreaTree = strSaleAreaTree & "{boxLabel:'<img src=""markerIcon/cm10.png"" height=""16""/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm10.png',checked:false},"
		end if
		
		Do while not rs.eof or rs.bof
			if icon = rs("iconInfoRoute") then
				iconFlag = "true"
			else
				iconFlag = "false"
			end if
			strSaleAreaTree = strSaleAreaTree & "{boxLabel:'<img src=""markerIcon/"&rs("iconInfoRoute")&""" height=""16""/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'"&rs("iconInfoRoute")&"',checked:"&iconFlag&"},"
			rs.movenext
		loop
		'去掉最后一个逗号
		strSaleAreaTree = left(strSaleAreaTree,len(strSaleAreaTree)-1)
	else
		strSaleAreaTree = strSaleAreaTree & "{boxLabel:'<img src=""markerIcon/cm-10.png"" height=""16""/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-10.png',checked:true},"
		Do while not rs.eof or rs.bof
			strSaleAreaTree = strSaleAreaTree & "{boxLabel:'<img src=""markerIcon/"&rs("iconInfoRoute")&""" height=""16""/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'"&rs("iconInfoRoute")&"',checked:false},"
			rs.movenext
		loop
		'去掉最后一个逗号
		strSaleAreaTree = left(strSaleAreaTree,len(strSaleAreaTree)-1)
	end if
	
	
	'Do while not rs.eof or rs.bof
'		if icon <> "" then
'			
'			if icon = rs("iconInfoRoute") then
'				iconFlag = true
'			else
'				iconFlag = false
'			end if
'			
'			strSaleAreaTree = strSaleAreaTree & "{boxLabel:'<img src=""markerIcon/"&rs("iconInfoRoute")&""" height=""16""/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'"&rs("iconInfoRoute")&"',checked:"&iconFlag&"},"
'		else
'		
'			
'			
'		end if		
'		'strSaleAreaTree = strSaleAreaTree & "{state:true,businessname:'"&rs("businessname")&"',address:'"&rs("address")&"',lng:'"&rs("lng")&"',lat:'"&rs("lat")&"',goodstype:'"&rs("goodstype")&"',url:'"&rs("url")&"',info:'"&rs("info")&"',icon:'"&rs("icon")&"',iconname:'"&rs("iconname")&"',iconadress:'"&rs("iconadress")&"'"
'		strSaleAreaTree = strSaleAreaTree &"},"
'		rs.movenext
'	loop
'	'去掉最后一个逗号
'	strSaleAreaTree = left(strSaleAreaTree,len(strSaleAreaTree)-1)
else
	strSaleAreaTree = strSaleAreaTree & "{state:false}"
end if
strSaleAreaTree = strSaleAreaTree & "]"
response.Write(strSaleAreaTree)
%>
