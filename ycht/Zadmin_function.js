
//加载所有信息点数据
function initData(){
	// 百度地图API功能
	
     getJsonData(0,3);

}
//得到行号
function getId()
{
 $("#pointInfo tr td input:checkbox").each(function(){alert($(this).next().text());})
}




function showAll(JsonData){
	//alert(JsonData.myroot[0].id)
	//alert(JsonData.mytotal)
	 
		
	
     var dataObj=eval("("+JsonData+")");//转换为json对象 
	 //alert(dataObj.mytotal)
	 $.each(dataObj.root, function(i, item) {     //解析JSON数组
		//alert(item.id+"-----root-------"+item.address+item.lng+item.lat); 
		//alert(item.address+" "+item.id)
		
		 var html="<tr>";
		 //i+1
		  html+="<td><input type='checkbox' id='"+i+1"'/></td>";   //
			 html+="<td>"+item.id+"</td>";   //
			  html+="<td>"+item.businessname+"</td>";   //
			   html+="<td>"+item.address+"</td>";   //
			    html+="<td>"+item.goodstype+"</td>";   //
				 html+="<td>"+item.v1+"</td>";   //
				  html+="<td>"+item.iconname+"</td>";   //
				  
		    
		 $("#pointInfo tbody").append(html);//给表格添加信息
		
		//drawPoint(item)
	 }); 
}
//get json数据
function getJsonData(num1,num2,keyword,goodstype){
	var JsonData;
	$.post("http://www.gtwhp.com/ps/json_projectInfoSearch_client.asp",{
			start:num1,
			limit:num2,
			goodstype:goodstype,
			keyValue:keyword
		},
		function(data,status){
			//alert("数据: \n" + data + "\n状态: " + status);
			JsonData=data;
			
			showAll(JsonData);//返回数据后拼接成表格
		});


}

//弹出框内面版HTML设置
function windowHtml(item)
{
	var html="网点名称："+item.businessname+"<br>";
			html+="地址："+item.address+"<br>";
			html+="联系电话："+item.iconname+"<br>";
			html+='网址：<a href="#" onclick="window.open(\''+item.url+'\')">'+item.url+'</a><br>';
			html+="详细内容："+item.info+"<br>";//2013-1-5修改 将备注信息加入到弹出窗显
			html="<div style='text-align:left'>"+html+"</div>"
     return html;
}

//tree
		<!--
		//var setting = {
		//	view: {
		//		dblClickExpand: false
		//	},
		//	data: {
		//		simpleData: {
		//			enable: true
		//		}
		//	},
		//	callback: {
		//		beforeClick: beforeClick,
		//		onClick: onClick
		//	}
		//};
				<!--
		var setting = {
			async: {
				enable: true,
				url:"http://www.gtwhp.com/ps/jsonTreeZc.asp",
				autoParam:["id", "name=n", "level=lv"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter
			},
			callback: {
				beforeClick: beforeClick,
				onClick: onClick
			}
		};

		var zNodes =[
			{id:1, pId:0, name:"北京"},
			{id:2, pId:0, name:"天津"},
			{id:3, pId:0, name:"上海"},
			{id:6, pId:0, name:"重庆"},
			{id:4, pId:0, name:"河北省", open:true},
			{id:41, pId:4, name:"石家庄"},
			{id:62, pId:41, name:"石家庄"},
			{id:42, pId:4, name:"保定"},
			{id:43, pId:4, name:"邯郸"},
			{id:44, pId:4, name:"承德"},
			{id:5, pId:0, name:"广东省", open:true},
			{id:51, pId:5, name:"广州"},
			{id:52, pId:5, name:"深圳"},
			{id:53, pId:5, name:"东莞"},
			{id:54, pId:5, name:"佛山"},
			{id:6, pId:0, name:"福建省", open:true},
			{id:61, pId:6, name:"福州"},
			{id:62, pId:6, name:"厦门"},
			{id:63, pId:6, name:"泉州"},
			{id:64, pId:6, name:"三明"}
		 ];
		function filter(treeId, parentNode, childNodes) {
			if (!childNodes) return null;
			for (var i=0, l=childNodes.length; i<l; i++) {
				childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
			}
			return childNodes;
		}

		function beforeClick(treeId, treeNode) {
			//var check = (treeNode && !treeNode.isParent);
			//if (!check) alert("只能选择城市...");
			//return check;
		}
		
		function onClick(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			v = "";
			nodes.sort(function compare(a,b){return a.id-b.id;});
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			var cityObj = $("#citySel");
			cityObj.attr("value", v);
		}

		function showMenu() {
			var cityObj = $("#citySel");
			var cityOffset = $("#citySel").offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}

//tree end