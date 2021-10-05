<%@ codepage=65001%>
<!-- #include file="conn.asp" -->
<!--#include file="UpLoad_Class.asp"-->
<%
Session.CodePage=65001
Response.Charset="utf-8"

sType = request("sType")
if (IsEmpty(request("id")) or request("id")="" ) then
	id=0
else
	id=cint(trim(request("id")))
end if

if sType = "add" then
	dim upload
	set upload = new AnUpLoad
	upload.Charset="UTF-8"
	upload.Exe = "jpg|bmp|jpeg|gif|png"
	upload.MaxSize = 2 * 1024 * 1024     '设置最大上传限制
	'upload.SingleSize=500*1024          '设置单文件最大上传限制为500KB,按字节计；默认为不限制
	upload.GetData()
	
	iconInfoName = replace(upload.forms("iconInfoName"),"'","")
	'iconInfoRoute = trim(request("iconInfoRoute"))
	'v1 = replace(upload.forms("v1"),"'","")
	
	if iconInfoName <> "" then
		if upload.ErrorID>0 then 
			'response.Write upload.Description
			response.Write "{success:false,msg:1}"
		else
			dim savpath,sFileName,strResult
			for each f in upload.files(-1)
				dim file
				set file = upload.files(f)
	'				filename0=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)
	'				filename=filename0 & fileEXT
	'				sFileName= filename0 & fileEXT
					savepath = "markerIcon/"
					if not(file is nothing) then
						result = file.saveToFile(savepath,0,true)
						sFileName = savepath&""&file.filename
						
						if result then
							strResult = 0
								if id>0 then    'update
									sql="update iconInfo set iconInfoName='"&iconInfoName&"',iconInfoRoute="&file.filename&" where id="&id
									conn.execute(sql)
									if err.number=0 then
										strResult = 3
									else
										strResult = 4
									end if
								else
									sql="insert into iconInfo ([iconInfoName],[iconInfoRoute]) values ('"&iconInfoName&"','"&file.filename&"')"
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
			response.Write "{success:true,msg:"&strResult&"}"
		end if
	else
		response.Write "{success:true,msg:1}"
	end if


elseif sType = "del" then
	arrvalue=split(id,",")
    for i=0 to ubound(arrvalue)
      	on error resume next
	  	sql="delete from iconInfo where id=" & arrvalue(i)
		conn.execute(sql)
    next
else
end if

set upload = nothing
conn.close
%>