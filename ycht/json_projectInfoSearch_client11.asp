<%
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
goodstype=request("goodstype")
keyValue=request("keyValue")
v1=request("v1")

if goodstype <> "" then
	'times=split(startTime,",")
	where_0 = "  and goodstype = '"+goodstype+"'"
end if
if v1 <> "" then
	'times=split(startTime,",")
	vv1=Split(v1,",")
	'response.Write(UBound(vv1)+1)
	where_2 = "v1 = '"+vv1(0)+"'"
	if UBound(vv1)>0 then
	'where2 = "v1 = '"+vv1(0)+"'"
	For i=LBound(vv1)+1 To UBound(vv1)
	where_2 = where_2+" or v1= '"+vv1(i)+"'"
	Next
	
	end if
	where_2="and ("+where_2+")"
	
end if
'["id","businessname","address","lng","lat","goodstype","icon","iconname","iconadress","url","info"]
if keyValue <> "" then
	'where_1 = "  and (businessname like '%"+keyValue+"%' or address like '%"+keyValue+"%' or lng like '%"+keyValue+"%' or lat like '%"+keyValue+"%' or icon like '%"+keyValue+"%' or url like '%"+keyValue+"%' or info like '%"+keyValue+"%')"
	where_1 = "  and businessname like '%"+keyValue+"%'"
	else
	where_1=""
end if

Response.Charset="utf-8"
set json = new jsonclass
'json.sql="select * from projectData where v1='0' " + where_0 + where_1
json.sql="select * from projectData where 1=1 " + where_0 + where_1+where_2
json.root = "projectData"
response.Write(json.sql)
'response.Write(json.sql)
'ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
start = cint(request("start"))
limit = cint(request("limit"))
'�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
response.Write((json.getjson(start,limit)))
%>