<%
connstr = "driver={microsoft access driver (*.mdb)};dbq="&server.mappath("data.mdb")
%>
<!-- #include file=jsonclass.asp -->
<%
Session.CodePage=65001
employeeKeyWord=request("employeeInfoNameKeyWord")

Response.Charset="utf-8"
set json = new jsonclass
if employeeKeyWord="" then
	json.sql="select * from employee"
else
	json.sql = "select * from employee where employee_name like '%"+employeeKeyWord+"%'"
end if

json.root = "employee"
'ȡ�ÿͻ��˴������Ŀ�ʼ��¼�ź�ÿҳ��¼��
start = cint(request("start"))
limit = cint(request("limit"))
'�����start��ʼ��start+limit�������Ѽ����жϣ����start+limit�����ܼ�¼��������������һ����¼Ϊֹ����json��ʽ�����м�¼��
response.Write((json.getjson(start,limit)))
%>