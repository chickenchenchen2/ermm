<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>

<!DOCTYPE html>
<html lang="zh-CN">
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
    <script src="js/bootstrap.min.js"></script>
  </head>

  <body>

    <div class="container">

      <div class="row">
	  <!--左侧树形结构栏-->
 	 <div class="col-md-2" style="padding:0px;margin:0px;">
	 			<!--面版开始-->
				<div class="panel panel-default">
 				 <div class="panel-heading">功能列表</div>
 				 <div class="panel-body" style="padding:0px;margin:0px;">
		     <!--人员列表开始-->
  					<div class="list-group">
 				 <a href="#" class="list-group-item">
   					用户管理

 					 </a>
 					 <a href="#" class="list-group-item">退出</a>
 				 <!-- <a href="#" class="list-group-item">张经理</a>
			 <a href="#" class="list-group-item">张经理</a>
 			 <a href="#" class="list-group-item">张经理</a>-->
				</div>
			  <!--人员列表结束-->
 		 </div>
			</div>


				<!--面版结束-->
	 
	 
	 </div>
	 <!--右侧管理栏-->
 	 <div class=" col-md-10">
	 	<div class="panel panel-default">
  <!-- Default panel contents -->
  <div class="panel-heading">管理
  	

 	<button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">
	
 	<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 添加
 	</button>
	   <!--模态框-->
   <!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
	
  
  </div>
  <div class="panel-body">
   <table  class="table table-bordered">
  <tr>
    <td>用户ID</td>
    <td>用户名</td>
    <td>用户密码</td>
    <td>用户别名</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
  </div>

  <!-- Table -->
  <table class="table">
    ...
  </table>
</div>
	 		
	 
	 
	 </div>
	 <!--右侧管理栏结束-->
		</div>

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
   

   
  </body>
</html>

