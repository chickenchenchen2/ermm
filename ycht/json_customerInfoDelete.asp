<!-- #include file=conn.asp -->
<%
id=request("id")
sql="delete from customer where id="&id
conn.execute(sql)
%>