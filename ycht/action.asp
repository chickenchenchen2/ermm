<%@ CODEPAGE=65001 %>
<!--测试文件-->
<!-- #include file="conn.asp" -->
<%
Session.CodePage=65001
Response.Charset="utf-8"

'sType = request("sType")
function chinese2unicode(Str) 
  dim i 
  dim Str_one 
  dim Str_unicode 
  for i=1 to len(Str) 
    Str_one=Mid(Str,i,1) 
    Str_unicode=Str_unicode&chr(38)
    Str_unicode=Str_unicode&chr(35)
    Str_unicode=Str_unicode&chr(120) 
    Str_unicode=Str_unicode& Hex(ascw(Str_one)) 
    Str_unicode=Str_unicode&chr(59) 
  next 
  Response.Write Str_unicode 
end function    

 function chinese2unicode(Str) 
  dim i 
  dim Str_one 
  dim Str_unicode 
  for i=1 to len(Str) 
    Str_one=Mid(Str,i,1) 
    Str_unicode=Str_unicode&chr(38) 
    Str_unicode=Str_unicode&chr(35) 
    Str_unicode=Str_unicode&chr(120) 
    Str_unicode=Str_unicode& Hex(ascw(Str_one)) 
    Str_unicode=Str_unicode&chr(59) 
  next 
  Response.Write Str_unicode 
end function    
if (IsEmpty(request("id")) or request("id")="" ) then
	id=0
else
	id=cint(trim(request("id")))
end if

'设置类别id
if (IsEmpty(request("goodstypeId")) or request("goodstypeId")="" ) then
	goodstypeId=55
else
	goodstypeId=cint(trim(request("goodstypeId")))
end if

businessname=replace(request("businessname"),"'","")
lng=request("lng")
lat=request("lat")
	'businessname = replace(upload.forms("businessname"),"'","")
	address = request("address")
	'lng = replace(upload.forms("lng"),"'","")
	'lat = replace(upload.forms("lat"),"'","")
	
	stateDianPu ="显示"

	
	if (IsEmpty(request("goodstype")) or request("goodstype")="" ) then
	goodstype="公司"
    else
	goodstype = request("goodstype")
	end if
	
	if (IsEmpty(request("url")) or request("url")="" ) then
	 url="空"
    else
	url = request("url")
	end if
	
	if (IsEmpty(request("info")) or request("info")="" ) then
	 info="空"
    else
	 info = replace(request("info"),"'","")
	end if
	
	if (IsEmpty(request("icon")) or request("icon")="" ) then
	 icon="cm6.png"
    else
	 icon =request("icon")
	end if
	
	'电话
	if (IsEmpty(request("iconname")) or request("iconname")="" ) then
	 iconname="10086"
    else
	 iconname =request("iconname")
	end if
	
	'类别
	if (IsEmpty(request("v1")) or request("v1")="" ) then
	 v1="普通客户"
    else
	 v1 =request("v1")
	end if
	
	'上传图片
	if (IsEmpty(request("iconadress")) or request("iconadress")="" ) then
	sFileName=" "
    else
	'sFileName ="upfile/"+request("sFileName")
	sFileName =request("iconadress")
	end if
	
	
	'info = replace(upload.forms("info"),"'","")
	'icon = replace(upload.forms("icon"),"'","")
	'iconname = replace(upload.forms("iconname"),"'","")
	'v1 = replace(upload.forms("v1"),"'","") '所属类别
'departmentTypeName=request("departmentTypeName")
'departmentTypeID = owenAreaId




		
		if id>0 then    'update
			'sql="update projectData set businessname='"&businessname&"',lng='"&lng&"',lat='"&lat&"', where id="&id
			sql="update projectData set businessname='"&businessname&"',address='"&address&"',goodstypeId="&goodstypeId&",lng='"& lng &"',lat='"& lat &"',stateDianPu='"& stateDianPu &"',goodstype='"&goodstype&"',url='"&url&"',info='"&info&"',icon='"&icon&"',iconname='"&iconname&"',v1='"&v1&"',iconadress='"&sFileName&"' where id="&id
			'response.write sql
			conn.execute(sql)
			if err.number=0 then
				response.write "{success:true,msg:3}"
			else
				response.write "{success:false,msg:4}"
			end if
		else
			'sql="insert into projectData(businessname,lng,lat) values ('"&businessname&"',"&lng&","&lat&")"
			sql="insert into projectData ([businessname],[address],[lng],[lat],[stateDianPu],[goodstype],[goodstypeId],[url],[info],[icon],[iconname],[iconadress],[v1]) values ('"&businessname&"','"&address&"','"&lng&"','"&lat&"','"&stateDianPu&"','"&goodstype&"',"&goodstypeId&",'"&url&"','"&info&"','"&icon&"','"&iconname&"','"&sFileName&"','"&v1&"')"
			conn.execute(sql)
			if err.number=0 then
				response.write "{success:true,msg:0}"
			else
				response.write "{success:false,msg:1}"
			end if
		end if
	
	
	
	


conn.close

%>