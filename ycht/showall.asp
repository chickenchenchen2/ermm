<%dim conn,constrl
set conn=server.createobject("adodb.connection")
constrl="Driver={Microsoft Access Driver (*.mdb)};DBQ="&server.mappath("data.mdb")
conn.open constrl
%>
<html>
<head>
<title>��ʾ������Ϣ</title>
<META content="text/html; charset=gb2312" http-equiv="Content-Type">
<style type="text/css">
body{
margin:0px;
padding:0px;
}
</style>
<script language="javascript" src="http://api.51ditu.com/js/maps.js"></script>
</head>
<body onLoad="inimap()">

<!--<div id="showName" style="width:100px;height:300px;border:1px solid #FF3333;font-size:12px;background-color:#D4D4D4">test</div>-->
<div id="mapDiv" style="width:768px; height:350px;"></div>

<script language="javascript">
 function killErrors() {
return true;
}
window.onerror = killErrors;
//�����ѯ

function doit(bounds)
	{
		//var str="��ѡ�����������Ϊ��\n";
		//str+="���Ͻ����꣺"+bounds.getXmin()+","+bounds.getYmax()+"\n";
		//str+="���½����꣺"+bounds.getXmax()+","+bounds.getYmin()+"\n";
		//alert(str);
		var m=0; 
		for(i in points)
		{  
 		   if(bounds.containsPoint(points[i]))
		     {
			
		      m+=1; 
		     }
		  else 
		    {
		     continue;
		    }
	   }
	   alert("��������"+m+"��");
	}
//���õ���������Ϣ
function getClickCallBack(marker,html,title) 
	{ 
	        return function(){a=marker.openInfoWinHtml(html );a.setTitle(title)} ;
	} 
	function inimap()
	{
var map=new LTMaps(document.getElementById("mapDiv"));
  map.addControl(new LTStandMapControl());
  //map.addControl(new LTOverviewMapControl());
 var points=[];
 var names=[];
 var contents=[];
 var biaozhu=[];
 var address=[];
 var wangzhi=[];
 var tel=[];
 var marker=[]
 var url="icons/"
 


for(var i=0;i<points.length;i++)
		{   
		 
			marker[i].setIconImage(url+biaozhu[i]+".png" ); 
		
		} 


  

showmarker();



 function showmarker(){
    //map.getBestMap(points);
     for(var i=0;i<points.length;i++)
		{   
		  var icon=new LTIcon(url+biaozhu[i]+".png");//����һ��ͼ��
		  marker[i] = new LTMarker(points[i],icon ); 
			map.addOverLay(marker[i]); 
			//var html=contents[i];
			var html="����:"+names[i]+"<br>"+contents[i];
                  var mapText=new LTMapText(marker[i]);
	          mapText.setLabel(names[i]);
             //     map.addOverLay(mapText);
			
		var title=names[i];
		//��ȷд��
			LTEvent.addListener( marker[i] , "click" ,getClickCallBack(marker[i],html,title)); 
			//LTEvent.addListener( marker[i] , "mouseover" ,getClickCallBack(marker[i],html,title)); 
		
		}
 }

// var control = new LTZoomSearchControl();	//�����µ�������ҿؼ�
// map.addControl(control);			//��ӿؼ�����ͼ
// LTEvent.addListener(control,"mouseup",doit);	//�������û��������֮��ִ��doit����
    <%
	'Dim conn,rs
	dim rs
	'Set conn=Server.CreateObject("ADODB.Connection")
	Set rs=Server.CreateObject("ADODB.RecordSet")
	'conn.Open "Driver={Microsoft Access Driver (*.mdb)}; DBQ="+server.mappath("test.mdb")
	rs.open "select * from projectData where stateDianPu <> '����'",conn,1,1
	while not rs.eof
    %>
     points.push(new LTPoint(<%=rs("lng")%>,<%=rs("lat")%>));  
     names.push("<%=rs("businessname")%>");
	 address.push("<%=rs("address")%>");
	 tel.push("<%=rs("iconname")%>")
     contents.push('<%=replace(rs("info"),vbNewLine,"<br/>")%>');
	wangzhi.push("<%=rs("url")%>");
	 biaozhu.push('<%=rs("icon")%>')
    <%
	rs.movenext
	wend
	rs.close
	conn.close
     
     %>
     map.getBestMap(points);
	map.moveToCenter(new LTPoint(11853475,3745394),1)//11853475,3745394;11854080,3744817
     for(var i=0;i<points.length;i++)
		{   
		  //var icon=new LTIcon(url+biaozhu[i]+".png");//����һ��ͼ��
		  var icon=new LTIcon(url+biaozhu[i]);//����һ��ͼ��
		  marker[i] = new LTMarker(points[i],icon ); 
			map.addOverLay(marker[i]); 
			//var html=contents[i];+
			//var html="<div style='text-align:left;'>������"+names[i]+"<br>"+"��ַ:"+address[i]+"<br>�绰��"+tel[i]+"<br>��ַ��<a href='"+wangzhi[i]+"' target=\"_blank\">"+wangzhi[i]+"</a>"+"</div>"
			var html="<div style='text-align:left;'>������"+names[i]+"<br>"+"��ַ:"+address[i]+"<br>�绰��"+tel[i]+"<br>��ַ��<a href='"+wangzhi[i]+"' target=\"_blank\">"+wangzhi[i]+"</a><br>"+contents[i]+"</div>"//����ע��Ϣ���뵽��������ʾ
                  var mapText=new LTMapText(marker[i]);
	          mapText.setLabel(names[i]);
               //   map.addOverLay(mapText);
			
		var title=names[i];
		//��ȷд��
		//	LTEvent.addListener( marker[i] , "click" ,getClickCallBack(marker[i],html,title)); 
			LTEvent.addListener( marker[i] , "mouseover" ,getClickCallBack(marker[i],html,title)); 
		
		} 
//var html=" ";
//	function showName(){
//	for (var i=0;i<names.length;i++)
//	{
//	//alert(i);
//	html+="<a href='javascript:map.moveToCenter(points["+i+"])'>"+names[i]+"</a></br>";
//    }
//	html+="<span>1 2 3 4 5 6 7 8 </span>";
//    }
LTEvent.addListener( map , "zoom" ,changeUrl);
//showName();
 }
</script>


</body>
</html>                                                                    
                                                                        
                                                                    
