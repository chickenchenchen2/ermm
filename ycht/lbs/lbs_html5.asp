

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>定位+坐标转换</title>
<style type="text/css">
*{
    margin:0px;
    padding:0px;
}
body, button, input, select, textarea {
    font: 12px/16px Verdana, Helvetica, Arial, sans-serif;
}
</style>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&libraries=convertor"></script>
<script>
function getLocation(){
  if (navigator.geolocation)
    {
    navigator.geolocation.getCurrentPosition(showPosition);
    }
  else{x.innerHTML="浏览器不支持定位.";}
  }
function showPosition(position)
  {
var lat=position.coords.latitude; 
var lng=position.coords.longitude;
qq.maps.convertor.translate(new qq.maps.LatLng(lat,lng), 1, function(res){
     latlng = res[0];
  
  var map = new qq.maps.Map(document.getElementById("container"),{
        center:  latlng,
        zoom: 13
    });
   var marker = new qq.maps.Marker({
            map : map,
            position : latlng
        });
    });
  }
</script>

</head>
<body onLoad="getLocation()">
<div style="width:603px;height:300px" id="container"></div>
<p>用html5定位后，使用腾讯地图坐标转换接口纠偏，请允许获取位置。</p>
</body>
</html>


