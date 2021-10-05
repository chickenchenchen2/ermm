<!-- #include file=conn.asp -->
<%
Session.CodePage=65001

'customerName			客户名称
'customerOfficeAdress	客户办公地址
'customerStoreHouse		客户仓库地址
'province				省
'city					市
'district				区
'kehuxiaqu				客户辖区中文描述 例如（北京、上海、深圳）这样的地名 然后在地图上会显示相对应的面
'kehufuzeren				客户负责人（即为公司的销售人员，与销售人员表对应）
'kehufuzerenTel			客户负责人联系方式
'beizhu					这里用户可以录入备注信息

sType = request("sType")
if (IsEmpty(request("id")) or request("id")="" ) then
	id=0
else
	id=cint(trim(request("id")))
end if
customerName = request("customerName")
customerOfficeAdress = request("customerOfficeAdress")
customerOfficeAdressLng = request("customerOfficeAdressLng")
customerOfficeAdressLat = request("customerOfficeAdressLat")
customerStoreHouse = request("customerStoreHouse")
customerStoreHouseLng = request("customerStoreHouseLng")
customerStoreHouseLat = request("customerStoreHouseLat")
province = request("province")
city = request("city")
district = request("district")
kehuxiaqu = request("kehuxiaqu")
kehufuzeren = request("kehufuzeren")
kehufuzerenTel = request("kehufuzerenTel")
beizhu = request("beizhu")

if id>0 then
	'rs.open "update [point_admin] set name='"&namea&"',address='"&address&"',lag="&lag&",lat="&lat&",riqi="&riqi&",icon='"&icon&"',file1='"&file1_name&"',type="&type1&",info='"&info&"' where id="&id,conn,1,3
	sql="update [customer] set customerName='"&customerName&"',customerOfficeAdress='"&customerOfficeAdress&"',customerOfficeAdressLng='"&customerOfficeAdressLng&"',customerOfficeAdressLat='"&customerOfficeAdressLat&"',customerStoreHouse='"&customerStoreHouse&"',customerStoreHouseLng="&customerStoreHouseLng&",customerStoreHouseLat="&customerStoreHouseLat&",province='"&province&"',city='"&city&"',district='"&district&"',kehuxiaqu='"&kehuxiaqu&"',kehufuzeren='"&kehufuzeren&"',kehufuzerenTel='"&kehufuzerenTel&"',beizhu='"&beizhu&"' where id="&id
	conn.execute(sql)
	if err.number=0 then
		response.write "{success:true,msg:3}"
	else
		response.write "{success:false,msg:4}"
	end if
else
	MaxAID=conn.Execute("select max(ID) from customer")(0)
	if isnull(MaxAID) or Not IsNumeric(MaxAID) then MaxAID=0
	InfoID=MaxAID+1
	sql="insert into [customer] (id,customerName,customerOfficeAdress,customerOfficeAdressLng,customerOfficeAdressLat,customerStoreHouse,customerStoreHouseLng,customerStoreHouseLat,province,city,district,kehuxiaqu,kehufuzeren,kehufuzerenTel,beizhu) values ('"&InfoID&"','"&customerName&"','"&customerOfficeAdress&"',"&customerOfficeAdressLng&","&customerOfficeAdressLat&",'"&customerStoreHouse&"',"&customerStoreHouseLng&","&customerStoreHouseLat&",'"&province&"','"&city&"','"&district&"','"&kehuxiaqu&"','"&kehufuzeren&"','"&kehufuzerenTel&"','"&beizhu&"')"
	'response.write sql
	conn.execute(sql)
	if err.number=0 then
		response.write "{success:true,msg:0}"
	else
		response.write "{success:false,msg:1}"
	end if
end if
%>