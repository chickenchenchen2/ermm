<!-- #include file=conn.asp -->
<%
Session.CodePage=65001

'customerName			�ͻ�����
'customerOfficeAdress	�ͻ��칫��ַ
'customerStoreHouse		�ͻ��ֿ��ַ
'province				ʡ
'city					��
'district				��
'kehuxiaqu				�ͻ�Ͻ���������� ���磨�������Ϻ������ڣ������ĵ��� Ȼ���ڵ�ͼ�ϻ���ʾ���Ӧ����
'kehufuzeren				�ͻ������ˣ���Ϊ��˾��������Ա����������Ա���Ӧ��
'kehufuzerenTel			�ͻ���������ϵ��ʽ
'beizhu					�����û�����¼�뱸ע��Ϣ

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