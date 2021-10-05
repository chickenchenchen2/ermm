<!-- #include file=conn.asp -->
<%
saleType=request("saleType")
if cint(saleType)=1 then
	id=request("id")
	sql2="delete from saleAreaLv2 where saleAreaLv1='"&id&"'"
	conn.execute(sql2)
	sql1="delete from saleAreaLv1 where id="&id
	conn.execute(sql1)
else
	id=request("id")
	sql="delete from saleAreaLv2 where id="&id
	conn.execute(sql)
end if
%>