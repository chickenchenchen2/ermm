<!-- #include file=conn.asp -->
<%
Session.CodePage=65001

'saleAreaName			销售片区名称
'salerId				销售人员姓名 从销售人员表里获得
'saleArea				销售片区范围，比如 北京 上海等用，号将地区分开
'areaColor				片区颜色
'areaGrade					一级片区或二级片区
'owenArea		所属片区

sType = request("sType")
if (IsEmpty(request("id")) or request("id")="" ) then
	id=0
else
	id=cint(trim(request("id")))
end if
saleAreaName = request("saleAreaName")
salerId = request("salerId")
saleArea = request("saleArea")
areaColor = request("areaColor")
areaGrade = request("areaGrade")
owenArea = request("owenArea")

if id>0 then
	'rs.open "update [point_admin] set name='"&namea&"',address='"&address&"',lag="&lag&",lat="&lat&",riqi="&riqi&",icon='"&icon&"',file1='"&file1_name&"',type="&type1&",info='"&info&"' where id="&id,conn,1,3
	sql="update [saleAreaLv1] set saleAreaName='"&saleAreaName&"',salerId='"&salerId&"',saleArea='"&saleArea&"',areaColor='"&areaColor&"',areaGrade='"&areaGrade&"',owenArea='"&owenArea&"' where id="&id
	conn.execute(sql)
	if err.number=0 then
		response.write "{success:true,msg:3}"
	else
		response.write "{success:false,msg:4}"
	end if
else
	MaxAID=conn.Execute("select max(ID) from saleAreaLv1")(0)
	if isnull(MaxAID) or Not IsNumeric(MaxAID) then MaxAID=0
	InfoID=MaxAID+1
	sql="insert into [saleAreaLv1] (id,saleAreaName,salerId,saleArea,areaColor,areaGrade,owenArea) values ('"&InfoID&"','"&saleAreaName&"','"&salerId&"','"&saleArea&"','"&areaColor&"','"&areaGrade&"','"&owenArea&"')"
	'response.write sql
	conn.execute(sql)
	if err.number=0 then
		response.write "{success:true,msg:0}"
	else
		response.write "{success:false,msg:1}"
	end if
end if
%>