

<!DOCTYPE html>
<html lang="zh-CN">
 
  <script src="js/jquery-1.9.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
  <head>
    <meta charset="GB2312">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
  <style type="text/css">
		
		
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
 	 <div class="col-md-2" style="padding:0px;margin:0px;">
	 			<!--面版开始-->
				<div class="panel panel-default">
 				 <div class="panel-heading">功能列表</div>
 				 <div class="panel-body" style="padding:0px;margin:0px;">
		     <!--人员列表开始-->
  					<div class="list-group">
 				 <a href="#" class="list-group-item" onClick="showForm('home')">
   					用户管理

 					 </a>
					 <a href="#" class="list-group-item" onClick="showForm('profile');">轨迹数据</a>
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
	 <!--标签 开始-->
	<div role="tabpanel">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist" id="myTab">
    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Home</a></li>
    <li role="presentation" style="display:none;" id="test"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Profile</a></li>
    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Messages</a></li>
    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Settings</a></li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="home">
	<!--home窗体开始-->
	
					<div class="panel panel-default">
  						<!-- Default panel contents -->
  						<div class="panel-heading">管理
  	

 								<button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">
	
 								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 添加</button>
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
						   <table  class="table table-bordered" id="myTable">
						  <tr>
							<td>用户ID</td>
							<td>用户名</td>
							<td>用户密码</td>
							<td>用户别名</td>
						  </tr>
						
						</table>
						  </div> 
	 		</div>
	<!--home窗体结束-->
	</div>
    <div role="tabpanel" class="tab-pane fade" id="profile">
	<!--home窗体开始-->
	ccc
	<!--home窗体结束-->
	</div>
    <div role="tabpanel" class="tab-pane fade" id="messages">ccccccccccccccccccc</div>
    <div role="tabpanel" class="tab-pane fade" id="settings">efefef</div>
  </div>

</div>
	 <!--标签 结束-->
	 
	 <!--右侧管理栏结束-->
		</div>

    </div> <!-- /container -->


   

   
  </body>
</html>
<script>
$(document).ready(function(){
 
 //填充user列表
  jQuery.post("http://www.gtwhp.com/ps/json_userInfoSearch_lbs.asp?start=0&limit=100",function(data,status){
        
   alert("Data: " + data + "\nStatus: " + status);
	// var jsonObj = eval('(' + jsonData + ')'); // ok  创建json对象
    var jsonObj=eval('(' + data + ')');
	//alert(jsonObj.mytotal)
	var userid,username,password
	var detail=jsonObj.root;
	for(i=0;i<detail.length;i++)
	{
			alert(detail[i].username)

	    userid=detail[i].id
		username=detail[i].username
		password=detail[i].password
		//alert(detail[i].id)
		//alert(detail[i].username);
		btnAddRow(userid,username,password);
	}
	
	
	

	//var obj=jQuery.parseJSON('{ name: "CodePlayer", age: 1 }');
	//alert(jsonObj.root[0].username);
	//btnAddRow();
	//alert(obj)
 });
 
 
  

 //结束
 
});
function btnAddRow(userid,username,password){
    //行号是从0开始，最后一行是新增、删除、保存按钮行 故减去2
	alert("表格增加")
	//alert(userid)
    var rownum=$("#myTable tr").length-1;
    //var chk="<input type=checkbox id=chk_"+rownum+" name=chk_"+rownum+"/>";
   // var text="<input type=text id=txt_"+rownum+" name=txt_"+rownum+" width=75px/>";
    //var sel="<select id=sel_"+rownum+"><option value=1>男</option><option value=0>女</option></select>";
	//var  =username
		
				var text=username
	
    var row="<tr><td>"+userid+"</td><td>"+username+"</td><td>"+password+"</td><td>"+text+"</td></tr>";
    $(row).insertAfter($("#myTable tr:eq("+rownum+")"));   
}
function showForm(str){
	if(str=="profile")
		{
			$('#myTab a[href="#profile"]').tab('show')
			$('#test').css("display","block")
		}
	if(str=="home")
		{
			$('#myTab a[href="#home"]').tab('show')
		}

}
</script>

