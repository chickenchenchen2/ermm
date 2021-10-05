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
saleAreaName = request("saleAreaNameSecond")
salerId = request("salerIdSecond")
saleArea = request("saleAreaSecond")
areaColor = request("areaColorSecond")
areaGrade = request("areaGradeSecond")
owenArea = request("owenAreaSecond")
saleAreaLv1 = request("owenAreaId")

if id>0 then
	'rs.open "update [point_admin] set name='"&namea&"',address='"&address&"',lag="&lag&",lat="&lat&",riqi="&riqi&",icon='"&icon&"',file1='"&file1_name&"',type="&type1&",info='"&info&"' where id="&id,conn,1,3
	sql="update [saleAreaLv2] set saleAreaName='"&saleAreaName&"',salerId='"&salerId&"',saleArea='"&saleArea&"',areaColor='"&areaColor&"',areaGrade='"&areaGrade&"',owenArea='"&owenArea&"',saleAreaLv1='"&saleAreaLv1&"' where id="&id
	conn.execute(sql)
	if err.number=0 then
		response.write "{success:true,msg:3}"
	else
		response.write "{success:false,msg:4}"
	end if
else
	MaxAID=conn.Execute("select max(ID) from saleAreaLv2")(0)
	if isnull(MaxAID) or Not IsNumeric(MaxAID) then MaxAID=0
	InfoID=MaxAID+1
	sql="insert into [saleAreaLv2] (id,saleAreaName,salerId,saleArea,areaColor,areaGrade,owenArea,saleAreaLv1) values ('"&InfoID&"','"&saleAreaName&"','"&salerId&"','"&saleArea&"','"&areaColor&"','"&areaGrade&"','"&owenArea&"','"&saleAreaLv1&"')"
	'response.write sql
	conn.execute(sql)
	if err.number=0 then
		response.write "{success:true,msg:0}"
	else
		response.write "{success:false,msg:1}"
	end if
end if
%>