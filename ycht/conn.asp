<%
set conn=server.createobject("adodb.connection")
mypath=server.mappath("data.mdb")
conn.open "provider=microsoft.jet.oledb.4.0;data source=" & mypath
%>