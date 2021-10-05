<!-- #include file=conn.asp -->
<%
id=request("id")
sql="delete from projectData where id="&id
conn.execute(sql)
%>