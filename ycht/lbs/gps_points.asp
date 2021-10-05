<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	</style>
	<script src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4yZc2wBOaRWDulfTBHT0rvnO"></script>
	<title>轨迹</title>
</head>
<body>
	<div id="allmap"></div>
</body>
</html>
<%
username=request("username")
timeup=request("timeup")

%>
<script type="text/javascript">
	// 百度地图API功能
	//alert("<%=username%>")
	//alert("<%=timeup%>")
	var gps_points=[]
	var map = new BMap.Map("allmap");
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 15);
	
	//添加放大缩小控件
	var navigationControl = new BMap.NavigationControl({
    // 靠左上角位置
    anchor: BMAP_ANCHOR_TOP_LEFT,
    // LARGE类型
    type: BMAP_NAVIGATION_CONTROL_LARGE,
    // 启用显示定位
    enableGeolocation: true
 	 });
  	map.addControl(navigationControl);
	//添加放大缩小控件结束


	
	//获取轨迹数据
	//username='B15100150122'
	username="<%=username%>"
	timeup="<%=timeup%>"
	url="http://www.gtwhp.com/lbs/lbs/json_gps_points.asp?start=0\&limit=2000\&username="+username+"\&timeup="+timeup
	//alert(url)
	jQuery.post(url,function(data,status){
	//alert(data)
	
	//获取经纬度
	var jsonObj=eval('(' + data + ')');
	//alert(jsonObj.mytotal)
				var jingdu,weidu,timeup
				var detail=jsonObj.root;
			//    map.clearOverlays(); 
				for(i=0;i<detail.length;i++)
				{
					//	alert(detail[i].lng+" "+detail[i].lat )
			        if(detail[i].lng.length<13)
					{
					jingdu=detail[i].lng
					weidu=detail[i].lat
					timeup=detail[i].timeup.substring(8,20)
					var point=new BMap.Point(jingdu,weidu)
					gps_points.push(point);
					 
					}
					 if(i%2 ==0&&detail[i].lng.length<13)
						{
						var marker = new BMap.Marker(point);  // 创建标注
						map.addOverlay(marker);              // 将标注添加到地图中
		            	//显示文本开始
						
						
						
					var opts = {
	 						 position : point,    // 指定文本标注所在的地理位置
	 						 offset   : new BMap.Size(-30, 0)    //设置文本偏移量
								}
	                var label1_text="<div style='border:1px solid red;width:70px;background:white'>"+timeup+"</div>"//"<div style='border:1px solid red;width:64px;background:white'>当前位置</div>
					var label1 = new BMap.Label(label1_text, opts);  // 创建文本标注对象
					    label1.setStyle({
										color:"red",                   //颜色
										fontSize:"14px",               //字号
										fontWeight:"bold",
										border:"0",                    //边
										height:"24px",                //高度
										width:"70px",                 //宽
										textAlign:"center",            //文字水平居中显示
										lineHeight:"24px",            //行高，文字垂直居中显示
										//background:"url(http://cdn1.iconfinder.com/data/icons/CrystalClear/128x128/actions/gohome.png)",    //背景图片，这是房产标注的关键！
										cursor:"pointer"
										 });
					map.addOverlay(label1);   
						//显示文本结束
						
						}
					//alert(jingdu)
					//var point=new BMap.Point(jingdu,weidu)
					//gps_points.push(point);
					//map.panTo(new BMap.Point(jingdu,weidu),11)
					//map.addOverlay(marker);            //增加点
					//添加当前位置坐标
					
				}
				
				var polyline1 = new BMap.Polyline(gps_points, {strokeColor:"blue", strokeWeight:2, strokeOpacity:0.5});
				map.addOverlay(polyline1); 
				map.setViewport(gps_points) ;
	//获取经纬度结束
	
	});
</script>
