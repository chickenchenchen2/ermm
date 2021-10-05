
<%username=request("username")%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>查询轨迹</title>
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />

<style type="text/css">
a {
	color:#007bc4/*#424242*/;
	text-decoration:none;
}
a:hover {
	text-decoration:underline
}
ol, ul {
	list-style:none
}
table {
	border-collapse:collapse;
	border-spacing:0
}
body {
	height:100%;
	font:12px/18px Tahoma, Helvetica, Arial, Verdana, "\5b8b\4f53", sans-serif;
	color:#51555C;
}

.demo {
	width:500px;
	margin:20px auto
}
.demo h4 {
	height:32px;
	line-height:32px;
	font-size:14px
}


input {
	width:108px;
	height:20px;
	line-height:20px;
	padding:2px;
	border:1px solid #d3d3d3
}
</style>
<script type="text/javascript" src="http://www.helloweba.com/demo/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-datepicker.js"></script>
<script type="text/javascript">
$(function(){
	var username="<%=username%>"
	$("#datepicker").datepicker({
		showOtherMonths: true,
		selectOtherMonths: false,
		onSelect: function(dateText,inst){
		  //  alert("您选择的日期是："+dateText)
		    if(username.length<2)
			{
			username="B15100150122"
			}
			url="http://www.gtwhp.com/lbs/lbs/gps_points.asp?start=0\&limit=2000\&username="+username+"\&timeup="+dateText
		    window.open (url,'newwindow','height=800,width=700,top=100,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') 
			//alert("您选择的日期是："+dateText)
		}
	});

	
});
</script>
</head>
<body>
<div id="main" style="width:220px;height:320px;margin:0px;padding:0px">
 
  <div class="demo">
    <h4>请选择查询日期：</h4>
    <div id="datepicker"></div>
	
  </div>

</div>

</body>
</html>
