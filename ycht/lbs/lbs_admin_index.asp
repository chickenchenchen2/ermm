

<!DOCTYPE html>
<html lang="zh-CN">
 
  <script src="js/jquery-1.9.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
  <head>
    <meta charset="GB2312">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- ����3��meta��ǩ*����*������ǰ�棬�κ��������ݶ�*����*������� -->
    <meta name="description" content="">
    <meta name="author" content="">
  <style type="text/css">
		
		
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
 	 <div class="col-md-2" style="padding:0px;margin:0px;">
	 			<!--��濪ʼ-->
				<div class="panel panel-default">
 				 <div class="panel-heading">�����б�</div>
 				 <div class="panel-body" style="padding:0px;margin:0px;">
		     <!--��Ա�б�ʼ-->
  					<div class="list-group">
 				 <a href="#" class="list-group-item" onClick="showForm('home')">
   					�û�����

 					 </a>
					 <a href="#" class="list-group-item" onClick="showForm('profile');">�켣����</a>
 					 <a href="#" class="list-group-item">�˳�</a>
 				 <!-- <a href="#" class="list-group-item">�ž���</a>
			 <a href="#" class="list-group-item">�ž���</a>
 			 <a href="#" class="list-group-item">�ž���</a>-->
				</div>
			  <!--��Ա�б����-->
 		 </div>
			</div>


				<!--������-->
	 
	 
	 </div>
	 <!--�Ҳ������-->
 	 <div class=" col-md-10">
	 <!--��ǩ ��ʼ-->
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
	<!--home���忪ʼ-->
	
					<div class="panel panel-default">
  						<!-- Default panel contents -->
  						<div class="panel-heading">����
  	

 								<button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">
	
 								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> ���</button>
	   												<!--ģ̬��-->
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
							<td>�û�ID</td>
							<td>�û���</td>
							<td>�û�����</td>
							<td>�û�����</td>
						  </tr>
						
						</table>
						  </div> 
	 		</div>
	<!--home�������-->
	</div>
    <div role="tabpanel" class="tab-pane fade" id="profile">
	<!--home���忪ʼ-->
	ccc
	<!--home�������-->
	</div>
    <div role="tabpanel" class="tab-pane fade" id="messages">ccccccccccccccccccc</div>
    <div role="tabpanel" class="tab-pane fade" id="settings">efefef</div>
  </div>

</div>
	 <!--��ǩ ����-->
	 
	 <!--�Ҳ����������-->
		</div>

    </div> <!-- /container -->


   

   
  </body>
</html>
<script>
$(document).ready(function(){
 
 //���user�б�
  jQuery.post("http://www.gtwhp.com/ps/json_userInfoSearch_lbs.asp?start=0&limit=100",function(data,status){
        
   alert("Data: " + data + "\nStatus: " + status);
	// var jsonObj = eval('(' + jsonData + ')'); // ok  ����json����
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
 
 
  

 //����
 
});
function btnAddRow(userid,username,password){
    //�к��Ǵ�0��ʼ�����һ����������ɾ�������水ť�� �ʼ�ȥ2
	alert("�������")
	//alert(userid)
    var rownum=$("#myTable tr").length-1;
    //var chk="<input type=checkbox id=chk_"+rownum+" name=chk_"+rownum+"/>";
   // var text="<input type=text id=txt_"+rownum+" name=txt_"+rownum+" width=75px/>";
    //var sel="<select id=sel_"+rownum+"><option value=1>��</option><option value=0>Ů</option></select>";
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

