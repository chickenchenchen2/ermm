<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>

<!DOCTYPE html>
<html lang="zh-CN">

  <script src="js/jquery-1.9.1.min.js"></script>

  <head>
    <meta charset="GB2312">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- ����3��meta��ǩ*����*������ǰ�棬�κ��������ݶ�*����*������� -->
    <meta name="description" content="">
    <meta name="author" content="">


    <title>��Ա��λ</title>

 
  </head>

  <body>

   


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
   
  </body>
</html>
<script type="text/javascript">

	//post��ȡͬ�ǳ���λ��
	
	 $.post(
      'http://112.126.69.176:8080/server-interface/getFriendsByPosition',
     {'id':'860527010207000','longitude':'116.1212','latitude':'36.898'},
      function (data) //�ش�����
      {
	  alert("sdf")
	  alert(data)
      //  var myjson='';
       // eval_r('myjson=' + data + ';');
      //  $('#result').html("����:" + myjson.username + "<br/>����:" + myjson['job']);
      }
    );
	
	
</script>
