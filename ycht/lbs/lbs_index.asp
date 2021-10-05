

<!DOCTYPE html>
<html lang="zh-CN">

  <script src="http://www.helloweba.com/demo/js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4yZc2wBOaRWDulfTBHT0rvnO"></script>
  <head>
    <meta charset="GB2312">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
  <style type="text/css">
		body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
		
	</style>

    <title>人员定位</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="index_zc.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
  

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="container">

      <div class="row">
	  <!--左侧树形结构栏-->
 	 		<div class="col-md-4" style="padding:0px;margin:0px;">
	 				<!--面版开始-->
									<div class="panel panel-default">
								 <div class="panel-heading">人员列表</div>
								 <div class="panel-body" style="padding:0px;margin:0px;">
							 <!--人员列表开始-->
									<div class="list-group">
									<a href="#" class="list-group-item">
									admin账号<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('admin')">定位</button>
									<button type="button" class="btn btn-primary btn-xs" id="myButton">轨迹</button>
				
									 </a>
									 <a href="#" class="list-group-item">
									A账号<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('a')">定位</button>
									<button type="button" class="btn btn-primary btn-xs" id="myButton">轨迹</button>
				
									 </a>
									 <a href="#" class="list-group-item">B账号<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('B15100150122')">定位</button>
									<button type="button" class="btn btn-primary btn-xs" id="myButton2">轨迹</button></a>
								 <a href="#" class="list-group-item">C账号<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('C13901175722')">定位</button>
									<button type="button" class="btn btn-primary btn-xs" id="myButton3">轨迹</button></a>
							 <a href="#" class="list-group-item">D账号<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('d15810534616')">定位</button>
									<button type="button" class="btn btn-primary btn-xs" id="myButton4">轨迹</button></a>
							 <a href="#" class="list-group-item">E账号<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('E13681017657')">定位</button>
									<button type="button" class="btn btn-primary btn-xs id="myButton5"">轨迹</button></a>
							 <script language="javascript">
							 
							 
							 </script>
								</div>
							  <!--人员列表结束-->
						 </div>
							</div>


				<!--面版结束-->
	 
	 
			 </div>
		 <!--右侧地图栏-->
			<div class=" col-md-8" style="height:600px;"><div id="allmap">
			</div>
			 <!--右侧地图栏结束-->
		</div> <!--row结束标签 -->

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
   
  </body>
</html>
<script type="text/javascript">

	// 百度地图API功能
	var map = new BMap.Map("allmap");    // 创建Map实例
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	
	
	function showPosition(username)
	{
		//alert("11")
	setInterval("showPosition(username)",1000);
	 //load data 
	// alert("test")
	//alert(username)
	//setTimeout(function(){
		//showPosition(username);
	//}, 1000);
	jQuery.post("http://www.bjyuanhui.com/lbs/lbs/json_pointsSearch_lbs.asp?start=0&limit=100&username="+username,function(data,status){
        
		    // alert("Data: " + data + "\nStatus: " + status);
			// var jsonObj = eval('(' + jsonData + ')'); // ok  创建json对象
    		var jsonObj=eval('(' + data + ')');
	        //alert(jsonObj.mytotal)
				var jingdu,weidu,username
				var detail=jsonObj.root;
			//    map.clearOverlays(); 
				for(i=0;i<detail.length;i++)
				{
					//	alert(detail[i].lng+" "+detail[i].lat )
					username=detail[i].username;
			        if(detail[i].lng.length<13)
					{
					jingdu=detail[i].lng
					weidu=detail[i].lat
					}
					else
					{
					jingdu="116.404";
					weidu="39.915"
					}
					var point=new BMap.Point(jingdu,weidu)
					 map.panTo(new BMap.Point(jingdu,weidu),11)
					//map.addOverlay(marker);            //增加点
					//添加当前位置坐标
					var marker = new BMap.Marker(point);  // 创建标注
					map.addOverlay(marker);              // 将标注添加到地图中
				
					//var label = new BMap.Label("我的位置",{offset:new BMap.Size(20,0)});
				//	marker.setLabel(label);
					
					
					var opts = {
					  position : point,    // 指定文本标注所在的地理位置
					  offset   : new BMap.Size(-30, 0)    //设置文本偏移量
					}
	                var label1_text="<div style='border:1px solid red;width:158px;background:white'>"+username+"</div>"//"<div style='border:1px solid red;width:64px;background:white'>当前位置</div>
					var label1 = new BMap.Label(label1_text, opts);  // 创建文本标注对象
					label1.setStyle({
					color:"red",                   //颜色
					fontSize:"14px",               //字号
					fontWeight:"bold",
					border:"0",                    //边
					height:"24px",                //高度
					width:"158px",                 //宽
					textAlign:"center",            //文字水平居中显示
					lineHeight:"24px",            //行高，文字垂直居中显示
					//background:"url(http://cdn1.iconfinder.com/data/icons/CrystalClear/128x128/actions/gohome.png)",    //背景图片，这是房产标注的关键！
					cursor:"pointer"
					 });
					map.addOverlay(label1);   
					
					//
					
				//	map.panTo(new BMap.Point(116.69408,39.863447),11)
					//password=detail[i].password
					//alert(detail[i].id)
					//alert(detail[i].username);
					//btnAddRow(userid,username,password);
				}
	 //ending load
	
	});
	}
	
	$('#myButton').on('click', function () {
 
	//alert("test");
	window.open("gps_points/gps_points_search.asp?username=a", '_blank','resizable=no,menubar=no,status=no,scrollbars=no,location=no,top=200,left=400,toolbar=no,width=220,height=320');
 	 })
	  $('#myButton2').on('click', function () {
 
	//alert("test");
	window.open("gps_points/gps_points_search.asp?username=a", '_blank','resizable=no,menubar=no,status=no,scrollbars=no,location=no,top=200,left=400,toolbar=no,width=220,height=320');
 	 })
	 
	 $('#myButton3').on('click', function () {
 
	//alert("test");
	window.open("gps_points/gps_points_search.asp?username=a", '_blank','resizable=no,menubar=no,status=no,scrollbars=no,location=no,top=200,left=400,toolbar=no,width=220,height=320');
 	 })
	  $('#myButton4').on('click', function () {
 
	//alert("test");
	window.open("gps_points/gps_points_search.asp?username=a", '_blank','resizable=no,menubar=no,status=no,scrollbars=no,location=no,top=200,left=400,toolbar=no,width=220,height=320');
 	 })
	  $('#myButton5').on('click', function () {
 
	//alert("test");
	window.open("gps_points/gps_points_search.asp?username=a", '_blank','resizable=no,menubar=no,status=no,scrollbars=no,location=no,top=200,left=400,toolbar=no,width=220,height=320');
 	 })
</script>
