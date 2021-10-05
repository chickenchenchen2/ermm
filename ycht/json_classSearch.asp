<%
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
'projectKeyWord=request("projectKeyWord")
goodstypeId=request("goodstypeId")
'types=request("type")

'设置类别id
''if (IsEmpty(request("goodstypeId")) or request("goodstypeId")="" ) then
	'goodstypeId=55
''else
	'goodstypeId=cint(trim(request("goodstypeId")))
'end if

Response.Charset="utf-8"
set json = new jsonclass
if  goodstypeId <> "" then
	'times=split(startTime,",")
	where_0 = " and ( goodstypeId= "&goodstypeId&" or goodstypeId in (select departmentTypeID from department2 where departmentTypeID="&goodstypeId&"))"
end if
	'response.Write "1111111111111111111111111"



'response.Write(json.sql)
json.sql="select * from projectData where 1=1 " + where_0
json.root = "projectData"
'json.root = "projectData"
'取得客户端传过来的开始记录号和每页记录数
start = cint(request("start"))
limit = cint(request("limit"))
'输出从start开始到start+limit（类中已加入判断，如果start+limit大于总记录数，就输出到最后一条记录为止）的json格式的所有记录！
response.Write((json.getjson(start,limit)))

%>