<%@ codepage=65001%>
<!-- #include file="conn.asp" -->
<!--#include file="UpLoad_Class.asp"-->
<%
Session.CodePage=65001
Response.Charset="utf-8"




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
	

	
		'if upload.ErrorID>0 then 
			'response.Write upload.Description
		'	response.Write "{success:false,msg:1}"
		'else
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
						'response.Write "{success:true,msg:"&strResult&"}"
						response.Write "{success:true,msg:1}"

					
					end if
					set file = nothing
					set rs = nothing
				next
			end if


					if err.number=0 then
						strResult = 0
					else
						strResult = 1
					end if
			
			

	
	



set upload = nothing
conn.close
%>