var map;
//存储单条网点信息
function initMap(){
	// 百度地图API功能
	map = new BMap.Map("mymap");    // 创建Map实例
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.setCurrentCity("tianjin");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	//alert("dfdf")
    getJsonData(0,300);//获取所有数据绘制点

}
function point(){
 //this.name=name;
 /*
	name 名字
	lat  纬度
	lng  经度
 */
 this.setName=function (name){
	 this.name=name;  
 
 }
 this.getName=function(){
	    if(!this.name)
		{
			return null;
		}
		else
		{
		return this.name;
		}
 }
 this.setLat=function(lat){
	  this.lat=lat;
 }
 this.setLng=function(lng){
	  this.lng=lng
 }
}
//show POI

function showAll(JsonData){
	//alert(JsonData.myroot[0].id)
	//alert(JsonData.mytotal)
	 
		
	
     var dataObj=eval("("+JsonData+")");//转换为json对象 
	 //alert(dataObj.mytotal)
	 var lnglatArr=[];
	 $.each(dataObj.root, function(i, item) {     //解析JSON数组
		//alert(item.id+"-----root-------"+item.address+item.lng+item.lat); 
		drawPoint(item)
		var lnglat = new BMap.Point(item.lng,item.lat);
		lnglatArr.push(lnglat);
	 }); 
	 var params = map.getViewport(lnglatArr);
	 							map.setZoom(params.zoom);
	 							map.panTo(params.center);
}

//在地图上绘制点
function drawPoint(item){
	
var marker = new BMap.Marker(new BMap.Point(item.lng, item.lat));
map.addOverlay(marker); //增加点
var label = new BMap.Label(item.businessname,{offset:new BMap.Size(20,-10)});
marker.setLabel(label);//为标注增加文字注记
//为marker添加弹出窗
var html=windowHtml(item);
//alert(html)
marker.addEventListener("click",getClickCallBackCustomer(marker,html,item.businessname))

}

//get json数据
function getJsonData(num1,num2,keyword,goodstype){
	var JsonData;
	$.post("http://www.ermm.cn/ermm10/json_projectInfoSearch_client.asp",{
			start:num1,
			limit:num2,
			goodstype:goodstype,
			keyValue:keyword
		},
		function(data,status){
			//alert("数据: \n" + data + "\n状态: " + status);
			JsonData=data;
			
			showAll(JsonData);
		});


}


//弹出框内面版HTML设置
function windowHtml(item)
{
	var html="网点名称："+item.businessname+"<br>";
			//html+="地址："+item.address+"<br>";
			//html+="联系电话："+item.iconname+"<br>";
			//html+='网址：<a href="#" onclick="window.open(\''+item.url+'\')">'+item.url+'</a><br>';
			//html+="详细内容："+item.info+"<br>";//2013-1-5修改 将备注信息加入到弹出窗显
			html+="<select  id='peisong' class=\"easyui-combobox\" name=\"peisong\" style=\"width:200px;\">";
			html+="<option value=\"zhangsan\">张三</option><option value=\"wangwu\">王五</option><option value=\"zhaoliu\">赵六</option>";
			html+="</select>";
			html+="<br>";
			//html+="<a href=\"#\" class=\"easyui-linkbutton\" onclick=\"addValue('"+item.businessname+"','zhangsan')\>派单</a>"
			html+="<a href=\"javascript:void(0)\" class=\"easyui-linkbutton\" onclick=\"addValue('\"+item.businessname+\"','zhangsan')\">派单</a>"
			html="<div style='text-align:left'>"+html+"</div>"
     return html;
}

//往配送员列表添加数据

function addValue(txt,txt2){
	alert(txt)
		//txt2 = $('#peisong').combobox('getValue')
		alert(txt2)
 //$('#zhangsan').datalist('appendRow',txt);
 $('#zhangsan').datalist('appendRow',{text:txt});
}
//鼠标浮动及单击事件方法
function getClickCallBackCustomer(marker,html,name)
{
	//alert("aa")
	//alert(name);
	return function(){
		if(typeof infoWindow != "undefined")
		{
			map.removeOverlay(infoWindow);
		}
		//infoWin=marker.openInfoWinHtml(html);
		//infoWin.setTitle(name);
		//infoWin.moveToShow();
		
		var infoWindowTemp = new BMap.InfoWindow("<font style='font-size:12px'>"+html+"</font>",{offset:new BMap.Size(0,-20)});
		infoWindowTemp.setTitle("<font style='font-weight:600'>"+name+"</font>");
		infoWin=marker.openInfoWindow(infoWindowTemp);
		
	}
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