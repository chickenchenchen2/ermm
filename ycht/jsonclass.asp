<%
'--------------------------------------- 
' jsonclass�� 
' ��select����ִ�н��ת����json 
'
'json��׼��ʽ��

'{mytotal:100,root:[{"id","123","name","����"},{"id","456","name","����"}]}
'
'��
'
'{mytotal:100,root:[{id,"123",name,"����"},{id,"456",name,"����"}]}
'
'------------------------------------------ 
class jsonclass 
' ���������ԣ�Ĭ��Ϊprivate 
dim p_sqlstring ' ��������select 
dim p_root ' ���ص�json��������� 
dim rs,conn

private sub class_initialize()
sqlstring = ""
json = ""
'��ʼ��conn��rs
call initconn(conn)
call initrs(rs) 
end sub

private sub class_terminate()
'���conn��rs
call clearconn(conn)
call clearrs(rs)
end sub

' �����ⲿ���õĹ������� 
public function getjson(x,y)

dim rs 
dim returnstr 
dim i 
dim onerecord 
dim start
dim limit
dim mycount
dim json
dim ls
start=x
limit=y

'�����¼����
set rs88= server.createobject("adodb.recordset") 
rs88.open sql,conn,1,1 
mycount=cint(rs88.recordcount)
'response.write(mycount)
rs88.close
set rs88=nothing

'�ж�start+limit�Ƿ���ڼ�¼����
ls=cint(start)+cint(limit)
if ls>=mycount then
ls=mycount
end if

' ��ȡ���� 
set rs= server.createobject("adodb.recordset") 
rs.open sql,conn,1,1 

' ����json�ַ��� 
if rs.eof=false and rs.bof=false then
json=cstr("{mytotal:"& mycount & ",start:'"& start & "',limit:'"& limit & "',root:[")

for i = start+1 to ls
rs.absoluteposition=i     '����¼ָ���Ƶ�i--��¼��ʼ��λ��

'��ȡ��¼�еĸ�������
onerecord="{"
for j=0 to rs.fields.count -1 
onerecord=onerecord & chr(39) & rs.fields(j).name&chr(39) &":" 
if j=rs.fields.count-1 then  '�����һ��,�Ͳ��Ӷ���
onerecord=onerecord & chr(39) & rs.fields(j).value&chr(39) 
else
onerecord=onerecord & chr(39) & rs.fields(j).value&chr(39) &","
end if

next 
onerecord=onerecord & "}"

'ȥ�����һ����¼���"," 
if i <> ls then
            onerecord =onerecord + ","
        end if

'------------ 
json=json & onerecord
next
json = json +"]}"

'����json��ʽ�ִ�
getjson=json
end if 
end function 

 

 

'˽�÷�����������ʹ�� 
private function check() 

end function 

'���ݿ����
sub initconn(conn)
set conn=server.createobject("adodb.connection")
conn.mode=3
conn.open connstr
end sub

sub clearconn(conn)
conn.close
set conn=nothing
end sub

sub initrs(rs)
set rs=server.createobject("adodb.recordset")
end sub
sub clearrs(rs)
set rs=nothing
end sub

public property get sql
sql = p_sqlstring
end property

public property let sql(value)
p_sqlstring = value
end property

public property get root
root = p_root
end property

public property let root(value)
p_root = value
end property
' 
end class 
%>
