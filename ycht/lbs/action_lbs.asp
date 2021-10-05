<%
	dim lng,lat,username
	
	lng=Request("lng")
	lat=Request("lat")
	username=Request("username")
	
	Dim conn,rs
	Set conn=Server.CreateObject("ADODB.Connection")
	Set rs=Server.CreateObject("ADODB.RecordSet")
	conn.Open "Driver={Microsoft Access Driver (*.mdb)}; DBQ="+server.mappath("data.mdb")
	
	rs.open "insert into user_points (username,lng,lat) values ('"&username&"',"&lng&","&lat&")",conn,1,3
	
        conn.close
        response.write("{success:true,msg:0}")
%>