<%
'connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
username=request("username")
timeup=request("timeup")

Response.Charset="utf-8"
set json = new jsonclass


json.sql="Select * from user_points where datediff('d',timeup,#"+timeup+"#)=0 and username='"+username+"'"
'原来文件
'if uername ="" then
'	json.sql="select top 1 * from user_points where username='"+username+"'"
	'response.Write json.sql
'else
	'json.sql="select * from userInfo where username = '"+session("admin")+"'"
	'json.sql="select top 1 * from user_points where username='"+username+"' order by id desc"
	'json.sql="Select * from user_points where timeup between #2015/7/13# and #2015/7/14# and username='B15100150122'"
	'datediff("d",日期型的字段,#2008-09-01#)=0
	
	'json.sql="Select * from user_points where datediff('d',timeup,#2015/7/13#)=0 and username='B15100150122'"
'	json.sql="Select * from user_points where datediff('d',timeup,#"+timeup+"#)=0 and username='"+username+"'"
	'response.Write json.sql
'end If



'set json = new jsonclass
'if userKeyWord = "" then
'	json.sql="select * from userInfo"
'	'response.Write json.sql
'else
'	json.sql="select * from userInfo where username like '%"+userKeyWord+"%'"
'	'response.Write json.sql
'end if

json.root = "userInfo"
''取得客户端传过来的开始记录号和每页记录数
start = cint(request("start"))
limit = cint(request("limit"))
''输出从start开始到start+limit（类中已加入判断，如果start+limit大于总记录数，就输出到最后一条记录为止）的json格式的所有记录！
response.Write((json.getjson(start,limit)))
%>