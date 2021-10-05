<%@ codepage=65001%>
<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询系统</title>
<link rel="stylesheet" type="text/css" href="ext/ext-3.3.1/resources/css/ext-all.css"/>
<script type="text/javascript" src="ext/ext-3.3.1/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="ext/ext-3.3.1/ext-all.js"></script>
<script type="text/javascript" src="ext/ext-3.3.1/src/locale/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="citys/tree.js"></script>
<script type="text/javascript" src="citys/tree_checked.js"></script>
<script language="javascript" src="http://api.51ditu.com/js/maps.js"></script>
<script language="javascript" src="http://api.51ditu.com/js/ezmarker.js"></script>
<style type="text/css">v\:*{behavior:url(#default#VML);}</style>
<script type="text/javascript">
Ext.BLANK_IMAGE_URL = 'ext/ext-3.3.1/resources/images/default/s.gif';
var strSaleAreaTree = [<%=strSaleAreaTree%>];	//片区树
var maps;
//var areaColor = "";
var pageSize = 1000;	//每页显示的最大值

var markerArr = {};//储存marker点

var markerToolStart=null;

var circleSearch=null;

var markerToolMarker=null;

var ids = [];
var businessnames = [];
var addresss = [];
var goodstypes = [];
var lnglats = [];
var icons = [];
var iconnames = [];
var iconadresss = [];
var urls = [];
var infos = [];

Ext.onReady(function(){
	maps = new LTMaps( "myMap" );
	maps.centerAndZoom(new LTPoint(11684947,3829603),13);	//定位全国
	var standMapControl = new LTStandMapControl();
	maps.addControl(standMapControl);
	maps.handleMouseScroll(true);//启用鼠标滚轮功能支持,参数true代表使用鼠标指向点位置不变模式
	control=new LTPolyLineControl();//增加测距控件
	control.setTips("双击结束");//改变操作提示文字内容
	LTEvent.bind(maps,"dblclick",control,control.endDraw);//在双击地图的时候调用结束操作
	maps.addControl(control);
	controlm=new LTPolygonControl();
	controlm.setTips("双击结束");//改变操作提示文字内容
	LTEvent.bind(maps,"dblclick",controlm,controlm.endDraw);//在双击地图的时候调用结束操作
	maps.addControl(controlm);
	control.setVisible(false);
	controlm.setVisible(false);
	
    // 布局开始
    var viewport = new Ext.Viewport({
        layout:'border',
        items:[{
            region: 'north',
            contentEl: 'north-div',
            height: 55,
            bodyStyle: 'background-color:#BBCCEE;'
        },{
			region:'center',
			xtype:'panel',
			title:'地图',
			tbar:[
				{text:'放大',handler:function(){maps.zoomIn();}},
				{text:'缩小',handler:function(){maps.zoomOut()}},
				{text:'测距',handler:function(){control.btnClick();}},
				{text:'测面',handler:function(){controlm.btnClick();}},
				{text:'圈选',handler:function(){
					createMarkerStart();
				}},
				{text:'全部网点显示',handler:function(){
					maps.clearOverLays();
					Ext.Ajax.request({
						url:'json_projectInfoSearch_clientall.asp',
						method:'post',
						params:{
							uid:'uid'
						},
						success:function(req){
							//alert(req.responseText);
							var json = eval('('+req.responseText+')');
							var lnglatArr = [];
							for(var i=0;i<json.length;i++)
							{
								//alert(urls[i]);
								var html="名称："+json[i].businessname+"<br>";
								html+="地址："+json[i].address+"<br>";
								//html+="所属类型："+json[i].goodstype+"<br>";
								//html+="店铺网址：<a href='"+urls[i]+"'>"+urls[i]+"</a><br>";
								//html+=json[i].info+"<br>";
								html+="联系电话："+json[i].iconname+"<br>";
								//html+='网址：<a href="#" onclick="window.open(\''+json[i].url+'\')">'+json[i].url+'</a><br>';
								html+="详细内容："+json[i].info+"<br>";//2013-1-5修改 将备注信息加入到弹出窗显示
								
								//html+="<div><img src='"+json[i].iconadress+"' onerror='this.src=\"images/noimg.jpg\"' target='_blank' onmouseover='imgZoomIn(this)' onmouseout='imgZoomOut(this)' style='width:210px;height:160px;'/></div>";
								
								var icon2=new LTIcon("markerIcon/"+json[i].icon,[20,20],[10,20]);//创建一个图标
								var lnglat = new LTPoint(json[i].lng,json[i].lat);
								var marker = new LTMarker(lnglat,icon2);
								maps.addOverLay(marker);
								html="<div style='text-align:left'>"+html+"</div>"
								//LTEvent.addListener( marker , "click" ,getClickCallBackCustomer(marker,html,json[i].businessname,i));
								LTEvent.addListener( marker , "mouseover" ,getClickCallBackCustomer(marker,html,json[i].businessname,i));//2013-1-5客户要求鼠标浮动后弹出框
								lnglatArr.push(lnglat);
							}
							maps.getBestMap(lnglatArr);
							//maps.moveToCenter(new LTPoint(11853475,3745394),1)//将地图固定在东营商贸园
						}
					});
				}},
				{text:'打印',handler:function(){printMap(maps)}}
			],
			//bbar:[{text:'全部网点显示',handler:function(){maps.clearOverLays();
//				customerJsonStore.removeAll();
//				customerJsonStore.load({params: {start:0,limit:pageSize,citycode:"",type:"init"},callback:function(r,options,success){if(ds.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}});
//					//加载JSON数据给地图对象
//					ds.addListener('load', function(st, rds, opts){
//						if(maps)
//						{
//							maps.clearOverLays();
//						}
//					});
//				}
//			}],
			tools:[{id:""}],
			listeners:{"bodyresize":function(){if(typeof(maps)=="object"){maps.resizeMapDiv();}}},//监控地图大小改变后,地图自适应
			contentEl:'myMap'
		}
		,{
            region: 'south',
            contentEl: 'south-div',
            height: 20,
            bodyStyle: 'background-color:#BBCCEE;'
        }
		,{
            //region: 'east',
			region: 'west',
			collapsible:true,
            split: true,
            border: true,
            //layout: 'border',
			layout: 'accordion',
			layoutConfig:{
				titleCollapse:true,
				animate:true,
				activeOnTop:false
			},
			width:300,
            items: [formCustomerSearch,grid]
        }
		]
    });
    // 布局结束
	//地图打印
	function printMap(maps)
	{
		var html = "<!DOCTYPE HTML\">\n";
		html += (document.all)?"<html xmlns:v=\"urn:schemeas-microsoft-com:vml\">":"<html>";
		html += "\n<head>\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">\n<title>Print Maps<\/title>\n";
		html += "<style type=\"text\/css\">\nbody {margin: 0px;}\n";
		html += (document.all)?"v\\:*{ Behavior:url(#default#VML);}":"";
		html += "\n</style>\n";
		html += "<\/head>\n";
		html += "<body><right>\n";
		html += maps.getMapContent(0);//改变"0"这个参数，可以将地图之中的标注也打印到地图，具体请参照类参考文档之中的getMapContent说明
		html += "\n<\/right><\/body>\n<\/html>";
		var win = window.open("about:blank","win","menubar=1,width="+(maps.container.offsetWidth)+",height="+(maps.container.offsetHeight-20));
		win.document.writeln(html);
		win.moveTo(0,0);
		win.print();
		win.document.close();	
		win.close();
	}
	//Ext.fly(Ext.get('treeCitysSearch')).setHeight(parseInt(document.body.clientHeight)-122-108,true)
	//treeCitysSearch.setHeight(parseInt(document.body.clientHeight)-122-117);
	
	//3745791,11852917;3744815,11852907;3744715,11855042;3744962,11855167;3745250,11855166;3745791,11855162;3745797,11853903
	
	//var option = new LTLineOptions(); 
//	//生成折线的点数组 
//	var points = new Array();
//	//points.push( new LTPoint( 11852916 , 3745359 ) );
//	//points.push( new LTPoint( 11852896 , 3744822 ) );
//	//points.push( new LTPoint( 11855067 , 3744713 ) );
//	//points.push( new LTPoint( 11855137 , 3744937 ) );
//	//points.push( new LTPoint( 11855181 , 3745251 ) );
//	//points.push( new LTPoint( 11855178 , 3745797 ) );
//	//points.push( new LTPoint( 11854055 , 3745795 ) );
//	//points.push( new LTPoint( 11852899 , 3745805 ) );
//	//points.push( new LTPoint( 11852916 , 3745551 ) );
//	//points.push( new LTPoint( 11852916 , 3745359 ) );
//	points.push( new LTPoint(11853315,3745799) );
//	points.push( new LTPoint(11853317,3745710) );
//	points.push( new LTPoint(11853316,3745651) );
//	points.push( new LTPoint(11853223,3745608) );
//	points.push( new LTPoint(11853202,3745543) );
//	points.push( new LTPoint(11853136,3745307) );
//	points.push( new LTPoint(11853085,3745044) );
//	points.push( new LTPoint(11853064,3744912) );
//	points.push( new LTPoint(11853073,3744790) );
//	points.push( new LTPoint(11853515,3744788) );
//	points.push( new LTPoint(11853953,3744771) );
//	points.push( new LTPoint(11854488,3744751) );
//	points.push( new LTPoint(11855043,3744722) );
//	points.push( new LTPoint(11855146,3744943) );
//	points.push( new LTPoint(11855164,3745351) );
//	points.push( new LTPoint(11855179,3745760) );
//	points.push( new LTPoint(11855160,3745803) );
//	points.push( new LTPoint(11855089,3745808) );
//	points.push( new LTPoint(11854948,3745801) );
//	points.push( new LTPoint(11854685,3745794) );
//	points.push( new LTPoint(11854186,3745797) );
//	points.push( new LTPoint(11853694,3745804) );
//	points.push( new LTPoint(11853315,3745803) );
//	option.points = points;
//	//根据点数组创建一条折线 
//	polyLine = new LTLineOverlay(option); 
//	//将折线添加到地图 
//		
//	maps.overlayManager.addOverLay(polyLine); 
//	polyLine.setLineStroke(4);
//	polyLine.setOpacity(0.7);
//	polyLine.setLineStyle("ShortDash");//设置成虚线
//	//polyLine.setFillColor("");
//	polyLine.setLineColor("red");
	
	
	
	/*Ext.Ajax.request({
		url:'json_projectInfoSearch_clientall.asp',
		method:'post',
		params:{
			uid:'uid'
		},
		success:function(req){
			//alert(req.responseText);
			var json = eval('('+req.responseText+')');
			var lnglatArr = [];
			for(var i=0;i<json.length;i++)
			{
				//alert(urls[i]);
				var html="名称："+json[i].businessname+"<br>";
				html+="地址："+json[i].address+"<br>";
				//html+="所属类型："+json[i].goodstype+"<br>";
				//html+="店铺网址：<a href='"+urls[i]+"'>"+urls[i]+"</a><br>";
				//html+=json[i].info+"<br>";
				html+="联系电话："+json[i].iconname+"<br>";
				//html+='网址：<a href="#" onclick="window.open(\''+json[i].url+'\')">'+json[i].url+'</a><br>';
				html+="详细内容："+json[i].info+"<br>";//2013-1-5修改 将备注信息加入到弹出窗显示
				
				//html+="<div><img src='"+json[i].iconadress+"' onerror='this.src=\"images/noimg.jpg\"' target='_blank' onmouseover='imgZoomIn(this)' onmouseout='imgZoomOut(this)' style='width:210px;height:160px;'/></div>";
				
				var icon2=new LTIcon("markerIcon/"+json[i].icon,[20,20],[10,20]);//创建一个图标
				var lnglat = new LTPoint(json[i].lng,json[i].lat);
				var marker = new LTMarker(lnglat,icon2);
				maps.addOverLay(marker);
				html="<div style='text-align:left'>"+html+"</div>"
				//LTEvent.addListener( marker , "click" ,getClickCallBackCustomer(marker,html,json[i].businessname,i));
				LTEvent.addListener( marker , "mouseover" ,getClickCallBackCustomer(marker,html,json[i].businessname,i));//2013-1-5客户要求鼠标浮动后弹出框
				lnglatArr.push(lnglat);
			}
			maps.getBestMap(lnglatArr);
			//maps.moveToCenter(new LTPoint(11853475,3745394),1)//将地图固定在东营商贸园
		}
	});*/
});

Ext.EventManager.onWindowResize(function(width,height){//改变窗口的时候会提示出窗口的宽高
	//treeCitysSearch.setHeight(parseInt(height)-122-117);
});

function createMarkerStart()
{
	maps.clearOverLays();
	//标注开始--------------------------------- 
	optionStart=new LTMarkerToolOptions(); 
	//将当前地图对象保存 必传 
	optionStart.map=maps;
	
	//是否可编辑 
	optionStart.editable=false; 
	//设置偏移量 
	optionStart.offset=[2,0];
	optionStart.icon=new LTIcon("images/tack.gif", [78,39], [39,39]);
	//创建标注工具 
	markerToolStart=new LTMarkerTool(optionStart);
	markerToolStart.open(false);
	LTEvent.addListener(markerToolStart,"drawend",function(obj){
		//alert(obj.getPoint().getLongitude()+","+obj.getPoint().getLatitude());
		//pointStart.push(obj.getPoint().getLongitude()+","+obj.getPoint().getLatitude());
		//pointStart=obj.getPoint();
		//alert(obj.getPoint().getLongitude()+","+obj.getPoint().getLatitude());
		//var infoWin=obj.openInfoWinHtml("<input type='button' value='周边搜索' onclick='alert(0);'");
		//infoWin.setTitle(name);
		//infoWin.moveToShow();
		/*markerToolMarker = obj;
		LTEvent.addListener(obj, "click", function(){
			//alert(1);
			obj.openInfoWindow("周边1.5公里搜索","<div style='width:250px'><input type='text' id='nearSearch'/>&nbsp;&nbsp;<input type='button' value='周边搜索' onclick='searcNearFun("+obj.getPoint().getLongitude()+","+obj.getPoint().getLatitude()+")'/></div>");
		});
		obj.openInfoWindow("周边1.5公里搜索","<div style='width:250px'><input type='text' id='nearSearch'/>&nbsp;&nbsp;<input type='button' value='周边搜索' onclick='searcNearFun("+obj.getPoint().getLongitude()+","+obj.getPoint().getLatitude()+")'/></div>");*/
		/*var infoWindow =new LTInfoWindow(obj.getPoint(),[0,-20]);
		infoWindow.setTitle("周边1.5公里搜索"); 
		infoWindow.setLabel("<input type='button' value='周边搜索' onclick='alert(0);'");
		maps.addOverLay(infoWindow);*/
		
		var option = new LTCircleOptions();
		/*//线的颜色 
		option.lineColor=color;
		//线的宽度
		option.weight=stroke;
		//线的样式 
		option.lineStyle=style;
		//线的透明度 
		option.opacity=opacity;
		//圆形的填充色 
		option.fillColor=bgcolor;
		//是否可编辑 
		option.editable=isEdit;*/
		//获得圆半径的单位，米：meter,像素：pixel，经纬度：point，默认值meter 
		option.unit="meter"; 
		option.centerPoint=obj.getPoint(); 
		option.radius=1000;
		//创建圆形对象 
		circleSearch = new LTCircleOverlay(option); 
		//将圆形添加到地图
		maps.overlayManager.addOverLay(circleSearch);
		circleSearch.getObject().style.zIndex = 0;
		
		markerToolStart.close();
		
		searcNearFun(obj.getPoint().getLongitude(),obj.getPoint().getLatitude());
	});
}

function searcNearFun(lng,lat)
{
	//var nearSearch = document.getElementById("nearSearch");
	//if(nearSearch)
	//{
	Ext.Ajax.request({
		url:'json_wangdianInfoSearchPhone.asp',
		method:'post',
		params:{
			positionLng:lng,
			positionLat:lat,
			searcNearValue:"",
			radioDistanceValue:1000
		},
		success: function(resp,opts){
			//markerToolMarker.closeInfoWindow();
			var json = Ext.util.JSON.decode(resp.responseText);
			if(json.length==0)
			{
				Ext.MessageBox.alert('提示', "搜索无结果");
				return;
			}
			//alert(jsonObj);
			//jsonObj = eval("("+jsonObj+")");
			var lnglatArr = [];
			for(var i=0;i<json.length;i++)
			{
				//alert(urls[i]);
				var html="名称："+json[i].businessname+"<br>";
				html+="地址："+json[i].address+"<br>";
				//html+="所属类型："+json[i].goodstype+"<br>";
				//html+="店铺网址：<a href='"+urls[i]+"'>"+urls[i]+"</a><br>";
				//html+=json[i].info+"<br>";
				html+="联系电话："+json[i].iconname+"<br>";
				//html+='网址：<a href="#" onclick="window.open(\''+json[i].url+'\')">'+json[i].url+'</a><br>';
				html+="详细内容："+json[i].info+"<br>";//2013-1-5修改 将备注信息加入到弹出窗显示
				
				//html+="<div><img src='"+json[i].iconadress+"' onerror='this.src=\"images/noimg.jpg\"' target='_blank' onmouseover='imgZoomIn(this)' onmouseout='imgZoomOut(this)' style='width:210px;height:160px;'/></div>";
				
				var icon2=new LTIcon("markerIcon/"+json[i].icon,[20,20],[10,20]);//创建一个图标
				var lnglat = new LTPoint(json[i].lng,json[i].lat);
				var marker = new LTMarker(lnglat,icon2);
				maps.addOverLay(marker);
				html="<div style='text-align:left'>"+html+"</div>"
				//LTEvent.addListener( marker , "click" ,getClickCallBackCustomer(marker,html,json[i].businessname,i));
				LTEvent.addListener( marker , "mouseover" ,getClickCallBackCustomer(marker,html,json[i].businessname,i));//2013-1-5客户要求鼠标浮动后弹出框
				lnglatArr.push(lnglat);
			}
			maps.getBestMap(lnglatArr);
		}
	});
	//}
}

//-----------------------------------------客户信息查询开始-----------------------------------------------
/*var class_store = new Ext.data.JsonStore({url: "json_departmentInfoSearch.asp",root: "root",totalProperty: 'mytotal',remoteSort:true,baseParams:{limit:20000},
	fields: ["id", "departmentName"]
});
class_store.load({params: {start:0,departmentKeyWord:""}});*/

var comboxWithTreeWangDian = new Ext.form.ComboBox({
	hiddenName:"goodstype",
	store:new Ext.data.SimpleStore({fields:[],data:[[]]}),
	fieldLabel: '所属类别',
	//emptyText:"请选择类别",
	editable:false,
	//expanded:true,
	//shadow:false,
	mode: 'local',
	triggerAction:'all',
	//height:350,
	tpl: '<tpl for="."><div style="height:200px"><div id="treeWangDianSaleArea"></div></div></tpl>',
	selectedClass:'',
	onSelect:Ext.emptyFn,
	onViewClick : Ext.emptyFn,
	assertValue : Ext.emptyFn,
	//allowBlank:false,
	//blankText: '所属类别不能为空'
	//,
	value:"请选择类别"
});
treeWangDianSaleArea = new Ext.tree.TreePanel({
	containerScroll: true,//是否支持滚动条
	split: true,
	rootVisible:false,
	autoScroll: true,
	border:false,
	//height:350,
	loader: new Ext.tree.TreeLoader({dataUrl:'json_saleTypeTree.asp'}),
	root:new Ext.tree.AsyncTreeNode({id:'0',text:'root',expanded:true})
});
treeWangDianSaleArea.on('click',function(node,e){
	comboxWithTreeWangDian.setValue(node.text);
	comboxWithTreeWangDian.collapse();
});
comboxWithTreeWangDian.on('expand',function(){
	treeWangDianSaleArea.render('treeWangDianSaleArea');
	treeWangDianSaleArea.root.reload();
});

//客户信息查询
var formCustomerSearch = new Ext.form.FormPanel({
	id: 'formCustomerSearchID',
	name: 'formCustomerSearchID',
	title: '信息查询',//客户信息查询
	autoHeight: true,
	frame: true,
	layout: "form", // 整个大的表单是form布局
	labelWidth: 80,
	labelAlign: "right",
	items: [
	/*{
		xtype: 'combo',
		name:'goodstype',
		id:'goodstype',
		mode: 'remote',
		fieldLabel: '所属类别',
		displayField: 'departmentName',
		valueField:'id',
		store:class_store,
		triggerAction: 'all',
		emptyText: '请选择类别',
		forceSelection:false,
		editable:true
	},*/
	comboxWithTreeWangDian,
	{
		xtype: 'textfield',
		name:'keyValue',
		id:'keyValue',
		fieldLabel: '关键词',
		anchor: '90%'
	}],
	buttons: [{
		text: '查询',
		handler:function(){
			//alert(formCustomerSearch.form.findField("goodstype").getValue());
			//alert(Ext.getCmp("customerOfficeAdressSearch").getValue());
			grid.reconfigure(customerJsonStore,customerList);	//更换显示的数据
			customerJsonStore.removeAll();
			maps.clearOverLays();
			grid.expand();
			
			var goodstypeValue = "";
			if(Ext.getDom("goodstype").value == "请选择类别")
			{
				goodstypeValue = ""
			}
			else
			{
				goodstypeValue = Ext.getDom("goodstype").value;
			}
			//alert(goodstypeValue);
			customerJsonStore.on('beforeload',function(){
				Ext.apply(
				this.baseParams,
				{
					goodstype:goodstypeValue,
					keyValue:Ext.getCmp("keyValue").getValue()
				});
			});
			customerJsonStore.load({
				params: {
					start:0,
					limit:pageSize,
					goodstype:goodstypeValue,
					keyValue:Ext.getCmp("keyValue").getValue()
				}
				,callback:function(r,options,success){if(customerJsonStore.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
			})
		}
	}]
});

//给客户的所属城市赋值
function cityOptionsSearch(cityArr)
{
	Ext.getDom("provinceSearch").value = "";
	for(var i=cityArr.length-1;i>=0;i--)
	{
		if(cityArr[i]!="root"&&cityArr[i]!="全国")
		{
			Ext.getDom("provinceSearch").value += cityArr[i];//设定经度
		}
	}
}

//客户信息查询列表
var customerList = new Ext.grid.ColumnModel([
/*	{header:'编号',dataIndex:'id'},
	{header:'客户名称',dataIndex:'customerName'},
	{header:'所属城市',dataIndex:'province'}*/
	//{header:'描述',dataIndex:'detail'}
	
//	{header:'编号',dataIndex:'id',hidden:true},
//	{header:'项目名称',dataIndex:'objectName'},//项目名称
//	{header:'开工日期',dataIndex:'startTime'},//项目办公地址
//	{header:'竣工日期',dataIndex:'endTime'},//项目办公地址
//	{header:'经度',dataIndex:'lng'},//项目办公地址经度
//	{header:'纬度',dataIndex:'lat'},
//	//{header:'所属分公司',dataIndex:'belongToBranch',renderer:belongToBranchFun},
//	{header:'负责人',dataIndex:'projectPrincipal'},
//	{header:'所属分公司',dataIndex:'belongToBranch'},
//	{header:'图标',dataIndex:'iconColor'},
//	{header:'备注',dataIndex:'info'}
	
	
	//{header:'编号',dataIndex:'id'},
	{header:'网点名称',dataIndex:'businessname'},
	{header:'联系电话',dataIndex:'iconname',width: 500}
	//,//项目名称
	//{header:'地址',dataIndex:'address'},//项目办公地址
	//{header:'经度',dataIndex:'lng'},//项目办公地址经度
	//{header:'纬度',dataIndex:'lat'},
	//{header:'所属分公司',dataIndex:'belongToBranch',renderer:belongToBranchFun},
	//{header:'所属类别',dataIndex:'goodstype'},
	//{header:'标注图片',dataIndex:'icon',renderer:iconFun},
	//{header:'图片名称',dataIndex:'iconname'},
	//{header:'图片地址',dataIndex:'iconadress',renderer:iconadressFun},
	//{header:'店铺网址',dataIndex:'url'},
	//{header:'备注',dataIndex:'info'}
	
]);

function iconFun(value,cellmeta,record,store){
	var str="<img src='markerIcon/"+ record.data["icon"] +"'>";
	return str;
}

function iconadressFun(value,cellmeta,record,store){
	var str="<img src='"+ record.data["iconadress"] +"' width='100' height='100'>";
	return str;
}

var customerJsonStore = new Ext.data.JsonStore({
	url: "json_projectInfoSearch_client.asp",
	root: "root",
	totalProperty: 'mytotal',
	//remoteSort:true,
	baseParams:{start:0,limit:pageSize},
	idProperty: "id",
	//fields: ["id", "name", "info","icon","lag","lat","file1"]
	fields: ["id","businessname","address","lng","lat","goodstype","icon","iconname","iconadress","url","info"]
});

var grid = new Ext.grid.GridPanel({
	store:customerJsonStore,
	cm: customerList,
	loadMask: true,
	closable: true,
	frame:true,
	title: '信息列表',
	bbar: new Ext.PagingToolbar({
		pageSize:customerJsonStore.baseParams.limit,
		store:customerJsonStore,
		displayInfo:true,
		displayMsg:'显示第{0}条到{1}条记录,一共{2}条',
		//item:null,
		emptyMsg:'没有记录'
	})
});

grid.getSelectionModel().on('rowselect', function(sm, rowIdx, r) {

	//var detailPanel = Ext.getCmp('detailPanel');
	
	//bookTpl.overwrite(detailPanel.body, r.data);
	
	//Ext.MessageBox.alert("提示","您选择的出版号是：" + r.data);

});

customerJsonStore.addListener('load',resultCustomer);
function resultCustomer(st, rds, opts){
	//alert(obj2str(opts));
	//alert(opts.params.customerOfficeAdressSearch);
	//alert(customerJsonStore.getCount())
	if(maps)
	{
		maps.clearOverLays();
		clearCustomerArray()
	}
	
	if(customerJsonStore.getAt(0).get('customerOfficeAdressLng') != "" && customerJsonStore.getAt(0).get('customerOfficeAdressLat') != "")
	{
		for(var i=0;i<customerJsonStore.getCount();i++)
		{
			//["id","businessname","address","lng","lat","goodstype","icon","iconname","iconadress","url","info"]
			ids.push(customerJsonStore.getAt(i).get('id'))
			businessnames.push(customerJsonStore.getAt(i).get('businessname'))
			addresss.push(customerJsonStore.getAt(i).get('address'))
			goodstypes.push(customerJsonStore.getAt(i).get('goodstype'))
			lnglats.push(new LTPoint(customerJsonStore.getAt(i).get('lng'), customerJsonStore.getAt(i).get('lat')))
			icons.push(customerJsonStore.getAt(i).get('icon'))
			iconnames.push(customerJsonStore.getAt(i).get('iconname'))
			iconadresss.push(customerJsonStore.getAt(i).get('iconadress'))
			urls.push(customerJsonStore.getAt(i).get('url'))
			infos.push(customerJsonStore.getAt(i).get('info'))
		}
		addAllCustomerMarker(ids,businessnames,addresss,goodstypes,lnglats,icons,iconnames,iconadresss,urls,infos);
		//maps.getBestMap(pointsArr);
	}
}
//-----------------------------------------客户信息查询结束----------------------------------------


function addAllCustomerMarker(ids,businessnames,addresss,goodstypes,lnglats,icons,iconnames,iconadresss,urls,infos){
	//alert(pointsOffice.length+"||"+pointsHouse <= 0);
	for(var i=0;i<ids.length;i++)
	{
		//alert(customerName[i]);
		var html="网点名称："+businessnames[i]+"<br>";
		html+="地址："+addresss[i]+"<br>";
		//html+="所属类型："+goodstypes[i]+"<br>";
		//html+="店铺网址：<a href='"+urls[i]+"'>"+urls[i]+"</a><br>";
		//html+=infos[i]+"<br>";
		html+="联系电话："+iconnames[i]+"<br>";
		//html+='网址：<a href="#" onclick="window.open(\''+urls[i]+'\')">'+urls[i]+'</a><br>';
		html+="详细内容："+infos[i]+"<br>";//2013-1-5修改 将备注信息加入到弹出窗显
		//html+="<div><img src='"+iconadresss[i]+"' onerror='this.src=\"images/noimg.jpg\"' target='_blank' onmouseover='imgZoomIn(this)' onmouseout='imgZoomOut(this)' style='width:210px;height:160px;'/></div>";
		
		var icon2=new LTIcon("markerIcon/"+icons[i],[20,20],[10,20]);//创建一个图标
		var marker = new LTMarker(lnglats[i],icon2);
		maps.addOverLay(marker);
		html="<div style='text-align:left'>"+html+"</div>"
		//LTEvent.addListener( marker , "click" ,getClickCallBackCustomer(marker,html,businessnames[i],i));//mouseover 
		
		/*markerArr.ids.marker = marker;
		markerArr.ids.marker = marker;
		markerArr.ids.html = html;
		markerArr.ids.name = businessnames[i];
		markerArr.ids.id = i;*/
		
		LTEvent.addListener( marker , "mouseover" ,getClickCallBackCustomer(marker,html,businessnames[i],i));//2013-1-5客户要求鼠标浮动后弹出框
	}
	maps.getBestMap(lnglats);
	grid.on('rowmousedown',function(a,b,c){
		if(customerJsonStore.getAt(b))
		{
			var html="网点名称："+customerJsonStore.getAt(b).get("businessname")+"<br>";
			html+="地址："+customerJsonStore.getAt(b).get("address")+"<br>";
			html+="联系电话："+customerJsonStore.getAt(b).get("iconname")+"<br>";
			//html+='网址：<a href="#" onclick="window.open(\''+customerJsonStore.getAt(b).get("url")+'\')">'+customerJsonStore.getAt(b).get("url")+'</a><br>';
			html+="详细内容："+customerJsonStore.getAt(b).get("info")+"<br>";//2013-1-5修改 将备注信息加入到弹出窗显
			//var icon2=new LTIcon("markerIcon/"+customerJsonStore.getAt(b).get("icon"),[20,20],[10,20]);//创建一个图标
//			var marker = new LTMarker(lnglats[i],icon2);
//			maps.addOverLay(marker);
			html="<div style='text-align:left'>"+html+"</div>"
			maps.moveToCenter(new LTPoint(customerJsonStore.getAt(b).get('lng'), customerJsonStore.getAt(b).get('lat')),0);
			if(typeof infoWindow != "undefined")
			{
				maps.removeOverLay(infoWindow);
			}
			if(typeof infoWin != "undefined")
			{
				infoWin.closeInfoWindow();
			}
			var centerpoint = new LTPoint(customerJsonStore.getAt(b).get('lng'), customerJsonStore.getAt(b).get('lat')); 
            infoWindow =new LTInfoWindow(centerpoint,[0,-20]);
			infoWindow.setTitle(customerJsonStore.getAt(b).get("businessname")); 
            infoWindow.setLabel(html);
			maps.addOverLay(infoWindow);
		}
	});
}

//鼠标浮动及单击事件方法
function getClickCallBackCustomer(marker,html,name,i)
{
	//alert(name);
	return function(){
		if(typeof infoWindow != "undefined")
		{
			maps.removeOverLay(infoWindow);
		}
		infoWin=marker.openInfoWinHtml(html);
		infoWin.setTitle(name);
		infoWin.moveToShow();
		//grid.getView().getRow(i).style.backgroundColor='#DCDCDC'; 
	}
}

function indexOfStr(val,text){
	for(var i = 0; i < val.length; i++)
	{
		if(val[i] == text)return i;
	}
	return -1;
}

function removeStr(val,text){
	var index = indexOfStr(val,text);
	if (index > -1) {
		val.splice(index, 1);
	}
}

function clearCustomerArray()
{
	ids.splice(0,ids.length);
	businessnames.splice(0,businessnames.length);
	addresss.splice(0,addresss.length);
	goodstypes.splice(0,goodstypes.length);
	lnglats.splice(0,lnglats.length);
	icons.splice(0,icons.length);
	iconnames.splice(0,iconnames.length);
	iconadresss.splice(0,iconadresss.length);
	urls.splice(0,urls.length);
	infos.splice(0,infos.length);
}

var imgDefaultWidth = 210;
var imgDefaultHeight = 160;
var imgDefaultWidthZoomIn = 250;
var imgDefaultHeightZoomOut = 200;
function imgZoomIn(self)
{
	self.style.width=imgDefaultWidthZoomIn;
	self.style.height=imgDefaultHeightZoomOut;
	self.style.position="relative";
	self.style.left = (-(imgDefaultWidthZoomIn-imgDefaultWidth)/2)+"px";
	self.style.top = (-(imgDefaultHeightZoomOut-imgDefaultHeight)/2)+"px";
	self.style.zIndex = 1;
}

function imgZoomOut(self)
{
	self.style.width=imgDefaultWidth;
	self.style.height=imgDefaultHeight;
	self.style.left = "0px";
	self.style.top = "0px";
}

function loginOut()
{
	Ext.Ajax.request({
		url:'loginout.asp',
		method:'get',
		params:{
			uid:'uid'
		},
		success:function(req){
			//alert(req.responseText);
			//window.close();
			location.href="login.asp";
			/*if(req.responseText=='ok')
			{
				Ext.Msg.alert('success','You got it!');
			}
			else
			{
				Ext.Msg.alert('sorry','You lost!');
			}*/
		}
	});
}

function loginAdmin()
{
	location.href="admin.asp";
}

function obj2str(o){
	var r = [];
	if(typeof o =="string") return "\""+o.replace(/([\'\"\\])/g,"\\$1").replace(/(\n)/g,"\\n").replace(/(\r)/g,"\\r").replace(/(\t)/g,"\\t")+"\"";
	if(typeof o =="undefined") return "";
	if(typeof o == "object"){
		if(o===null) return "null";
		else if(!o.sort){
			for(var i in o)
				r.push(i+":"+obj2str(o[i]))
			r="{"+r.join()+"}"
		}else{
			for(var i =0;i<o.length;i++)
				r.push(obj2str(o[i]))
			r="["+r.join()+"]"
		}
		return r;
	}
	return o.toString();
}
</script>
<style type="text/css">
<!--
.style1 {
	font-size: 14px;
	font-weight: bold;
}
-->
body{
text-align:left;
}
        </style>
</head>
<body>
<!--<div id="north-div">
  <div class="style1" id="menu">网点查询系统</div>
</div>-->
<div id="north-div" style="background-image:url(images/bg_head.jpg)"><img src="images/logoTop.jpg">
  <div class="style1" style="display:none" id="menu">网点查询系统</div>
  <div style="cursor:pointer" onClick="loginOut();">
  	<div style="position:absolute; right:80; top:15;font-size:12px; background-image:url(images/exit.jpg); width:20px; height:18px"></div><div style="position:absolute; right:30; top:15;font-size:12px">退出系统</div>
  </div>
  <div style="cursor:pointer" onClick="loginAdmin();">
  	
		<div style="position:absolute; right:200; top:15;font-size:12px; background-image:url(images/admin.jpg); width:20px; height:20px"></div>
		<div style="position:absolute; right:125; top:15;font-size:12px">登录管理页面</div>
	
  </div>
</div>
<div id="treeCitysSearch"></div>
<div id="treeSaleAreaSearchDiv"></div>
<div id="myMap" style="position:relative; width:100%; height:100%;border:black solid 0px;"></div>
<div id="south-div" style="font-size:12px;"><%=CC_CopyRight%></div>
<div id="tree-panel"></div>
</body>
</html>