<%
set conn=server.createobject("adodb.connection")
connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("data.mdb")
conn.open connstr
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
Response.Charset="utf-8"
searcNearValue=request("searcNearValue")
radioDistanceValue=request("radioDistanceValue")
positionLng=request("positionLng")/100000
positionLat=request("positionLat")/100000

set rs= server.createobject("adodb.recordset")
if searcNearValue <> "" then
	sqlstr = "select * from projectData where businessname like '%"+searcNearValue+"%'"
else
	sqlstr = "select * from projectData"
end if

rs.open sqlstr,conn,1,1
nearValue = "["
if rs.RecordCount <> 0 then
	numList = 0
	Do while not rs.eof or rs.bof
		'response.Write parameterNum &"&&&&&&&"
		radius=6371.004	'�����ƽ���뾶6371.004ǧ��,����뾶6378.140ǧ��,����6356.755ǧ��
		B=(rs("lng")/100000-positionLng)*3.141592653589793/180
		c=3.141592653589793/2-positionLat*3.141592653589793/180
		startPoint=3.141592653589793/2-rs("lat")/100000*3.141592653589793/180
		endPoint=Cos(startPoint)*Cos(c)+Sin(startPoint)*Sin(c)*Cos(B)
		'L=radius*acos(endPoint)*1000
		acosEndPoint=Atn(-endPoint/Sqr(-endPoint*endPoint+1))+2*Atn(1)
		L=radius*acosEndPoint*1000
		
		'response.Write(rs("wangdianAddressLng")/100000&"|||||"&rs("wangdianAddressLat")/100000& Chr(10))
		'response.Write(L & Chr(10))
		'response.Write positionLng &"&&&&&&&" & CLng(Round(L)) &"||"& CLng(radioDistanceValue) & "==="
		
		'logStr = Write_Log(response.Write  parameterNum &"&&&&&&&" & CLng(Round(L)) &"||"& CLng(radioDistanceValue) & "===")
		
		if CLng(Round(L)) < CLng(radioDistanceValue) then
			'response.Write(CLng(Round(L)) < CLng(radioDistanceValue))
			'response.Write(Round(L)&"|||||"&radioDistanceValue&"===")
			nearValue = nearValue &"{id:'"&rs("id")&"',businessname:'"&rs("businessname")&"',address:'"&rs("address")&"',lng:'"&rs("lng")&"',lat:'"&rs("lat")&"',stateDianPu:'"&rs("stateDianPu")&"',goodstype:'"&rs("goodstype")&"',url:'"&rs("url")&"',info:'"&rs("info")&"',icon:'"&rs("icon")&"',iconname:'"&rs("iconname")&"',iconadress:'"&rs("iconadress")&"',v1:'"&rs("v1")&"'},"
			numList = 1
		else
			'nearValue = nearValue &","
		end if
		rs.movenext
	loop
	if numList <> 0 then
		'ȥ�����һ������
		nearValue = left(nearValue,len(nearValue)-1)
	end if
else
	nearValue = nearValue & ""
end if
nearValue = nearValue &"]"
conn.close

response.Write(nearValue)

'set json = new jsonclass
'if sessionUserName = "admin" then
'	if wangdianNameKeyWord="" then
'		json.sql="select * from wangdian "
'	else
'		json.sql = "select * from wangdian where wangdianName like '%"+wangdianNameKeyWord+"%'"
'	end if
'else
'	if wangdianNameKeyWord="" then
'		json.sql="select * from wangdian "
'	else
'		json.sql = "select * from wangdian where wangdianName like '%"+wangdianNameKeyWord+"%'"
'	end if
'end if

'json.root = "wangdian"
''ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
'start = cint(request("start"))
'limit = cint(request("limit"))
''�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
'response.Charset="utf-8"
'response.Write((json.getjson(start,limit)))
%>