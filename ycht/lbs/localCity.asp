<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>

<!DOCTYPE html>
<html lang="zh-CN">

  <script src="js/jquery-1.9.1.min.js"></script>

  <head>
    <meta charset="GB2312">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">


    <title>人员定位</title>

 
  </head>

  <body>

   


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
   
  </body>
</html>
<script type="text/javascript">

	//post获取同城车友位置
	
	 $.post(
      'http://112.126.69.176:8080/server-interface/getFriendsByPosition',
     {'id':'860527010207000','longitude':'116.1212','latitude':'36.898'},
      function (data) //回传函数
      {
	  alert("sdf")
	  alert(data)
      //  var myjson='';
       // eval_r('myjson=' + data + ';');
      //  $('#result').html("姓名:" + myjson.username + "<br/>工作:" + myjson['job']);
      }
    );
	
	
</script>
