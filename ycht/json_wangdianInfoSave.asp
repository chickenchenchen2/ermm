<%@ codepage=65001%>
<!-- #include file="conn.asp" -->
<!--#include file="UpLoad_Class.asp"-->
<%
Session.CodePage=65001
Response.Charset="utf-8"



sType = request("sType")

if sType = "add" then
	' = request("")
	'address = request("address")
	'ddress = request("ddress")
	'lat = request("lat")
	'goodstype = request("goodstype")
	'city = request("city")
	'district = request("district")
	'saleAreaId = request("saleAreaId")
	'info = request("info")
	'icon = request("icon")
	'iconname = request("iconname")
	'wangdianyewuren = request("wangdianyewuren")
	'wdywrTel = request("wdywrTel")
	'saleId = request("saleId")
	'wangdianPhoto = request("wangdianPhoto")
	'wangdianOwen = request("wangdianOwen")
	'beizhu = request("beizhu")
	
	dim upload
	set upload = new AnUpLoad
	upload.Charset="utf-8"
	upload.Exe = "jpg|bmp|jpeg|gif|png"
	upload.MaxSize = 2 * 1024 * 1024     '设置最大上传限制
	'upload.SingleSize=500*1024          '设置单文件最大上传限制为500KB,按字节计；默认为不限制
	upload.GetData()
	'upload.CodePage = 65001
	
	if (IsEmpty(replace(upload.forms("id"),"'","")) or replace(upload.forms("id"),"'","")="" ) then
		id=0
	else
		id=cint(replace(upload.forms("id"),"'",""))
	end if
	'city = replace(upload.forms("city"),"'","")
	'district = replace(upload.forms("district"),"'","")
	businessname = replace(upload.forms("businessname"),"'","")
	address = replace(upload.forms("address"),"'","")
	lng = replace(upload.forms("lng"),"'","")
	lat = replace(upload.forms("lat"),"'","")
	
	stateDianPu = replace(upload.forms("stateDianPu"),"'","")
	
	goodstype = replace(upload.forms("goodstype"),"'","")
	goodstypeId=replace(upload.forms("goodstypeId"),"'","")//后添加
	url = replace(upload.forms("url"),"'","")
	info = replace(upload.forms("info"),"'","")
	icon = replace(upload.forms("icon"),"'","")
	iconname = replace(upload.forms("iconname"),"'","")
	v1 = replace(upload.forms("v1"),"'","") '所属类别
	'iconname = replace(upload.forms("iconname"),"'","")
	'iconadress = replace(upload.forms("iconadress"),"'","")
	
	'response.Write businessname &"=||="& address &"=||="& lng &"=||="& lat &"=||="& goodstype &"=||="& info &"=||="& icon &"=||="& iconname
	
	if businessname <> "" then
		if upload.ErrorID>0 then 
			'response.Write upload.Description
			response.Write "{success:false,msg:1}"
		else
		dim savpath,sFileName,strResult,stateFile
			stateFile = 1
			for each i in upload.files(-1)
				set file = upload.files(i)
				if not(file is nothing) then
					stateFile = 0
				end if
			next
			
			if stateFile = 0 then
				
				for each f in upload.files(-1)
					dim file
					set file = upload.files(f)
	'				filename0=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)
	'				filename=filename0 & fileEXT
	'				sFileName= filename0 & fileEXT
					savepath = "upfile/"
					if not(file is nothing) then
						result = file.saveToFile(savepath,0,true)
						sFileName = savepath&""&file.filename
						
						if result then
							strResult = 0
								if id>0 then    'update
									sql="update projectData set businessname='"&businessname&"',address='"&address&"',lng='"& lng &"',lat='"& lat &"',stateDianPu='"& stateDianPu &"',goodstype='"&goodstype&"',goodstypeId="&goodstypeId&",url='"&url&"',info='"&info&"',icon='"&icon&"',iconname='"&iconname&"',v1='"&v1&"',iconadress='"&sFileName&"' where id="&id
									conn.execute(sql)
									if err.number=0 then
										strResult = 3
									else
										strResult = 4
									end if
								else
									sql="insert into projectData ([businessname],[address],[lng],[lat],[stateDianPu],[goodstype],[goodstypeId],[url],[info],[icon],[iconname],[iconadress],[v1]) values ('"&businessname&"','"&address&"','"&lng&"','"&lat&"','"&stateDianPu&"','"&goodstype&"',"&goodstypeId&",'"&url&"','"&info&"','"&icon&"','"&iconname&"','"&sFileName&"','"&v1&"')"
									'response.Write sql
									conn.execute(sql)
									if err.number=0 then
										strResult = 0
									else
										strResult = 1
									end if
								end if
						else
							strResult = 1
							exit for
						end if
					end if
					set file = nothing
					set rs = nothing
				next
			else
				strResult = 0
				if id>0 then    'update
					sql="update projectData set businessname='"&businessname&"',address='"&address&"',lng='"& lng &"',lat='"& lat &"',stateDianPu='"& stateDianPu &"',goodstype='"&goodstype&"',goodstypeId="&goodstypeId&",url='"&url&"',info='"&info&"',icon='"&icon&"',v1='"&v1&"',iconname='"&iconname&"' where id="&id
					conn.execute(sql)
					if err.number=0 then
						strResult = 3
					else
						strResult = 4
					end if
				else
					sql="insert into projectData ([businessname],[address],[lng],[lat],[stateDianPu],[goodstype],[goodstypeId],[url],[info],[icon],[iconname],[iconadress],[v1]) values ('"&businessname&"','"&address&"','"&lng&"','"&lat&"','"&stateDianPu&"','"&goodstype&"',"&goodstypeId&",'"&url&"','"&info&"','"&icon&"','"&iconname&"','"&sFileName&"','"&v1&"')"
					'response.Write sql
					conn.execute(sql)
					if err.number=0 then
						strResult = 0
					else
						strResult = 1
					end if
				end if
			end if
			response.Write "{success:true,msg:"&strResult&"}"
		end if
	else
		response.Write "{success:true,msg:1}"
	end if
	
	
elseif sType = "del" then
	'arrvalue=split(id,",")
'    for i=0 to ubound(arrvalue)
'      	on error resume next
'	  	sql="delete from projectData where id=" & arrvalue(i)
'		conn.execute(sql)
'    next
	sql="delete from projectData where id=" & cint(request("id"))
	conn.execute(sql)
else
end if


set upload = nothing
conn.close
%>