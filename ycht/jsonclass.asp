<%
'--------------------------------------- 
' jsonclass类 
' 将select语句的执行结果转换成json 
'
'json标准格式：

'{mytotal:100,root:[{"id","123","name","张三"},{"id","456","name","李四"}]}
'
'或
'
'{mytotal:100,root:[{id,"123",name,"张三"},{id,"456",name,"李四"}]}
'
'------------------------------------------ 
class jsonclass 
' 定义类属性，默认为private 
dim p_sqlstring ' 用于设置select 
dim p_root ' 返回的json对象的名称 
dim rs,conn

private sub class_initialize()
sqlstring = ""
json = ""
'初始化conn和rs
call initconn(conn)
call initrs(rs) 
end sub

private sub class_terminate()
'清除conn和rs
call clearconn(conn)
call clearrs(rs)
end sub

' 可以外部调用的公共方法 
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

'计算记录总数
set rs88= server.createobject("adodb.recordset") 
rs88.open sql,conn,1,1 
mycount=cint(rs88.recordcount)
'response.write(mycount)
rs88.close
set rs88=nothing

'判断start+limit是否大于记录总数
ls=cint(start)+cint(limit)
if ls>=mycount then
ls=mycount
end if

' 获取数据 
set rs= server.createobject("adodb.recordset") 
rs.open sql,conn,1,1 

' 生成json字符串 
if rs.eof=false and rs.bof=false then
json=cstr("{mytotal:"& mycount & ",start:'"& start & "',limit:'"& limit & "',root:[")

for i = start+1 to ls
rs.absoluteposition=i     '将记录指针移到i--记录开始的位置

'读取记录中的各列数据
onerecord="{"
for j=0 to rs.fields.count -1 
onerecord=onerecord & chr(39) & rs.fields(j).name&chr(39) &":" 
if j=rs.fields.count-1 then  '是最后一列,就不加逗号
onerecord=onerecord & chr(39) & rs.fields(j).value&chr(39) 
else
onerecord=onerecord & chr(39) & rs.fields(j).value&chr(39) &","
end if

next 
onerecord=onerecord & "}"

'去除最后一条记录后的"," 
if i <> ls then
            onerecord =onerecord + ","
        end if

'------------ 
json=json & onerecord
next
json = json +"]}"

'返回json格式字串
getjson=json
end if 
end function 

 

 

'私用方法，在类中使用 
private function check() 

end function 

'数据库操作
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
