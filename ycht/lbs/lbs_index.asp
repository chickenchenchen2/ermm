

<!DOCTYPE html>
<html lang="zh-CN">

  <script src="http://www.helloweba.com/demo/js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4yZc2wBOaRWDulfTBHT0rvnO"></script>
  <head>
    <meta charset="GB2312">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- ����3��meta��ǩ*����*������ǰ�棬�κ��������ݶ�*����*������� -->
    <meta name="description" content="">
    <meta name="author" content="">
  <style type="text/css">
		body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"΢���ź�";}
	#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"΢���ź�";}
		
	</style>

    <title>��Ա��λ</title>

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
	  <!--������νṹ��-->
 	 		<div class="col-md-4" style="padding:0px;margin:0px;">
	 				<!--��濪ʼ-->
									<div class="panel panel-default">
								 <div class="panel-heading">��Ա�б�</div>
								 <div class="panel-body" style="padding:0px;margin:0px;">
							 <!--��Ա�б�ʼ-->
									<div class="list-group">
									<a href="#" class="list-group-item">
									admin�˺�<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('admin')">��λ</button>
									<button type="button" class="btn btn-primary btn-xs" id="myButton">�켣</button>
				
									 </a>
									 <a href="#" class="list-group-item">
									A�˺�<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('a')">��λ</button>
									<button type="button" class="btn btn-primary btn-xs" id="myButton">�켣</button>
				
									 </a>
									 <a href="#" class="list-group-item">B�˺�<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('B15100150122')">��λ</button>
									<button type="button" class="btn btn-primary btn-xs" id="myButton2">�켣</button></a>
								 <a href="#" class="list-group-item">C�˺�<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('C13901175722')">��λ</button>
									<button type="button" class="btn btn-primary btn-xs" id="myButton3">�켣</button></a>
							 <a href="#" class="list-group-item">D�˺�<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('d15810534616')">��λ</button>
									<button type="button" class="btn btn-primary btn-xs" id="myButton4">�켣</button></a>
							 <a href="#" class="list-group-item">E�˺�<button type="button" class="btn btn-info btn-xs" style="margin-left:4px;" id="dingwei" onClick="showPosition('E13681017657')">��λ</button>
									<button type="button" class="btn btn-primary btn-xs id="myButton5"">�켣</button></a>
							 <script language="javascript">
							 
							 
							 </script>
								</div>
							  <!--��Ա�б����-->
						 </div>
							</div>


				<!--������-->
	 
	 
			 </div>
		 <!--�Ҳ��ͼ��-->
			<div class=" col-md-8" style="height:600px;"><div id="allmap">
			</div>
			 <!--�Ҳ��ͼ������-->
		</div> <!--row������ǩ -->

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
   
  </body>
</html>
<script type="text/javascript">

	// �ٶȵ�ͼAPI����
	var map = new BMap.Map("allmap");    // ����Mapʵ��
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // ��ʼ����ͼ,�������ĵ�����͵�ͼ����
	map.addControl(new BMap.MapTypeControl());   //��ӵ�ͼ���Ϳؼ�
	map.setCurrentCity("����");          // ���õ�ͼ��ʾ�ĳ��� �����Ǳ������õ�
	map.enableScrollWheelZoom(true);     //��������������
	
	
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
			// var jsonObj = eval('(' + jsonData + ')'); // ok  ����json����
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
					//map.addOverlay(marker);            //���ӵ�
					//��ӵ�ǰλ������
					var marker = new BMap.Marker(point);  // ������ע
					map.addOverlay(marker);              // ����ע��ӵ���ͼ��
				
					//var label = new BMap.Label("�ҵ�λ��",{offset:new BMap.Size(20,0)});
				//	marker.setLabel(label);
					
					
					var opts = {
					  position : point,    // ָ���ı���ע���ڵĵ���λ��
					  offset   : new BMap.Size(-30, 0)    //�����ı�ƫ����
					}
	                var label1_text="<div style='border:1px solid red;width:158px;background:white'>"+username+"</div>"//"<div style='border:1px solid red;width:64px;background:white'>��ǰλ��</div>
					var label1 = new BMap.Label(label1_text, opts);  // �����ı���ע����
					label1.setStyle({
					color:"red",                   //��ɫ
					fontSize:"14px",               //�ֺ�
					fontWeight:"bold",
					border:"0",                    //��
					height:"24px",                //�߶�
					width:"158px",                 //��
					textAlign:"center",            //����ˮƽ������ʾ
					lineHeight:"24px",            //�иߣ����ִ�ֱ������ʾ
					//background:"url(http://cdn1.iconfinder.com/data/icons/CrystalClear/128x128/actions/gohome.png)",    //����ͼƬ�����Ƿ�����ע�Ĺؼ���
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
