//-------------------------------页面初始化开始-----------------------------------------------
Ext.onReady(function(){
    // 树形配置开始
    var tree = new Ext.tree.TreePanel({
	    loader: new Ext.tree.TreeLoader(),
        title: '系统管理',
        split: true,
        border: true,
		rootVisible:false,
        collapsible: true,
        width: 120,
        minSize: 80,
        maxSize: 200
    });
	
	//单击树事件开始
	tree.on("click",function(node,event){
		if(!node.isLeaf()){return;}
		event.stopEvent();
		var n = tabpanel.getComponent(node.id);
		var k  = tabpanel.find('title',node.text);
		if(n || k!=''){tabpanel.setActiveTab(node.id);return}
		//生成右侧的网点管理、图标管理等数据
		switch(node.id){
			case "customerInfo":	//客户网点管理开始
				//alert(node.text);
				var hall_grid_n = tabs.add(grid_customerInfo);
				tabs.setActiveTab(hall_grid_n);
				customerInfo_search.load({
					params:{
						start: 0,
						limit:800
					}
					,callback:function(r,options,success){if(customerInfo_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				});
				break;
			case "departmentTree":	//部门管理开始
				var department_grid_n = tabs.add(grid_department);
				tabs.setActiveTab(department_grid_n);
				department_search.load({
					params:{
						start: 0,
						limit:800
					}
					,callback:function(r,options,success){if(department_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				});
				break;
			case "iconInfoTree":	//标注图标管理开始
				var iconInfo_grid_n = tabs.add(grid_iconInfo);
				tabs.setActiveTab(iconInfo_grid_n);
				iconInfo_search.load({
					params:{
						start: 0,
						limit:800
					}
					,callback:function(r,options,success){if(iconInfo_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				});
				break;
			//新增员工管理
			case "employeeInfoTree":	//员工管理开始
				var employeeInfoTree_grid_n = tabs.add(grid_employeeInfo);
				tabs.setActiveTab(employeeInfoTree_grid_n);
				employeeInfo_search.load({
					params:{
						start: 0,
						limit:800
					}
					,callback:function(r,options,success){if(employeeInfo_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				});
				break;
			//新增员工管理结束
			case "userTree":	//用户信息开始
				var user_grid_n = tabs.add(grid_user);
				tabs.setActiveTab(user_grid_n);
				user_search.load({
					params:{
						start: 0,
						limit:800
					}
					,callback:function(r,options,success){if(user_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				});
				break;
			case 'out':location.href="login.asp";break;//11054572,3561267
			default:break;
		}
    });
	
	//单击树事件结束
	var root = new Ext.tree.AsyncTreeNode({
		text:'',
		children: [
			{text:'客户信息管理',id:'customerInfo',leaf:true},
			{text:'类别管理',id:'departmentTree',leaf:true},
			{text:'标注图标管理',id:'iconInfoTree',leaf:true},
			{text:'员工管理',id:'employeeInfoTree',leaf:true},
			{text:'用户管理',id:'userTree',leaf:true},
			{text:'退出系统',id:'out',leaf:true}
		]
	});
    tree.setRootNode(root);
    tree.expand();
    // 树形配置结束
    
	//查询TAB
	var tabpanel=new Ext.TabPanel({
        activeTab:0,    //设置默认选择的选项卡
        width:300,
		height:700
		//,items:[grid,form]
    });
	//查询TAB结束
	
	//管理TAB开始
	var tabs = new Ext.TabPanel({
        //renderTo: 'tab',
        height: 100,
		region:'center',
		loadMask: true,
		//closable: true,
        enableTabScroll: true
    });
    tabs.add({
        title: '说明',
		   el:'shuoming'
        //html: '内容1'
    });
    tabs.activate(0);
	//管理TAB结束
	
    // 布局开始
    var viewport = new Ext.Viewport({
        layout:'border',
        items:[{
				region: 'north',
				contentEl: 'north-div',
				height: 55,
				bodyStyle: 'background-color:#BBCCEE;'
			},{
				region: 'south',
				contentEl: 'south-div',
				height: 20,
				bodyStyle: 'background-color:#BBCCEE;'
			},{ region: 'west',
				split: true,
				layout:'accordion',
				width:300,
				collapsible:true,
				title:'系统菜单',
				items:[tree]
			},tabs
		]
    });
    // 布局结束
});
//--------------------------------页面初始化结束-----------------------------------------------


//--------------------------------项目信息管理开始--------------------------------------------------
var customerInfo_sm = new Ext.grid.CheckboxSelectionModel({header: " ",sortable: true,width: 20});
var customerInfo_cm = new Ext.grid.ColumnModel([customerInfo_sm,
	{header:'编号',dataIndex:'id',hidden:true},
	{header:'名称',dataIndex:'businessname'},//项目名称
	{header:'地址',dataIndex:'address'},//项目办公地址
	{header:'经度',dataIndex:'lng'},//项目办公地址经度
	{header:'纬度',dataIndex:'lat'},
	//{header:'所属分公司',dataIndex:'belongToBranch',renderer:belongToBranchFun},
	{header:'状态',dataIndex:'stateDianPu'},
	{header:'所属城市',dataIndex:'goodstype'},
	{header:'所属类别',dataIndex:'v1'},
	{header:'所属类别ID',dataIndex:'goodstypeId'},//后添加，升级用ID查询
	{header:'标注图片',dataIndex:'icon',renderer:iconFun},
	//{header:'图片名称',dataIndex:'iconname'},
	{header:'图片地址',dataIndex:'iconadress',renderer:iconadressFun},
	{header:'联系电话',dataIndex:'iconname'},
	{header:'业务员',dataIndex:'url'},
	{header:'备注',dataIndex:'info'}
]);

function iconFun(value,cellmeta,record,store){
	var str="<img src='markerIcon/"+ record.data["icon"] +"'>";
	return str;
}

function iconadressFun(value,cellmeta,record,store){
	var str="<img src='"+ record.data["iconadress"] +"' width='100' height='100'>";
	return str;
}

function belongToBranchFun(value)
{
	if(value == 1)
	{
		return "一分公司";
	}
	else if(value == 2)
	{
		return "二分公司";
	}
	else if(value == 3)
	{
		return "三分公司";
	}
	else if(value == 4)
	{
		return "四分公司";
	}
	else if(value == 5)
	{
		return "五分公司";
	}
}

var comboxWithTreeTypeSearch = new Ext.form.ComboBox({
	hiddenName:"projectKeyWordType",
	store:new Ext.data.SimpleStore({fields:[],data:[[]]}),
	fieldLabel: '所属城市',
	emptyText:"请选择城市",
	//editable:false,
	//expanded:true,
	//shadow:false,
	mode: 'local',
	triggerAction:'all',
	//height:350,
	tpl: '<tpl for="."><div style="height:200px"><div id="treeTypeSearch"></div></div></tpl>',
	selectedClass:'',
	onSelect:Ext.emptyFn,
	onViewClick : Ext.emptyFn,
	assertValue : Ext.emptyFn
	//,
	//allowBlank:false
	//,
	//blankText: '所属类别不能为空',
	//value:(row?row.get("goodstype"):"")
});
var treeTypeSearch = new Ext.tree.TreePanel({
	containerScroll: true,//是否支持滚动条
	split: true,
	rootVisible:false,
	autoScroll: true,
	border:false,
	//height:350,
	loader: new Ext.tree.TreeLoader({dataUrl:'json_saleTypeTree.asp'}),
	root:new Ext.tree.AsyncTreeNode({id:'0',text:'root',expanded:true})
});
treeTypeSearch.on('click',function(node,e){
	comboxWithTreeTypeSearch.setValue(node.text);
	comboxWithTreeTypeSearch.collapse();
});
comboxWithTreeTypeSearch.on('expand',function(){
	treeTypeSearch.render('treeTypeSearch');
	treeTypeSearch.root.reload();
});

//start 读取远程POI JSON数据显示在表格里
var proxy_customerInfo = new Ext.data.HttpProxy({url:'json_projectInfoSearch.asp'});
var reader_customerInfo = new Ext.data.JsonReader(
	{
		totalProperty:'mytotal',//记录总数
		root:'root',
		id:'id'
	},[
		{name:'id'},
		{name:'businessname'},
		{name:'address'},
		{name:'lng'},
		{name:'lat'},
		{name:'stateDianPu'},
		{name:'goodstype'},
		{name:'goodstypeId'},
		{name:'icon'},
		{name:'iconname'},
		{name:'iconadress'},
		{name:'url'},
		{name:'v1'},
		{name:'info'}
	]
);
//构建Store
customerInfo_search = new Ext.data.Store({
	proxy:proxy_customerInfo,
	reader:reader_customerInfo
/*		,
	baseParams:{limit:5}*/
});

var grid_customerInfo = new Ext.grid.GridPanel({
	store: customerInfo_search,
	cm: customerInfo_cm,
	loadMask: true,
	//closable: true,
	title: '信息管理',//项目信息列表
	bbar: new Ext.PagingToolbar({
		pageSize:800,
		store:customerInfo_search,
		displayInfo:true,
		//displayMsg:'显示第{0}条到第和第{1}条记录,一共{2}条',
		displayMsg:'显示第 {0} 条到 {1} 条记录，总共 {2} 条',
		emptyMsg:'没有记录',
		beforePageText: "第",
		afterPageText:"页 共{0}页"
	}),
	tbar: [
		{xtype: "textfield",width: 160,height: 20,baseCls: 'x-plain',id:'projectKeyWord',name:'projectKeyWord',allowBlank: true,emptyText: "搜索客户名称"},
		
		{
			text: '&nbsp;搜索',icon: "img/page_find.png",cls: "x-btn-text-icon",
			handler: function(){
				//Ext.Msg.alert('提示','目前无数据');
				customerInfo_search.removeAll();
				customerInfo_search.on('beforeload',function(){
					Ext.apply(
					this.baseParams,
					{
						type:0,
						projectKeyWord:grid_customerInfo.getTopToolbar().findById("projectKeyWord").getValue()
					});
				});
				customerInfo_search.load({
					params:{
						start: 0,
						limit:800,
						type:0,
						projectKeyWord:grid_customerInfo.getTopToolbar().findById("projectKeyWord").getValue()
					},callback:function(r,options,success){if(customerInfo_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				})
			}
		},
		{xtype: "tbseparator"},
		comboxWithTreeTypeSearch,
		{xtype: "tbseparator"},
		{
			text: '&nbsp;类别搜索',icon: "img/page_find.png",cls: "x-btn-text-icon",
			handler: function(){
				//Ext.Msg.alert('提示','目前无数据');
				customerInfo_search.removeAll();
				var goodstypeValue = "";
				if(Ext.getDom("projectKeyWordType").value == "请选择类别")
				{
					goodstypeValue = ""
				}
				else
				{
					goodstypeValue = Ext.getDom("projectKeyWordType").value;
				}
				customerInfo_search.on('projectKeyWordType',function(){
					Ext.apply(
					this.baseParams,
					{
						type:1,
						//projectKeyWordType:grid_customerInfo.getTopToolbar().findById("projectKeyWordType").getValue()
						projectKeyWordType:goodstypeValue
					});
				});
				customerInfo_search.load({
					params:{
						start: 0,
						limit:800,
						type:1,
						projectKeyWordType:goodstypeValue
					},callback:function(r,options,success){if(customerInfo_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				})
			}
		},
		
		{xtype: "tbseparator"},
		{
			text: '添加',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
			handler: function(){
				Ext.QuickTips.init();//开启表单提示
				//hall_form_obj = getCustomerInfoForm();
				
				Ext.Ajax.request({
					url:'json_iconInfoAll.asp?icon=',
					method:'post',
					params:{
						uid:'uid'
					},
					success:function(req){
						//alert(req.responseText);
						var iconAll = null;
						var json = eval('('+req.responseText+')');
						iconAll = json;
						hall_form_obj = getHallForm(null,iconAll);
						customerInfo_win = new Ext.Window({title: "添加信息",width: 970,height: 580,modal: true,maximizable:false,resizable:false,items: hall_form_obj});
						customerInfo_win.show();
					}
				});
				
				//hall_form_obj = getHallForm();
//				
//				customerInfo_win = new Ext.Window({title: "添加信息",width: 970,height: 580,modal: true,maximizable:false,resizable:false,items: hall_form_obj});
//				customerInfo_win.show();
			}
		},
		{xtype: "tbseparator"},
		{
			text: '修改',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
			handler: function(){
				Ext.QuickTips.init();//开启表单提示
				var row = grid_customerInfo.getSelectionModel().getSelections();
				if (!row){return;}
				for (var i = 0; i < row.length; i++)
				{
					Ext.form.Field.prototype.msgTarget = 'side';//设置提示信息位置为边上
					//hall_form_obj = getCustomerInfoForm(row[i]);
					//hall_form_obj = getHallForm(row[i]);
//					customerInfo_win = new Ext.Window({title: "修改信息",width: 970,height: 580,modal: true,maximizable:false,resizable:false,items: hall_form_obj});
//					customerInfo_win.show();
					//alert(row[i].get("icon"));
					var rowP = row[i];
					Ext.Ajax.request({
						url:'json_iconInfoAll.asp?icon='+row[i].get("icon"),
						method:'post',
						params:{
							uid:'uid'
						},
						success:function(req){
							//alert(req.responseText);
							var iconAll = null;
							var json = eval('('+req.responseText+')');
							//iconAll = json;
							hall_form_obj = getHallForm(rowP,json);
							customerInfo_win = new Ext.Window({title: "修改信息",width: 970,height: 580,modal: true,maximizable:false,resizable:false,items: hall_form_obj});
							customerInfo_win.show();
							//iconAll = req.responseText;
						}
					});
					//field = hall_form_obj.getForm().findField('icon');
					//field.setValue(row[i].get("icon"));//new
					//alert(row[i].get("icon"))
				}
			}
		},
		{xtype: "tbseparator"}, 
		{
			text: '删除',icon: "img/chart_pie_delete.png",cls: "x-btn-text-icon",
			handler: function(){
				var row = grid_customerInfo.getSelectionModel().getSelections();
				if (row) {
					Ext.Msg.confirm("请确认", "是否真的删除此条记录?", function(butten, text){
						if (butten == "yes") {
							for (var i = 0; i < row.length; i++) {
								//alert(row[i].get("id"));
								Ext.Ajax.request({
									url: 'json_wangdianInfoSave.asp?sType=del',
									params: 'id=' + row[i].get("id")
								});
							}
							customerInfo_search.removeAll();
							customerInfo_search.load({params: {start:0,limit:800}});
						}
					})
				}
			}
		}
		/*,
		{xtype: "tbseparator"}, 
		{
			text: '导出Excel表',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
			handler: function(){
				window.location.href = "printExcel.asp";
			}
		}*/
	]
});

//生成新加机构点的菜单
function getCustomerInfoForm(row)
{
	var extTime = new Date().format('Y-m-d');
	//网点数据结束
	return new Ext.FormPanel({
		id: 'hall_form',
		name: 'hall_form',
		//title: "",
		//bodyStyle: 'padding:5px 5px 0',
		width: 600,
		autoHeight: true,
		frame: true,
		renderTo: Ext.getBody(),
		layout: "form", // 整个大的表单是form布局
		labelWidth: 120,
		labelAlign: "right",
		items: [
			{xtype: 'hidden',name:'id',value:(row?row.get("id"):"")},
			{xtype: 'textfield',name:'objectName',fieldLabel: '项目名称',width:150,allowBlank:false,blankText: '项目名称不能为空',value:(row?row.get("objectName"):"")},	//行1
			//{xtype: 'button',hidden:true,handler:function(){citysWin(cityOptions);}, name: 'province_city_district',id:"province_city_district",fieldLabel: '选择城市',text:'选择',width: 120,height:22},
			{ //行2
				layout: "column", // 从左往右的布局
				items: [
					{
						columnWidth: .5, // 该列有整行中所占百分比
						layout: "form", // 从上往下的布局
						labelWidth: 120,
						items: [
							//{xtype: 'textfield',name:'startTime',fieldLabel: '开工日期',width: 150,allowBlank:false,blankText: '开工日期不能为空',value:(row?row.get("startTime"):"")}
							{
								xtype : 'datefield',
								fieldLabel : '开工日期',
								name:'startTime',
								id:'startTime',
								format : 'Y-m-d',
								invalidText : '日期不正确，请输入\'YYYY-MM-dd\'格式',
								value:new Date(parseInt((row?row.get("startTime"):extTime).split("-")[0]),parseInt((row?row.get("startTime"):extTime).split("-")[1])-1,parseInt((row?row.get("startTime"):extTime).split("-")[2]))
								//value:new Date((row?row.get("endTime"):extTime).split("-")[0],(row?row.get("endTime"):extTime).split("-")[1],(row?row.get("endTime"):extTime).split("-")[2])
	//							,
	//							minValue : new Date(),
	//							minText : '请选择今天之后的日期'
							}
								
						]//项目办公地址
					},
					{
						columnWidth: .5,
						layout: "form",
						labelWidth: 120,
						items: [
							//{xtype: 'textfield',name:'endTime',fieldLabel: '竣工日期',width: 150,allowBlank:false,blankText: '竣工日期不能为空',value:(row?row.get("endTime"):"")}
							{
								xtype : 'datefield',
								fieldLabel : '竣工日期',
								name:'endTime',
								id:'endTime',
								format : 'Y-m-d',
								invalidText : '日期不正确，请输入\'YYYY-MM-dd\'格式',
								value:new Date(parseInt((row?row.get("endTime"):extTime).split("-")[0]),parseInt((row?row.get("endTime"):extTime).split("-")[1])-1,parseInt((row?row.get("endTime"):extTime).split("-")[2]))
	//							,
	//							minValue : new Date(),
	//							minText : '请选择今天之后的日期'
							}
						]//项目办公位置
					}
				]
			},
			{xtype: 'button',handler:function(){showWin_Lnglat(setOfficeAddressLnglat,Ext.getCmp("lng").getValue(),Ext.getCmp("lat").getValue());}, name: 'latlng_OfficeAdress',id:"hall_ezmarker_OfficeAdress",fieldLabel: '位置',text:'地图标注',width: 120,height:22},
			{
				layout: "column", // 从左往右的布局
				items: [
					{
						columnWidth: .5,
						layout: "form", // 从上往下的布局
						items: [{xtype: 'textfield',name:'lng',id:'lng',fieldLabel: '地址经度',width: 150,allowBlank:false,blankText: '经度不能为空',value:(row?row.get("lng"):"")}]//项目办公地址经度
					},
					{
						columnWidth: .5,
						layout: "form",
						items: [{xtype: 'textfield',name:'lat',id:'lat',fieldLabel: '地址纬度',width: 150,allowBlank:false,blankText: '纬度不能为空',value:(row?row.get("lat"):"")}]//项目办公地址纬度
					}
				]
			},
			{xtype: 'textfield',name:'projectPrincipal',id:'projectPrincipal',fieldLabel: '负责人',width:150,allowBlank:false,blankText: '负责人不能为空',value:(row?row.get("projectPrincipal"):"")},
			{
				xtype:"combo",
				fieldLabel: '所属分公司',
				//hiddenName:'belongToBranch',
				name:'belongToBranch',
				id:'belongToBranch',
				value:(row?row.get("belongToBranch"):""),
				triggerAction:'all',
				displayField: 'text',
				valueField: 'value',
				mode: 'local', 
				width: 150,
				emptyText:'请选择',
				allowBlank:false,
				blankText: '所属分公司不能为空',
				//hidden:quxianTrue(),
				//readOnly:quxianTrue(),
				//disabled:quxianTrue(),
				//style:quxianColor(),
				store: new Ext.data.SimpleStore({
					fields: ['value', 'text'],
					data: [
						['一分公司', '一分公司'],
						['二分公司', '二分公司'],
						['三分公司', '三分公司'],
						['四分公司', '四分公司'],
						['五分公司', '五分公司']
					]
				})
			},
			{
				xtype:"panel",
				layout:"column",
				fieldLabel:'图标颜色',
				labelWidth:1,
				isFormField:true,
				items:[{
						columnWidth:.1,
						checked:(row?(row.get("iconColor")=="red")?true:false:false),
						xtype:'radio',
						boxLabel:'红',
						name:'iconColor',
						inputValue:'red'
					},{
						columnWidth:.1,
						checked:(row?(row.get("iconColor")=="green")?true:false:false),
						xtype:'radio',
						boxLabel:"绿",
						name:'iconColor',
						inputValue:'green'
					},{
						columnWidth:.1,
						checked:(row?(row.get("iconColor")=="blue")?true:false:false),
						xtype:'radio',
						boxLabel:"蓝",
						name:'iconColor',
						inputValue:'blue'
					}
				]
			},
			{xtype: 'textarea',fieldLabel: '备注信息',id: 'info',anchor: '60%',name:'info',height: 90,value:(row?row.get("info"):"")}
		],
		buttons: [{
			text: '确定',
			handler: function(){//添加网站
			//alert(customerInfo_win.getComponent('hall_form').form.findField("beginDateUpdate").getValue().replaceAll("-",","));
				if (customerInfo_win.getComponent('hall_form').form.isValid()) {
					//alert(customerInfo_win.getComponent('hall_form').form.findField("iconColor").getGroupValue());
					var iconColorParam = customerInfo_win.getComponent('hall_form').form.findField("iconColor").getGroupValue();
					if(iconColorParam == null)
					{
						Ext.MessageBox.alert('提示','请选择图标颜色!');
						return;
					}
					customerInfo_win.getComponent('hall_form').form.submit({
						waitTitle: '请稍候',
						waitMsg: '正在提交数据,请稍候....',
						url: 'json_projectInfo.asp?iconColor='+iconColorParam,
						method: 'POST',
						success: function(form,action){
							var Result = action.result;
							if (Result.success == true) {
								if(Result.msg==0){
									Ext.MessageBox.alert('提示','添加项目信息成功!');
								}else if(Result.msg==3){
									Ext.MessageBox.alert('提示','修改项目信息成功!');
								}
								customerInfo_win.getComponent('hall_form').form.reset();
								customerInfo_search.load({params: {start: 0,limit:800}});
								customerInfo_win.close();
							}
							else
							{
								if(Result.msg==1){
									Ext.MessageBox.alert('提示','添加项目信息失败!');
								}else if(Result.msg==4){
									Ext.MessageBox.alert('提示','修改项目信息失败!');
								}
							}
						},
						failure: function(form,action){
							//Ext.MessageBox.alert('提示', Result.message);
							//Ext.MessageBox.alert('提示', Result.msg);
							customerInfo_search.load({params: {start: 0}});
							customerInfo_win.getComponent('hall_form').form.reset();
							//customerInfo_win.getComponent('hall_form').findById("hall_ezmarker").reset();
						}
						
					})
				}
			}
		}, {
			text: '取消',
			handler: function(){
				customerInfo_win.close();
			}
		}]
	});
}


function getHallForm(row,iconAll)
{
	//alert(row);
	if(row){
		var stateCheck = (row?(row.get("stateDianPu")=="显示")?true:false:false);
	}
	else
	{
		var stateCheck = true;
	}
	
	/*var class_store = new Ext.data.JsonStore({url: "json_departmentInfoSearch.asp?leibieType=1",root: "root",totalProperty: 'mytotal',remoteSort:true,baseParams:{limit:2000},
		fields: ["id", "departmentName"]
	});
	class_store.load({params: {start:0,departmentKeyWord:""}});*/
	
	var comboxWithTreeWangDian = new Ext.form.ComboBox({
		hiddenName:"goodstype",
		store:new Ext.data.SimpleStore({fields:[],data:[[]]}),
		fieldLabel: '所属城市',
		emptyText:"请选择城市",
		//editable:false,
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
		allowBlank:false,
		blankText: '所属类别不能为空',
		value:(row?row.get("goodstype"):"")
	});
	var treeWangDianSaleArea = new Ext.tree.TreePanel({
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
		Ext.getCmp("goodstypeId").setValue(node.attributes.soleId)
		comboxWithTreeWangDian.collapse();
	});
	comboxWithTreeWangDian.on('expand',function(){
		treeWangDianSaleArea.render('treeWangDianSaleArea');
		treeWangDianSaleArea.root.reload();
	});
	
	
	return new Ext.FormPanel({
		id: 'hall_form',
		name: 'hall_form',
		labelWidth: 80, // 默认标签宽度板
		labelAlign: 'left',//labelAlign: 'right
		//baseCls: 'x-plain',//不设置该值，表单将保持原样，设置后表单与窗体完全融合（-_-!!，说不清了，大家可以去掉运行下看看）
		bodyStyle: 'padding:5px 5px 0',
		width: 950,//750
		layout:'table',//此参数决定界面是横排还是竖排
		fileUpload: true,
		layoutConfig:{tableAttrs:{cellspacing:2}},//5
		frame: true,
		
		//renderTo: Ext.getBody(),
		//layout: "form", // 整个大的表单是form布局
		
		defaults: {bodyStyle:'padding:5px'},
		defaultType: 'textfield',//默认字段类型
		items: [
		{
			xtype: 'fieldset',title: '客户基本信息',height: 480,width:630,labelWidth: 80,
			items:
			[
				
				{xtype: 'hidden',name:'id',value:(row?row.get("id"):"")},
				{xtype: 'textfield',name:'businessname',fieldLabel: '名称',value:(row?row.get("businessname"):""),width:150,allowBlank:false,blankText: '名称能为空'},
				{xtype: 'textfield',name:'goodstypeId',id:'goodstypeId',fieldLabel: '类别ID',value:(row?row.get("goodstypeId"):""),width:150,allowBlank:true,blankText: '名称能为空'},

				{xtype: 'textfield',name:'address',fieldLabel: '地址',value:(row?row.get("address"):""),width: 150,blankText: '营业厅不名称能为空'},
				//{xtype: 'button',handler:function(){showWin_Lnglat(setOfficeAddressLnglat,Ext.getCmp("lng").getValue(),Ext.getCmp("lat").getValue());;}, name: 'latlng',id:"hall_ezmarker",fieldLabel: '位置',text:'地图标注',value:(row?(row.get("lat")+","+row.get("lng")):""),width: 120,height:30},
				
				//{xtype: 'button',handler:function(){showWin_Lnglat(setOfficeAddressLnglat,Ext.getCmp("lng").getValue(),Ext.getCmp("lat").getValue());}, name: 'latlng_OfficeAdress',id:"hall_ezmarker_OfficeAdress",fieldLabel: '位置',text:'51地图标注',width: 120,height:22},//51地图标注
				
				{xtype: 'button',handler:function(){showWin(setOfficeAddressLnglat_baidu,Ext.getCmp("lng").getValue(),Ext.getCmp("lat").getValue());}, name: 'latlng_OfficeAdress_baidu',id:"hall_ezmarker_OfficeAdress_baidu",fieldLabel: 'BaiDu位置',text:'百度地图标注',width: 120,height:22},//百度地图标注
				
				{xtype: 'textfield',name:'lng',id:'lng',fieldLabel: '经度',value:(row?row.get("lng"):""),width: 150,allowBlank:false,blankText: '经度不能为空'},
				{xtype: 'textfield',name:'lat',id:'lat',fieldLabel: '纬度',value:(row?row.get("lat"):""),width: 150,allowBlank:false,blankText: '经度不能为空'},
				{
					xtype:"panel",
					layout:"column",
					fieldLabel:'状态',
					labelWidth:0.5,
					isFormField:false,
					items:[{
							columnWidth:.1,
							//checked:(row?(row.get("stateDianPu")=="显示")?true:false:false),
							checked:stateCheck,
							xtype:'radio',
							boxLabel:'显示',
							name:'stateDianPu',
							inputValue:'显示'
						},{
							columnWidth:.1,
							checked:(row?(row.get("stateDianPu")=="隐藏")?true:false:false),
							xtype:'radio',
							boxLabel:"隐藏",
							name:'stateDianPu',
							inputValue:'隐藏'
						}
					]
				},
//				{xtype: 'combo',name:'goodstype',id:'goodstype',mode: 'remote',fieldLabel: '所属类别',value:(row?row.get("goodstype"):""),displayField: 'departmentName',valueField:'id',store:class_store,triggerAction: 'all',forceSelection:false,editable:false,value:(row?row.get("goodstype"):"")
///*					,
//					listeners:{
//						select : function(combo, record, index){
//						},
//						render: function(combo){
//							var cc=combo.getValue();
//							//alert(cc);
//							var index=class_store.find("id",parseInt(cc));
//							if(index<0){return "";}
//							class_store.on('load',function(tempstore){combo.setValue(tempstore.getAt(index).get('departmentName'))});
//						}
//					}*/
//				},
				
				comboxWithTreeWangDian,
				
				/*{
					xtype: 'combo',
					hiddenName:'goodstype',
					mode: 'remote',
					fieldLabel: '所属类别',
					value:(row?row.get("type"):""),
					displayField: 'name',
					valueField:'id',
					triggerAction: 'all',
					emptyText: '客户类别',
					store: new Ext.data.SimpleStore({
						fields: ['value', 'text'],
						data: [
							['一分公司', '一分公司'],
							['二分公司', '二分公司'],
							['三分公司', '三分公司'],
							['四分公司', '四分公司'],
							['五分公司', '五分公司']
						]
					})
				},*/
				//新增类别开始  类别包括：周边美景、周边摄影师、婚纱租凭、周边摄影机构
				{
				xtype:"combo",
				fieldLabel: '查询类别',
				//hiddenName:'belongToBranch',
				name:'v1',
				id:'v1',
				value:(row?row.get("v1"):""),
				triggerAction:'all',
				displayField: 'text',
				valueField: 'value',
				mode: 'local', 
				width: 150,
				emptyText:'请选择',
				allowBlank:false,
				blankText: '查询类别不能为空',
				//hidden:quxianTrue(),
				//readOnly:quxianTrue(),
				//disabled:quxianTrue(),
				//style:quxianColor(),
				store: new Ext.data.SimpleStore({
					fields: ['value', 'text'],
					data: [
						['重点客户', '重点客户'],
				//['周边摄影师', '周边摄影师'],
				//['婚纱租赁', '婚纱租赁'],
				//['周边化妆师赁', '周边化妆师'],
				//['周边冲印机构', '周边冲印机构'],
				['普通客户', '普通'],
				['VIP客户', 'VIP客户']
						
					]
				})
			},
				//新增类别结束
				{xtype: 'textfield',name:'iconname',fieldLabel: '客户电话',value:(row?row.get("iconname"):""),width: 150,blankText: '电话不能为空'},
				{xtype: 'textfield',name:'url',fieldLabel: '业务员',value:(row?row.get("url"):""),width:280},
				//,hidden:true,hideLabel:true
				{xtype: 'htmleditor',fieldLabel: '详细内容',id: 'info',value:(row?row.get("info"):""),anchor: '100%',name:'info',height: 200}
			]
		},
		
		{
			xtype: 'fieldset',title: '图片',height: 480,width:300,labelWidth:60,
			items:
			[
				{xtype: 'fieldset',fieldLabel: '图标',hideLabels:true,defaultType:'radio',labelAlign:'left',
					items:iconAll
					/*items:[
						{boxLabel:'<img src="markerIcon/cm-2.gif" height="16"/>',itemCls: 'sex-male',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-2.gif',checked:(row?(row.get("icon")=="cm-2.gif")?true:false:false)},
						{boxLabel:'<img src="markerIcon/cm-3.gif" height="16"/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-3.gif',checked:(row?(row.get("icon")=="cm-3.gif")?true:false:false)},
						{boxLabel:'<img src="markerIcon/cm-4.gif" height="16"/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-4.gif',checked:(row?(row.get("icon")=="cm-4.gif")?true:false:false)},
						{boxLabel:'<img src="markerIcon/cm-5.png" height="16"/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-5.png',checked:(row?(row.get("icon")=="cm-5.png")?true:false:false)},
						{boxLabel:'<img src="markerIcon/cm-6.png" height="16"/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-6.png',checked:(row?(row.get("icon")=="cm-6.png")?true:false:false)},
						{boxLabel:'<img src="markerIcon/cm-7.png" height="16"/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-7.png',checked:(row?(row.get("icon")=="cm-7.png")?true:false:false)},
						{boxLabel:'<img src="markerIcon/cm-8.png" height="16"/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-8.png',checked:(row?(row.get("icon")=="cm-8.png")?true:false:false)},
						{boxLabel:'<img src="markerIcon/cm-9.png" height="16"/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-9.png',checked:(row?(row.get("icon")=="cm-9.png")?true:false:false)},
						{boxLabel:'<img src="markerIcon/cm-10.png" height="16"/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-10.png',checked:(row?(row.get("icon")=="cm-10.png")?true:false:false)},
						{boxLabel:'<img src="markerIcon/cm-11.png" height="16"/>',itemCls: 'sex-female',clearCls: 'allow-float' ,name:'icon',inputValue:'cm-11.png',checked:(row?(row.get("icon")=="cm-11.png")?true:false:false)}
					]*/
				},
				//{xtype: 'textfield',name:'iconname',fieldLabel: '照片',value:(row?row.get("iconname"):""),width: 60,blankText: '营业厅不名称能为空'},
				{xtype: 'textfield',inputType:'file', name: 'file1',fieldLabel: '图片上传',value:(row?row.get("file1"):""),width: 150,allowBlank:true},
				{xtype: 'box',width: 200,height: 100,autoEl: {      
					tag: 'img',   //指定为img标签      
					src: (row?row.get("iconadress"):"")    //指定url路径      
					}
				} 
			]
		}
		],
		buttons: [{
			text: '确定',
			handler: function(){//添加网站
			//alert("test");
			//alert(customerInfo_win.getComponent('hall_form').form.findField("beginDateUpdate").getValue().replaceAll("-",","));
				if (customerInfo_win.getComponent('hall_form').form.isValid()) {
					//alert(eval("'"+Ext.getDom("info").value+"'").href);
					//'('+Ext.getDom("info").value+')'
					//alert(customerInfo_win.getComponent('hall_form').form.findField("iconColor").getGroupValue());
					//return;
					var iconColorParam = customerInfo_win.getComponent('hall_form').form.findField("stateDianPu").getGroupValue();
					//alert(iconColorParam);
					if(iconColorParam == null)
					{
						Ext.MessageBox.alert('提示','请选择状态!');
						return;
					}
					//alert("test");
					customerInfo_win.getComponent('hall_form').form.submit({
						waitTitle: '请稍候',
						waitMsg: '正在提交数据,请稍候....',
						url: 'json_wangdianInfoSave.asp?sType=add',
						method:'POST',
						success:function(form,action){
							//alert("test");
							//var Result=3;
							var Result = action.result;
							//var Result = action.result;
							//alert("test");
							if (Result.success == true) {
								if(Result.msg==0){
									Ext.MessageBox.alert('提示','添加客户信息成功!');
								}else if(Result.msg==3){
									Ext.MessageBox.alert('提示','修改客户信息成功!');
								}
								customerInfo_win.getComponent('hall_form').form.reset();
								customerInfo_search.load({params: {start: 0,limit:800}});
								customerInfo_win.close();
							}
							else
							{
								if(Result.msg==1){
									Ext.MessageBox.alert('提示','添加客户信息失败!');
								}else if(Result.msg==4){
									Ext.MessageBox.alert('提示','修改客户信息失败!');
								}
							}
						},
						failure: function(form,action){
							//Ext.MessageBox.alert('提示', Result.message);
							//Ext.MessageBox.alert('提示', Result.msg);
							customerInfo_search.load({params: {start: 0}});
							customerInfo_win.getComponent('hall_form').form.reset();
							//customerInfo_win.getComponent('hall_form').findById("hall_ezmarker").reset();
						}
						
					})
				}
			}
		}, {
			text: '取消',
			handler: function(){
				customerInfo_win.close();
			}
		}]
	});
}

function iconColorFun(value)
{
	
}
//baidu 地图标注开始
//百度标注
function showWin(fun,lng,lat)
{
	wint = new Ext.Window({
		width:850,//650
		height:450,//460
		closeAction:'hide',
		//items:[{html:"<div style=\"height:200px;width:400px;\"id=\"mapDiv\"></div>"}],
		items:[panel],
		buttons:[{
			text:'关闭',
			handler:function(){
				if(mkrTool)
				{
					mkrTool.close();
				}
				wint.hide()
			}
		}]
	})
	wint.show();
	CC_iniMap(fun,lng,lat);
}
//
function CC_iniMap(fun,lng,lat){
	maps = new BMap.Map("mapDiv");
	maps.centerAndZoom(new BMap.Point(110.3028, 25.287389), 12);
	maps.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
	//maps.addControl(new BMap.OverviewMapControl());
	maps.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
	maps.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
 local = new BMap.LocalSearch(maps, {
 renderOptions:{map: maps}
});
//var icon2 = new BMap.Icon("markerIcon/"+json[i].icon, new BMap.Size(20,20),{anchor:new BMap.Size(10,20)});
	//icon2.imageSize = new BMap.Size(20,20);
	//添加搜索功能
		// 定义一个控件类,即function
	function chaControl(){
  	// 默认停靠位置和偏移量
 	 this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
  	this.defaultOffset = new BMap.Size(350, 10);
	}

	// 通过JavaScript的prototype属性继承于BMap.Control
	chaControl.prototype = new BMap.Control();

	// 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
	// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
	chaControl.prototype.initialize = function(maps){
  	// 创建一个DOM元素
  	var div = document.createElement("div");
  	// 添加文字说明
  	//div.appendChild(document.createTextNode("放大2级"));
  	// 设置样式
  	div.style.cursor = "pointer";
  	div.style.border = "1px solid gray";
  	div.style.backgroundColor = "white";
	div.innerHTML="<input type=\"text\" id=\"keyword\" name=\"textfield\" /><input id=\"sousuo\" type=\"submit\" name=\"Submit\" value=\"搜索\" onclick=\"local.search(document.getElementById('keyword').value);\" />"
  	// 绑定事件,点击一次放大两级
  	
  	// 添加DOM元素到地图中
  	maps.getContainer().appendChild(div);
  	// 将DOM元素返回
  	return div;
	}
	//搜索POI
	
	// 创建控件
	var mychaCtrl = new chaControl();
	// 添加到地图当中
	
	maps.addControl(mychaCtrl);
	//添加搜索功能结束
	//创建城市列表开始
	// 创建CityList对象，并放在city_container节点内
	var myCl = new BMapLib.CityList({"container" : "city_container", "map" : maps});

	// 给城市点击时，添加切换地图视野的操作
	myCl.addEventListener("cityclick", function(e) {
	//alert("当前城市是"+e.name);
	// 由于此时传入了map对象，所以点击的时候会自动帮助地图定位，不需要下面的地图视野切换语句
	// map.centerAndZoom(e.center, e.level);
});

	//创建城市列表结束
	if(lng!=""&&lat!="")
	{
		var lnglat = new BMap.Point(lng,lat);
		var marker = new BMap.Marker(lnglat);
		maps.addOverlay(marker);
		maps.panTo(new BMap.Point(lng,lat));
	}
	// 创建控件
	var myZoomCtrl = new ZoomControl();
	// 添加到地图当中
	maps.addControl(myZoomCtrl);
	mkrTool = new BMapLib.MarkerTool(maps,{autoClose:true});
	mkrTool.addEventListener("markend", fun);
	//添加搜索控件开始
	// 定义一个控件类,即function
function SearchControl(){
  // 默认停靠位置和偏移量
  this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
  this.defaultOffset = new BMap.Size(10, 10);
}

// 通过JavaScript的prototype属性继承于BMap.Control
SearchControl.prototype = new BMap.Control();

// 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
SearchControl.prototype.initialize = function(maps){
  // 创建一个DOM元素
  var div = document.createElement("div");
  // 添加文字说明
 // div.appendChild(document.createTextNode("城市选择"));
  div.id="city_container";
  div.style.width="200px";
  div.style.height="280px";
  // 设置样式
  div.style.cursor = "pointer";
  div.style.border = "1px solid gray";
  div.style.backgroundColor = "white";
  div.style.overflow= "auto";
  // 绑定事件,点击一次放大两级
 /* div.onclick = function(e){
    maps.setZoom(maps.getZoom() + 2);
  }*/
  // 添加DOM元素到地图中
  maps.getContainer().appendChild(div);
  // 将DOM元素返回
  return div;
}
// 创建控件
var mySearchControl = new SearchControl();
// 添加到地图当中
maps.addControl(mySearchControl);
	//添加搜索控件结束
}

// 定义一个控件类,即function
function ZoomControl(){
	// 默认停靠位置和偏移量
	this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
	this.defaultOffset = new BMap.Size(560, 10);
}

// 通过JavaScript的prototype属性继承于BMap.Control
ZoomControl.prototype = new BMap.Control();

// 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
ZoomControl.prototype.initialize = function(map){
	// 创建一个DOM元素
	var div = document.createElement("input");
	div.type = "button";
	div.value = "标注位置";
	div.onclick = function(){mkrTool.open();};
	// 设置样式
	div.style.cursor = "pointer";
	// 添加DOM元素到地图中
	maps.getContainer().appendChild(div);
	// 将DOM元素返回
	return div;
}

var markerRemove = null;
//设置项目办公地址经纬度
function setOfficeAddressLnglat_baidu(evt)
{
	//maps.clearOverlays();
	if(markerRemove)
	{
		maps.removeOverlay(markerRemove);
	}
	var mkr = evt.marker;
	markerRemove = mkr;
	mkrTool.close();
	//mkr.openInfoWindow(infoWin);
	//curMkr = mkr;
	
	//LTEvent.removeListener(ezmarkerEvent);
	Ext.getDom("lng").value = mkr.getPosition().lng;
	Ext.getDom("lat").value = mkr.getPosition().lat;
	alert("保存成功")
	if(mkrTool)
	{
		mkrTool.close();
	}
	wint.hide();
	
	//document.getElementById("ezmarkerDiv").style.display = "none";
	//document.getElementById("ezmarkerDivClose").style.display = "none";
}

var panel=new Ext.Panel({
	//el:'mapDiv',
	html:"<div style=\"height:450px;width:834px;\"id=\"mapDiv\"></div>",//385，634
	//title:'map',
	width:850,//650
	height:450//450
})
//baidu 地图标注结束
//地图标注方法
var ezmarkerEvent = null;
function showWin_Lnglat(fun,lng,lat)
{
	//ezmarker.win.config.canClose = 1;
	//ezmarker.createWin(ezmarker.win.config);
	
	ezmarker.map.moveToCenter(new LTPoint(11641438,3991816),3)//将地图固定沧州
	ezmarker.setWinZIndex(100000);
	//ezmarker.win.setContainerSize([650,450]);	//设置标注层的大小
	var ezmarkerDiv = document.getElementById("ezmarkerDiv");
	ezmarkerDiv.style.cssText = "position:absolute;width:650px;height:450px;left:50%;top:50%;margin-left:-325px;margin-top:-225px;z-index:100000;display:block";
	
	var ezmarkerDivClose = document.getElementById("ezmarkerDivClose");
	ezmarkerDivClose.style.cssText = "position:absolute;width:14px;height:14px;left:50%;top:50%;margin-left:300px;margin-top:-220px;z-index:100000;display:block;background:url(http://api.51ditu.com/img/ezmarker/close.gif);cursor:pointer";
	ezmarkerDivClose.onclick = function(){
		LTEvent.removeListener(ezmarkerEvent);
		document.getElementById("ezmarkerDiv").style.display = "none";
		document.getElementById("ezmarkerDivClose").style.display = "none";
	};
	
	if(lng!=""&&lat!="")
	{
		ezmarker.map.clearOverLays();
		//ezmarker.setValue(new LTPoint(lng,lat),6);//设置默认值
		//ezmarker.setValue(new LTPoint(round(lng*100000,0),round(lat*100000,0)),6);//设置成百度默认值
		ezmarker.setValue(new LTPoint(Math.round(lng*100000),Math.round(lat*100000)),6);//设置成百度默认值
	}
	else
	{
		ezmarker.map.clearOverLays();
	}
	
	ezmarkerEvent = LTEvent.addListener(ezmarker,"mark",fun);	//在每次用户完成标注的时候执行check函数
}
//设置项目办公地址经纬度
function setOfficeAddressLnglat(point,zoom)
{
	LTEvent.removeListener(ezmarkerEvent);
	//Ext.getDom("lng").value = point.getLongitude();
	//Ext.getDom("lat").value = point.getLatitude();
	Ext.getDom("lng").value = point.getLongitude()/100000;//转换成百度坐标
	Ext.getDom("lat").value = point.getLatitude()/100000;
	document.getElementById("ezmarkerDiv").style.display = "none";
	document.getElementById("ezmarkerDivClose").style.display = "none";
}
//--------------------------------项目信息管理结束-------------------------------------------------	

//--------------------------------部门管理开始-------------------------------------------------	
var department_sm = new Ext.grid.CheckboxSelectionModel({header: " ",sortable: true,width: 20});
var department_cm = new Ext.grid.ColumnModel([department_sm,
	{header:'编号',dataIndex:'id',hidden:true},
	{header:'类别名称',dataIndex:'departmentName'},
	{header:'类别级别',dataIndex:'departmentType',
		renderer:function(value){
			return "一级类别";
		}
	},
	{header:'下属类别',dataIndex:'addSecondType',width:130,renderer:addSecondType}
]);

//start 读取远程POI JSON数据显示在表格里
var proxy_department = new Ext.data.HttpProxy({url:'json_departmentInfoSearch.asp?leibieType=1'});
var reader_department = new Ext.data.JsonReader(
	{
		totalProperty:'mytotal',//记录总数
		root:'root',
		id:'id'
	},[
		{name:'id'},
		{name:'departmentName'}
		
	]
);
//构建Store
department_search = new Ext.data.Store({
	proxy:proxy_department,
	reader:reader_department
});

var grid_department = new Ext.grid.GridPanel({
	store: department_search,
	cm: department_cm,
	loadMask: true,
	//closable: true,
	title: '类别管理列表',
	bbar: new Ext.PagingToolbar({
		pageSize:800,
		store:department_search,
		displayInfo:true,
		//displayMsg:'显示第{0}条到第和第{1}条记录,一共{2}条',
		displayMsg:'显示第 {0} 条到 {1} 条记录，总共 {2} 条',
		emptyMsg:'没有记录',
		beforePageText: "第",
		afterPageText:"页 共{0}页"
	}),
	tbar: [
		{xtype: "textfield",width: 160,height: 20,baseCls: 'x-plain',id:'departmentKeyWord',name:'departmentKeyWord',allowBlank: true,emptyText: "搜类别名称"},
		{xtype: "tbseparator"},
		{
			text: '&nbsp;搜索',icon: "img/page_find.png",cls: "x-btn-text-icon",
			handler: function(){
				//Ext.Msg.alert('提示','目前无数据');
				department_search.removeAll();
				department_search.load({
					params:{
						start: 0,
						limit:800,
						departmentKeyWord:grid_department.getTopToolbar().findById("departmentKeyWord").getValue()
					},callback:function(r,options,success){if(department_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				})
			}
		},
		{
			text: '添加',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
			handler: function(){
				Ext.QuickTips.init();//开启表单提示
				department_form_obj = getDepartmentForm();
				department_win = new Ext.Window({title: "添加类别信息",width: 360,height: 105,modal: true,maximizable:false,resizable:false,items: department_form_obj});
				department_win.show();
			}
		},
		{xtype: "tbseparator"},
		{
			text: '修改',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
			handler: function(){
				Ext.QuickTips.init();//开启表单提示
				var row = grid_department.getSelectionModel().getSelections();
				if (!row){return;}
				for (var i = 0; i < row.length; i++)
				{
					Ext.form.Field.prototype.msgTarget = 'side';//设置提示信息位置为边上
					department_form_obj = getDepartmentForm(row[i]);
					department_win = new Ext.Window({title: "修改类别信息",width: 360,height: 105,modal: true,maximizable:false,resizable:false,items: department_form_obj});
					department_win.show();
					//field = hall_form_obj.getForm().findField('icon');
					//field.setValue(row[i].get("icon"));//new
					//alert(row[i].get("icon"))
				}
			}
		},
		{xtype: "tbseparator"},
		{
			text: '删除',icon: "img/chart_pie_delete.png",cls: "x-btn-text-icon",
			handler: function(){
				var row = grid_department.getSelectionModel().getSelections();
				if (row) {
					Ext.Msg.confirm("请确认", "是否真的删除此条记录?", function(butten, text){
						if (butten == "yes") {
							for (var i = 0; i < row.length; i++) {
								//alert(row[i].get("id"));
								Ext.Ajax.request({
									url: 'json_departmentInfoSave.asp?sType=del&leibieType=1',
									params: 'id=' + row[i].get("id")
								});
							}
							department_search.removeAll();
							department_search.load({params: {start:0,limit:800}});
						}
					})
				}
			}
		}
	]
});

//生成新加机构点的菜单
function getDepartmentForm(row)
{
	//网点数据结束
	return new Ext.FormPanel({
		id: 'department_form',
		name: 'department_form',
		//title: "",
		//bodyStyle: 'padding:5px 5px 0',
		width: 350,
		autoHeight: true,
		frame: true,
		renderTo: Ext.getBody(),
		layout: "form", // 整个大的表单是form布局
		labelWidth: 120,
		labelAlign: "right",
		items: [
			{xtype: 'hidden',name:'id',value:(row?row.get("id"):"")},
			{xtype: 'textfield',name:'departmentName',fieldLabel: '类别名称',width:150,allowBlank:false,blankText: '类别名称不能为空',value:(row?row.get("departmentName"):"")}
		],
		buttons: [{
			text: '确定',
			handler: function(){//添加网站
			//alert(customerInfo_win.getComponent('hall_form').form.findField("beginDateUpdate").getValue().replaceAll("-",","));
				if (department_win.getComponent('department_form').form.isValid()) {
					department_win.getComponent('department_form').form.submit({
						waitTitle: '请稍候',
						waitMsg: '正在提交数据,请稍候....',
						url: 'json_departmentInfoSave.asp?sType=add&leibieType=1',
						method: 'POST',
						success: function(form,action){
							var Result = action.result;
							
							if (Result.success == true) {
								if(Result.msg==0){
									Ext.MessageBox.alert('提示','添加类别信息成功!');
								}else if(Result.msg==3){
									Ext.MessageBox.alert('提示','修改类别信息成功!');
								}
								department_win.getComponent('department_form').form.reset();
								department_search.load({params: {start: 0,limit:800}});
								department_win.close();
							}
							else
							{
								if(Result.msg==1){
									Ext.MessageBox.alert('提示','添加类别信息失败!');
								}else if(Result.msg==4){
									Ext.MessageBox.alert('提示','修改类别信息失败!');
								}
							}
						},
						failure: function(form,action){
							//Ext.MessageBox.alert('提示', Result.message);
							//Ext.MessageBox.alert('提示', Result.msg);
							department_search.load({params: {start: 0}});
							department_win.getComponent('department_form').form.reset();
							//customerInfo_win.getComponent('department_form').findById("hall_ezmarker").reset();
						}
					})
				}
			}
		}, {
			text: '取消',
			handler: function(){
				department_win.close();
			}
		}]
	});
}

//--------------------------------部门管理结束-------------------------------------------------	

//--------------------------------添加二级类别开始-------------------------------------------------	
//添加二级片区
function addSecondType(value,cellmeta,record,rowIndex,columnIndex,store)
{
	var str="<input type='button' value='添加二级类别' onclick='secondTypeWin(\""+record.data["id"]+"\",\""+record.data["departmentName"]+"\")'\>"
	//alert(str);
	return str;
}


function secondTypeWin(id,saleAreaName)
{
	secondType_form_obj = secondTypeForm(id,saleAreaName);
	secondType_win = new Ext.Window({title: "二级类别列表",width: 664,height:500,modal: true,maximizable: false,resizable:false,items: secondType_form_obj});
	secondType_win.show();
}
function secondTypeForm(id,saleAreaName)
{
	var form1 = new Ext.form.FormPanel({
		width:650,
		height:480,
		region:'center',
		loadMask: true,
		//closable: true,
        enableTabScroll: true,
		//frame:true,//圆角和浅蓝色背景
		//renderTo:Ext.getBody(),//呈现
		//title:"FormPanel",
		//bodyStyle:"padding:5px 5px 0",
		//defaults:{xtype:"textfield",width:120},
		items:[
			secondTypeFormPanel(id,saleAreaName)
		]
	});
	return form1;
}

function secondTypeFormPanel(id,saleAreaName)
{
	var seconddepartment_sm = new Ext.grid.CheckboxSelectionModel({header: " ",sortable: true,width: 20});
	var seconddepartment_cm = new Ext.grid.ColumnModel([seconddepartment_sm,
		{header:'编号',dataIndex:'id',hidden:true},
		{header:'类别名称',dataIndex:'departmentName'},
		{header:'上级类别',dataIndex:'upName',
			renderer:function(value){
				return saleAreaName;
			}
		},
		{header:'类别级别',dataIndex:'departmentNameseconde',
			renderer:function(value){
				return "二级类别";
			}
		},
		{header:'下属类别',dataIndex:'addThreeType',width:130,renderer:addThreeType}
		
	]);
	
	//start 读取远程POI JSON数据显示在表格里
	var secondproxy_department = new Ext.data.HttpProxy({url:'json_departmentInfoSearch.asp?leibieType=2'});
	var secondreader_department = new Ext.data.JsonReader(
		{
			totalProperty:'mytotal',//记录总数
			root:'root',
			id:'id'
		},[
			{name:'id'},
			{name:'departmentName'}
		]
	);
	//构建Store
	seconddepartment_search = new Ext.data.Store({
		proxy:secondproxy_department,
		reader:secondreader_department
	});
	
	var secondgrid_department = new Ext.grid.GridPanel({
		store: seconddepartment_search,
		cm: seconddepartment_cm,
		loadMask: true,
		width:650,
		height:468,
		//closable: true,
		//title: '类别管理列表',
		bbar: new Ext.PagingToolbar({
			pageSize:800,
			store:seconddepartment_search,
			displayInfo:true,
			//displayMsg:'显示第{0}条到第和第{1}条记录,一共{2}条',
			displayMsg:'显示第 {0} 条到 {1} 条记录，总共 {2} 条',
			emptyMsg:'没有记录',
			beforePageText: "第",
			afterPageText:"页 共{0}页"
		}),
		tbar: [
			{xtype: "textfield",width: 160,height: 20,baseCls: 'x-plain',id:'departmentKeyWord',name:'departmentKeyWord',allowBlank: true,emptyText: "搜类别名称"},
			{xtype: "tbseparator"},
			{
				text: '&nbsp;搜索',icon: "img/page_find.png",cls: "x-btn-text-icon",
				handler: function(){
					//Ext.Msg.alert('提示','目前无数据');
					seconddepartment_search.removeAll();
					seconddepartment_search.load({
						params:{
							start: 0,
							limit:800,
							owenAreaId:id,
							departmentKeyWord:secondgrid_department.getTopToolbar().findById("departmentKeyWord").getValue()
						},callback:function(r,options,success){if(seconddepartment_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
					})
				}
			},
			{
				text: '添加',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
				handler: function(){
					Ext.QuickTips.init();//开启表单提示
					department_form_obj = getDepartmentFormSecond(id,saleAreaName);
					department_win = new Ext.Window({title: "添加类别信息",width: 360,height: 105,modal: true,maximizable:false,resizable:false,items: department_form_obj});
					department_win.show();
				}
			},
			{xtype: "tbseparator"},
			{
				text: '修改',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
				handler: function(){
					Ext.QuickTips.init();//开启表单提示
					var row = secondgrid_department.getSelectionModel().getSelections();
					if (!row){return;}
					for (var i = 0; i < row.length; i++)
					{
						Ext.form.Field.prototype.msgTarget = 'side';//设置提示信息位置为边上
						department_form_obj = getDepartmentFormSecond(id,saleAreaName,row[i]);
						department_win = new Ext.Window({title: "修改类别信息",width: 360,height: 105,modal: true,maximizable:false,resizable:false,items: department_form_obj});
						department_win.show();
						//field = hall_form_obj.getForm().findField('icon');
						//field.setValue(row[i].get("icon"));//new
						//alert(row[i].get("icon"))
					}
				}
			},
			{xtype: "tbseparator"},
			{
				text: '删除',icon: "img/chart_pie_delete.png",cls: "x-btn-text-icon",
				handler: function(){
					var row = secondgrid_department.getSelectionModel().getSelections();
					if (row) {
						Ext.Msg.confirm("请确认", "是否真的删除此条记录?", function(butten, text){
							if (butten == "yes") {
								for (var i = 0; i < row.length; i++) {
									//alert(row[i].get("id"));
									Ext.Ajax.request({
										url: 'json_departmentInfoSave.asp?sType=del&leibieType=2',
										params: 'id=' + row[i].get("id")
									});
								}
								seconddepartment_search.removeAll();
								seconddepartment_search.load({params: {start:0,limit:800,owenAreaId:id}});
							}
						})
					}
				}
			}
		]
	});
	seconddepartment_search.load({params: {start:0,limit:800,owenAreaId:id}});
	return secondgrid_department

}

//生成新加机构点的菜单
function getDepartmentFormSecond(owenAreaId,saleAreaName,row)
{
	//网点数据结束
	return new Ext.FormPanel({
		id: 'department_form',
		name: 'department_form',
		//title: "",
		//bodyStyle: 'padding:5px 5px 0',
		width: 350,
		autoHeight: true,
		frame: true,
		renderTo: Ext.getBody(),
		layout: "form", // 整个大的表单是form布局
		labelWidth: 120,
		labelAlign: "right",
		items: [
			{xtype: 'hidden',name:'owenAreaId',value:owenAreaId},
			{xtype: 'hidden',name:'id',value:(row?row.get("id"):"")},
			{xtype: 'textfield',name:'departmentName',fieldLabel: '类别名称',width:150,allowBlank:false,blankText: '类别名称不能为空',value:(row?row.get("departmentName"):"")},
			{hidden:true,xtype: 'hidden',name:'departmentTypeName',id:'departmentTypeName',fieldLabel: '上一级类别',width: 150,value:saleAreaName}
		],
		buttons: [{
			text: '确定',
			handler: function(){//添加网站
			//alert(customerInfo_win.getComponent('hall_form').form.findField("beginDateUpdate").getValue().replaceAll("-",","));
				if (department_win.getComponent('department_form').form.isValid()) {
					department_win.getComponent('department_form').form.submit({
						waitTitle: '请稍候',
						waitMsg: '正在提交数据,请稍候....',
						url: 'json_departmentInfoSave.asp?sType=add&leibieType=2',
						method: 'POST',
						success: function(form,action){
							var Result = action.result;
							if (Result.success == true) {
								if(Result.msg==0){
									Ext.MessageBox.alert('提示','添加类别信息成功!');
								}else if(Result.msg==3){
									Ext.MessageBox.alert('提示','修改类别信息成功!');
								}
								department_win.getComponent('department_form').form.reset();
								seconddepartment_search.load({params: {start: 0,limit:800,owenAreaId:owenAreaId}});
								department_win.close();
							}
							else
							{
								if(Result.msg==1){
									Ext.MessageBox.alert('提示','添加类别信息失败!');
								}else if(Result.msg==4){
									Ext.MessageBox.alert('提示','修改类别信息失败!');
								}
							}
						},
						failure: function(form,action){
							//Ext.MessageBox.alert('提示', Result.message);
							//Ext.MessageBox.alert('提示', Result.msg);
							seconddepartment_search.load({params: {start: 0,owenAreaId:owenAreaId}});
							department_win.getComponent('department_form').form.reset();
							//customerInfo_win.getComponent('department_form').findById("hall_ezmarker").reset();
						}
					})
				}
			}
		}, {
			text: '取消',
			handler: function(){
				department_win.close();
			}
		}]
	});
}

//--------------------------------添加二级类别结束-------------------------------------------------	

//--------------------------------添加三级类别开始-------------------------------------------------	
//添加二级片区
function addThreeType(value,cellmeta,record,rowIndex,columnIndex,store)
{
	var str="<input type='button' value='添加三级类别' onclick='threeTypeWin(\""+record.data["id"]+"\",\""+record.data["departmentName"]+"\")'\>"
	//alert(str);
	return str;
}


function threeTypeWin(id,saleAreaName)
{
	threeType_form_obj = threeTypeForm(id,saleAreaName);
	threeType_win = new Ext.Window({title: "三级类别列表",width: 664,height:500,modal: true,maximizable: false,resizable:false,items: threeType_form_obj});
	threeType_win.show();
}
function threeTypeForm(id,saleAreaName)
{
	var form1 = new Ext.form.FormPanel({
		width:650,
		height:480,
		region:'center',
		loadMask: true,
		//closable: true,
        enableTabScroll: true,
		//frame:true,//圆角和浅蓝色背景
		//renderTo:Ext.getBody(),//呈现
		//title:"FormPanel",
		//bodyStyle:"padding:5px 5px 0",
		//defaults:{xtype:"textfield",width:120},
		items:[
			threeTypeFormPanel(id,saleAreaName)
		]
	});
	return form1;
}

function threeTypeFormPanel(id,saleAreaName)
{
	var threedepartment_sm = new Ext.grid.CheckboxSelectionModel({header: " ",sortable: true,width: 20});
	var threedepartment_cm = new Ext.grid.ColumnModel([threedepartment_sm,
		{header:'编号',dataIndex:'id',hidden:true},
		{header:'类别名称',dataIndex:'departmentName'},
		{header:'上级类别',dataIndex:'upName',
			renderer:function(value){
				return saleAreaName;
			}
		},
		{header:'类别级别',dataIndex:'departmentName',
			renderer:function(value){
				return "三级类别";
			}
		}
		//,
		//{header:'下属类别',dataIndex:'addThreeType',width:130,renderer:addThreeType}
		
	]);
	
	//start 读取远程POI JSON数据显示在表格里
	var threeproxy_department = new Ext.data.HttpProxy({url:'json_departmentInfoSearch.asp?leibieType=3'});
	var threereader_department = new Ext.data.JsonReader(
		{
			totalProperty:'mytotal',//记录总数
			root:'root',
			id:'id'
		},[
			{name:'id'},
			{name:'departmentName'}
		]
	);
	//构建Store
	threedepartment_search = new Ext.data.Store({
		proxy:threeproxy_department,
		reader:threereader_department
	});
	
	var threegrid_department = new Ext.grid.GridPanel({
		store: threedepartment_search,
		cm: threedepartment_cm,
		loadMask: true,
		width:650,
		height:468,
		//closable: true,
		//title: '类别管理列表',
		bbar: new Ext.PagingToolbar({
			pageSize:800,
			store:threedepartment_search,
			displayInfo:true,
			//displayMsg:'显示第{0}条到第和第{1}条记录,一共{2}条',
			displayMsg:'显示第 {0} 条到 {1} 条记录，总共 {2} 条',
			emptyMsg:'没有记录',
			beforePageText: "第",
			afterPageText:"页 共{0}页"
		}),
		tbar: [
			{xtype: "textfield",width: 160,height: 20,baseCls: 'x-plain',id:'departmentKeyWord',name:'departmentKeyWord',allowBlank: true,emptyText: "搜类别名称"},
			{xtype: "tbseparator"},
			{
				text: '&nbsp;搜索',icon: "img/page_find.png",cls: "x-btn-text-icon",
				handler: function(){
					//Ext.Msg.alert('提示','目前无数据');
					threedepartment_search.removeAll();
					threedepartment_search.load({
						params:{
							start: 0,
							limit:800,
							owenAreaId:id,
							departmentKeyWord:threegrid_department.getTopToolbar().findById("departmentKeyWord").getValue()
						},callback:function(r,options,success){if(threedepartment_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
					})
				}
			},
			{
				text: '添加',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
				handler: function(){
					Ext.QuickTips.init();//开启表单提示
					department_form_obj = getDepartmentFormThree(id,saleAreaName);
					department_win = new Ext.Window({title: "添加类别信息",width: 360,height: 105,modal: true,maximizable:false,resizable:false,items: department_form_obj});
					department_win.show();
				}
			},
			{xtype: "tbseparator"},
			{
				text: '修改',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
				handler: function(){
					Ext.QuickTips.init();//开启表单提示
					var row = threegrid_department.getSelectionModel().getSelections();
					if (!row){return;}
					for (var i = 0; i < row.length; i++)
					{
						Ext.form.Field.prototype.msgTarget = 'side';//设置提示信息位置为边上
						department_form_obj = getDepartmentFormThree(id,saleAreaName,row[i]);
						department_win = new Ext.Window({title: "修改类别信息",width: 360,height: 105,modal: true,maximizable:false,resizable:false,items: department_form_obj});
						department_win.show();
						//field = hall_form_obj.getForm().findField('icon');
						//field.setValue(row[i].get("icon"));//new
						//alert(row[i].get("icon"))
					}
				}
			},
			{xtype: "tbseparator"},
			{
				text: '删除',icon: "img/chart_pie_delete.png",cls: "x-btn-text-icon",
				handler: function(){
					var row = threegrid_department.getSelectionModel().getSelections();
					if (row) {
						Ext.Msg.confirm("请确认", "是否真的删除此条记录?", function(butten, text){
							if (butten == "yes") {
								for (var i = 0; i < row.length; i++) {
									//alert(row[i].get("id"));
									Ext.Ajax.request({
										url: 'json_departmentInfoSave.asp?sType=del&leibieType=3',
										params: 'id=' + row[i].get("id")
									});
								}
								threedepartment_search.removeAll();
								threedepartment_search.load({params: {start:0,limit:800,owenAreaId:id}});
							}
						})
					}
				}
			}
		]
	});
	threedepartment_search.load({params: {start:0,limit:800,owenAreaId:id}});
	return threegrid_department

}

//生成新加机构点的菜单
function getDepartmentFormThree(owenAreaId,saleAreaName,row)
{
	//网点数据结束
	return new Ext.FormPanel({
		id: 'department_form',
		name: 'department_form',
		//title: "",
		//bodyStyle: 'padding:5px 5px 0',
		width: 350,
		autoHeight: true,
		frame: true,
		renderTo: Ext.getBody(),
		layout: "form", // 整个大的表单是form布局
		labelWidth: 120,
		labelAlign: "right",
		items: [
			{xtype: 'hidden',name:'owenAreaId',value:owenAreaId},
			{xtype: 'hidden',name:'id',value:(row?row.get("id"):"")},
			{xtype: 'textfield',name:'departmentName',fieldLabel: '类别名称',width:150,allowBlank:false,blankText: '类别名称不能为空',value:(row?row.get("departmentName"):"")},
			{hidden:true,xtype: 'hidden',name:'departmentTypeName',id:'departmentTypeName',fieldLabel: '上一级类别',width: 150,value:saleAreaName}
		],
		buttons: [{
			text: '确定',
			handler: function(){//添加网站
			//alert(customerInfo_win.getComponent('hall_form').form.findField("beginDateUpdate").getValue().replaceAll("-",","));
				if (department_win.getComponent('department_form').form.isValid()) {
					department_win.getComponent('department_form').form.submit({
						waitTitle: '请稍候',
						waitMsg: '正在提交数据,请稍候....',
						url: 'json_departmentInfoSave.asp?sType=add&leibieType=3',
						method: 'POST',
						success: function(form,action){
							var Result = action.result;
							if (Result.success == true) {
								if(Result.msg==0){
									Ext.MessageBox.alert('提示','添加类别信息成功!');
								}else if(Result.msg==3){
									Ext.MessageBox.alert('提示','修改类别信息成功!');
								}
								department_win.getComponent('department_form').form.reset();
								threedepartment_search.load({params: {start: 0,limit:800,owenAreaId:owenAreaId}});
								department_win.close();
							}
							else
							{
								if(Result.msg==1){
									Ext.MessageBox.alert('提示','添加类别信息失败!');
								}else if(Result.msg==4){
									Ext.MessageBox.alert('提示','修改类别信息失败!');
								}
							}
						},
						failure: function(form,action){
							//Ext.MessageBox.alert('提示', Result.message);
							//Ext.MessageBox.alert('提示', Result.msg);
							threedepartment_search.load({params: {start: 0,owenAreaId:owenAreaId}});
							department_win.getComponent('department_form').form.reset();
							//customerInfo_win.getComponent('department_form').findById("hall_ezmarker").reset();
						}
					})
				}
			}
		}, {
			text: '取消',
			handler: function(){
				department_win.close();
			}
		}]
	});
}

//--------------------------------添加三级类别结束-------------------------------------------------	


//--------------------------------标注图标管理开始-------------------------------------------------	

var iconInfo_sm = new Ext.grid.CheckboxSelectionModel({header: " ",sortable: true,width: 20});
var iconInfo_cm = new Ext.grid.ColumnModel([iconInfo_sm,
	{header:'编号',dataIndex:'id',hidden:true},
	{header:'标注图片名称',align:'center',dataIndex:'iconInfoName',width: 150},
	{header:'标注图片真实名称',align:'center',dataIndex:'iconInfoRoute',width: 200},
	{header:'图标预览',align:'center',dataIndex:'imgPreview',renderer:imgPreview}
]);
//start 读取远程POI JSON数据显示在表格里
var proxy_iconInfo = new Ext.data.HttpProxy({url:'json_iconInfoSearch.asp'});
var reader_iconInfo = new Ext.data.JsonReader(
	{
		totalProperty:'mytotal',//记录总数
		root:'root',
		id:'id'
	},[
		{name:'id'},
		{name:'iconInfoName'},
		{name:'iconInfoRoute'},
		{name:'imgPreview'}
	]
);
//构建员工管理store
iconInfo_search = new Ext.data.Store({
	proxy:proxy_iconInfo,
	reader:reader_iconInfo
});
//构建proxy
//构建store reader
//构建员工管理列表panel
//构建Store
iconInfo_search = new Ext.data.Store({
	proxy:proxy_iconInfo,
	reader:reader_iconInfo
});

var grid_iconInfo = new Ext.grid.GridPanel({
	store: iconInfo_search,
	cm: iconInfo_cm,
	loadMask: true,
	//closable: true,
	title: '标注图标列表',
	bbar: new Ext.PagingToolbar({
		pageSize:800,
		store:iconInfo_search,
		displayInfo:true,
		//displayMsg:'显示第{0}条到第和第{1}条记录,一共{2}条',
		displayMsg:'显示第 {0} 条到 {1} 条记录，总共 {2} 条',
		emptyMsg:'没有记录',
		beforePageText: "第",
		afterPageText:"页 共{0}页"
	}),
	tbar: [
		{xtype: "textfield",width: 160,height: 20,baseCls: 'x-plain',id:'iconInfoNameKeyWord',name:'iconInfoNameKeyWord',allowBlank: true,emptyText: "搜索图标名称"},
		{xtype: "tbseparator"},
		{
			text: '&nbsp;搜索',icon: "img/page_find.png",cls: "x-btn-text-icon",
			handler: function(){
				//Ext.Msg.alert('提示','目前无数据');
				iconInfo_search.removeAll();
				iconInfo_search.load({
					params:{
						start: 0,
						limit:800,
						iconInfoNameKeyWord:grid_iconInfo.getTopToolbar().findById("iconInfoNameKeyWord").getValue()
					},callback:function(r,options,success){if(iconInfo_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				})
			}
		},
		{
			text: '添加',
			icon: "img/chart_pie_add.png",
			cls: "x-btn-text-icon",
			handler: function(){
				Ext.QuickTips.init();//开启表单提示
				iconInfo_form_obj = imgFileUpload();
				iconInfo_win = new Ext.Window({title: "添加图标信息",width: 400,height: 180,modal: true,maximizable:false,resizable:false,items: iconInfo_form_obj});
				iconInfo_win.show();
			}
		},
			
//		{
//			text: '添加',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
//			handler: function(){
//				Ext.QuickTips.init();//开启表单提示
//				iconInfo_form_obj = imgFileUpload();
//				iconInfo_win = new Ext.Window({title: "添加图标信息",width: 500,height: 200,modal: true,maximizable:false,resizable:false,items: iconInfo_form_obj});
//				iconInfo_win.show();
//			}
//		},
//		{xtype: "tbseparator"},
//		{
//			text: '修改',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
//			handler: function(){
//				Ext.QuickTips.init();//开启表单提示
//				var row = grid_iconInfo.getSelectionModel().getSelections();
//				if (!row){return;}
//				for (var i = 0; i < row.length; i++)
//				{
//					Ext.form.Field.prototype.msgTarget = 'side';//设置提示信息位置为边上
//					iconInfo_form_obj = geticonInfoForm(row[i]);
//					iconInfo_win = new Ext.Window({title: "修改图标信息",width: 500,height: 200,modal: true,maximizable:false,resizable:false,items: iconInfo_form_obj});
//					iconInfo_win.show();
//					//field = hall_form_obj.getForm().findField('icon');
//					//field.setValue(row[i].get("icon"));//new
//					//alert(row[i].get("icon"))
//				}
//			}
//		},
		{xtype: "tbseparator"},
		{
			text: '删除',icon: "img/chart_pie_delete.png",cls: "x-btn-text-icon",
			handler: function(){
				var row = grid_iconInfo.getSelectionModel().getSelections();
				if (row) {
					Ext.Msg.confirm("请确认", "是否真的删除此条记录?", function(butten, text){
						if (butten == "yes") {
							for (var i = 0; i < row.length; i++) {
								//alert(row[i].get("id"));
								Ext.Ajax.request({
									url: 'json_iconInfoSave.asp?sType=del',
									params: 'id=' + row[i].get("id")
								});
							}
							iconInfo_search.removeAll();
							iconInfo_search.load({params: {start:0,limit:800}});
						}
					})
				}
			}
		}
	]
});

function imgFileUpload(row){
	var img = new Ext.FormPanel({
		region : 'center', 
		labelWidth : 70, 
		frame : true,
		bodyStyle : 'padding:5px 5px 0', 
		autoScroll : true, 
		border : false, 
		fileUpload : true, 
		items : [
			{xtype: 'hidden',name:'id',value:(row?row.get("id"):"")},
			{xtype: 'textfield',name:'iconInfoName',fieldLabel: '图标名称',width:200,allowBlank:false,blankText: '图标名称不能为空',value:(row?row.get("iconInfoName"):"")},
			{
				xtype : 'textfield',
				fieldLabel : '图片地址', 
				name : 'userfile1', 
				id:'file1', 
				inputType : 'file',
				width : 260,
				//allowBlank : true,
				//blankText : '文件不能为空', 
				height : 25,
				anchor : '90%'
			},
			{
				bodyStyle:"padding-left:60px",
				html:"<br/><span><font color='#666666'></font></span>" 
			}
		],
		buttons : [
			{
				text : '确定',
				type : 'submit',
				handler : function(){
					//if(document.getElementById("iconInfoName").value == '' ) return; 
					//if(Ext.getDom("iconInfoName").value == '' ) return; 
					if(document.getElementById("file1").value == '' ) return; 
					//if (!img.form.isValid()) {return;}
					img.form.submit(
						{
							waitTitle: '请稍候',
							waitMsg : '正在上传 ......', 
							url : "json_iconInfoSave.asp?sType=add",
							method: 'POST',
							success: function(form,action){
								var Result = action.result;
								if (Result.success == true) {
									if(Result.msg==0){
										Ext.MessageBox.alert('提示','添加图标信息成功!');
									}else if(Result.msg==3){
										Ext.MessageBox.alert('提示','修改图标信息成功!');
									}
									iconInfo_win.close();
									iconInfo_search.load({params: {start: 0,limit:800}});
									//iconInfo_win.getComponent('img').form.reset();
									
								}
								else
								{
									if(Result.msg==1){
										Ext.MessageBox.alert('提示','添加图标信息失败!');
									}else if(Result.msg==4){
										Ext.MessageBox.alert('提示','修改图标信息失败!');
									}
								}
							},
							failure: function(form,action){
								//Ext.MessageBox.alert('提示', Result.message);
								//Ext.MessageBox.alert('提示', Result.msg);
								iconInfo_search.load({params: {start: 0,limit:800}});
							//	iconInfo_win.getComponent('img').form.reset();
							}
						}
					);
				}
			},
			{
				text : '关闭',
				type : 'submit',
				handler : function() {
					iconInfo_win.close();
				}
			}
		]
	});
	return img;
}
//--------------------------------标注图标管理结束-------------------------------------------------	



//员工管理开始
//--------------------------------员工管理开始-------------------------------------------------	

var employeeInfo_sm = new Ext.grid.CheckboxSelectionModel({header: " ",sortable: true,width: 20});
var employeeInfo_cm = new Ext.grid.ColumnModel([employeeInfo_sm,
	{header:'编号',dataIndex:'id',hidden:true},
	{header:'员工姓名',align:'center',dataIndex:'employee_name',width: 150},
	{header:'员工角色',align:'center',dataIndex:'employee_role',width: 200},
	{header:'员工电话',align:'center',dataIndex:'employee_tel',width: 200},
	{header:'员工性别',align:'center',dataIndex:'employee_sex',width: 200}
]);
//start 读取远程POI JSON数据显示在表格里
var proxy_employeeInfo= new Ext.data.HttpProxy({url:'json_employeeInfoSearch.asp?limit=100'});
var reader_employeeInfo = new Ext.data.JsonReader(
	{
		totalProperty:'mytotal',//记录总数
		root:'root',
		id:'id'
	},[
		{name:'id'},
		{name:'employee_name'},
		{name:'employee_role'},
		{name:'employee_tel'},
		{name:'employee_sex'}
	]
);
//构建员工管理store
//构建proxy
//构建store reader
//构建员工管理列表panel
//构建Store
employeeInfo_search = new Ext.data.Store({
	proxy:proxy_employeeInfo,
	reader:reader_employeeInfo
});

var grid_employeeInfo = new Ext.grid.GridPanel({
	store: employeeInfo_search,
	cm: employeeInfo_cm,
	loadMask: true,
	//closable: true,
	title: '员工列表',
	bbar: new Ext.PagingToolbar({
		pageSize:800,
		store:employeeInfo_search,
		displayInfo:true,
		//displayMsg:'显示第{0}条到第和第{1}条记录,一共{2}条',
		displayMsg:'显示第 {0} 条到 {1} 条记录，总共 {2} 条',
		emptyMsg:'没有记录',
		beforePageText: "第",
		afterPageText:"页 共{0}页"
	}),
	tbar: [
		{xtype: "textfield",width: 160,height: 20,baseCls: 'x-plain',id:'employeeInfoNameKeyWord',name:'employeeInfoNameKeyWord',allowBlank: true,emptyText: "搜索员工名称"},
		{xtype: "tbseparator"},
		{
			text: '&nbsp;搜索',icon: "img/page_find.png",cls: "x-btn-text-icon",
			handler: function(){
				//Ext.Msg.alert('提示','目前无数据');
				employeeInfo_search.removeAll();
				employeeInfo_search.load({
					params:{
						start: 0,
						limit:800,
						employeeInfoNameKeyWord:grid_employeeInfo.getTopToolbar().findById("employeeInfoNameKeyWord").getValue()
					},callback:function(r,options,success){if(employeeInfo_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				})
			}
		},
		{
			text: '添加',
			icon: "img/chart_pie_add.png",
			cls: "x-btn-text-icon",
			handler: function(){
				Ext.QuickTips.init();//开启表单提示
				employeeInfo_form_obj = creatEmployeeWindow();
				employeeInfo_win = new Ext.Window({title: "添加员工信息",width: 400,height: 180,modal: true,maximizable:false,resizable:false,items: employeeInfo_form_obj});
				employeeInfo_win.show();
			}
		},
			
//		{
//			text: '添加',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
//			handler: function(){
//				Ext.QuickTips.init();//开启表单提示
//				iconInfo_form_obj = imgFileUpload();
//				iconInfo_win = new Ext.Window({title: "添加图标信息",width: 500,height: 200,modal: true,maximizable:false,resizable:false,items: iconInfo_form_obj});
//				iconInfo_win.show();
//			}
//		},
//		{xtype: "tbseparator"},
//		{
//			text: '修改',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
//			handler: function(){
//				Ext.QuickTips.init();//开启表单提示
//				var row = grid_iconInfo.getSelectionModel().getSelections();
//				if (!row){return;}
//				for (var i = 0; i < row.length; i++)
//				{
//					Ext.form.Field.prototype.msgTarget = 'side';//设置提示信息位置为边上
//					iconInfo_form_obj = geticonInfoForm(row[i]);
//					iconInfo_win = new Ext.Window({title: "修改图标信息",width: 500,height: 200,modal: true,maximizable:false,resizable:false,items: iconInfo_form_obj});
//					iconInfo_win.show();
//					//field = hall_form_obj.getForm().findField('icon');
//					//field.setValue(row[i].get("icon"));//new
//					//alert(row[i].get("icon"))
//				}
//			}
//		},
		{xtype: "tbseparator"},
		{
			text: '删除',icon: "img/chart_pie_delete.png",cls: "x-btn-text-icon",
			handler: function(){
				var row = grid_employeeInfo.getSelectionModel().getSelections();
				if (row) {
					Ext.Msg.confirm("请确认", "是否真的删除此条记录?", function(butten, text){
						if (butten == "yes") {
							for (var i = 0; i < row.length; i++) {
								//alert(row[i].get("id"));
								Ext.Ajax.request({
									url: 'json_employeeInfoSave.asp?sType=del',
									params: 'id=' + row[i].get("id")
								});
							}
							employeeInfo_search.removeAll();
							employeeInfo_search.load({params: {start:0,limit:800}});
						}
					})
				}
			}
		}
	]
});

function creatEmployeeWindow(row){
	var employee = new Ext.FormPanel({
		region : 'center', 
		labelWidth : 70, 
		frame : true,
		bodyStyle : 'padding:5px 5px 0', 
		autoScroll : true, 
		border : false,
		//fileUpload : true, 
		items : [
			{xtype: 'hidden',name:'id',value:(row?srow.get("id"):"")},
			{xtype: 'textfield',name:'employee_name',fieldLabel: '员工名称',width:200,allowBlank:false,blankText: '员工名称不能为空',value:(row?row.get("employee_name"):"")},
			{xtype: 'textfield',name:'employee_role',fieldLabel: '员工角色',width:200,allowBlank:false,blankText: '员工角色不能为空',value:(row?row.get("employee_role"):"")},
			{xtype: 'textfield',name:'employee_tel',fieldLabel: '员工电话',width:200,allowBlank:false,blankText: '员工电话不能为空',value:(row?row.get("employee_tel"):"")},
			{xtype: 'textfield',name:'employee_sex',fieldLabel: '员工性别',width:200,allowBlank:false,blankText: '员工性别不能为空',value:(row?row.get("employee_sex"):"")}
		],
		buttons : [
			{
				text : '确定',
				type : 'submit',
				handler : function(){
					//if(document.getElementById("iconInfoName").value == '' ) return; 
					//if(Ext.getDom("iconInfoName").value == '' ) return; 
					//if(document.getElementById("file1").value == '' ) return; 
					//if (!img.form.isValid()) {return;}
					employee.form.submit(
						{
							waitTitle: '请稍候',
							waitMsg : '正在上传 ......', 
							url : "json_employeeInfoSave.asp?sType=add",
							method: 'POST',
							success: function(form,action){
								var Result = action.result;
								if (Result.success == true) {
									if(Result.msg==0){
										Ext.MessageBox.alert('提示','添加员工信息成功!');
									}else if(Result.msg==3){
										Ext.MessageBox.alert('提示','修改员工信息成功!');
									}
									employeeInfo_win.close();
									employeeInfo_search.load({params: {start: 0,limit:800}});
									//iconInfo_win.getComponent('img').form.reset();
									
								}
								else
								{
									if(Result.msg==1){
										Ext.MessageBox.alert('提示','添加图标信息失败!');
									}else if(Result.msg==4){
										Ext.MessageBox.alert('提示','修改图标信息失败!');
									}
								}
							},
							failure: function(form,action){
								//Ext.MessageBox.alert('提示', Result.message);
								//Ext.MessageBox.alert('提示', Result.msg);
								employeeInfo_search.load({params: {start: 0,limit:800}});
							//	iconInfo_win.getComponent('img').form.reset();
							}
						}
					);
				}
			},
			{
				text : '关闭',
				type : 'submit',
				handler : function() {
					employeeInfo_win.close();
				}
			}
		]
	});
	return employee;
}

//员工管理结束



//--------------------------------用户权理开始-------------------------------------------------	
var user_sm = new Ext.grid.CheckboxSelectionModel({header: " ",sortable: true,width: 20});
var user_cm = new Ext.grid.ColumnModel([user_sm,
	{header:'编号',dataIndex:'id'},
	{header:'用户名称',dataIndex:'username'},
	{header:'用户密码',dataIndex:'password'},
	{header:'用户权限',dataIndex:'permission',
		renderer:function(val){
			if(val == 1)
			{
				return "数据维护"
			}
			else
			{
				return "查询"
			}
		}
	}
	
]);
//start 读取远程POI JSON数据显示在表格里
var proxy_user = new Ext.data.HttpProxy({url:'json_userInfoSearch.asp'});
var reader_user = new Ext.data.JsonReader(
	{
		totalProperty:'mytotal',//记录总数
		root:'root',
		id:'id'
	},[
		{name:'id'},
		{name:'username'},
		{name:'password'},
		{name:'permission'}
	]
);
//构建Store
user_search = new Ext.data.Store({
	proxy:proxy_user,
	reader:reader_user
});

function user_permission()
{
	//alert(user_p);
	if(user_p == 1)
	{
		return false;
	}
	else
	{
		return true;
	}
}

function user_permission_name(row)
{
	//alert(user_p);
	//(row?row.get("username"):"")
	if(user_p == 1)
	{
		if(row)
		{
			if(row.get("username") == "admin")
			{
				return true;
			}
		}
		return false;
	}
	else
	{
		return true;
	}
}

var grid_user = new Ext.grid.GridPanel({
	store: user_search,
	cm: user_cm,
	loadMask: true,
	//closable: true,
	title: '用户管理列表',
	bbar: new Ext.PagingToolbar({
		pageSize:800,
		store:user_search,
		displayInfo:true,
		//displayMsg:'显示第{0}条到第和第{1}条记录,一共{2}条',
		displayMsg:'显示第 {0} 条到 {1} 条记录，总共 {2} 条',
		emptyMsg:'没有记录',
		beforePageText: "第",
		afterPageText:"页 共{0}页"
	}),
	tbar: [
		/*{
			xtype: "textfield",
			width: 160,
			height: 20,
			baseCls: 'x-plain',
			id:'userKeyWord',
			name:'userKeyWord',
			allowBlank: true,
			emptyText: "搜用户名称"
			,hidden:user_permission()
		},
		{xtype: "tbseparator"},
		{
			text: '&nbsp;搜索',icon: "img/page_find.png",cls: "x-btn-text-icon",
			handler: function(){
				//Ext.Msg.alert('提示','目前无数据');
				user_search.removeAll();
				user_search.load({
					params:{
						start: 0,
						limit:800,
						userKeyWord:grid_user.getTopToolbar().findById("userKeyWord").getValue()
					},callback:function(r,options,success){if(user_search.getCount() == 0){Ext.MessageBox.alert('提示', "搜索无结果");}}
				})
			}
			,hidden:user_permission()
		},*/
		{
			text: '添加',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
			handler: function(){
				Ext.QuickTips.init();//开启表单提示
				user_form_obj = getuserForm();
				user_win = new Ext.Window({title: "添加用户信息",width: 360,height: 160,modal: true,maximizable:false,resizable:false,items: user_form_obj});
				user_win.show();
			}
			,hidden:user_permission()
		},
		{xtype: "tbseparator"},
		{
			text: '修改',icon: "img/chart_pie_add.png",cls: "x-btn-text-icon",
			handler: function(){
				Ext.QuickTips.init();//开启表单提示
				var row = grid_user.getSelectionModel().getSelections();
				if (!row){return;}
				for (var i = 0; i < row.length; i++)
				{
					Ext.form.Field.prototype.msgTarget = 'side';//设置提示信息位置为边上
					user_form_obj = getuserForm(row[i]);
					user_win = new Ext.Window({title: "修改职位信息",width: 360,height: 160,modal: true,maximizable:false,resizable:false,items: user_form_obj});
					user_win.show();
					//field = hall_form_obj.getForm().findField('icon');
					//field.setValue(row[i].get("icon"));//new
					//alert(row[i].get("icon"))
				}
			}
		}
		,
		{xtype: "tbseparator"},
		{
			text: '删除',icon: "img/chart_pie_delete.png",cls: "x-btn-text-icon",
			handler: function(){
				var row = grid_user.getSelectionModel().getSelections();
				if (row) {
					Ext.Msg.confirm("请确认", "是否真的删除此条记录?", function(butten, text){
						if (butten == "yes") {
							for (var i = 0; i < row.length; i++) {
								//alert(row[i].get("id"));
								if(row[i].get("username") == "admin")
								{
									Ext.MessageBox.alert('提示','admin用户不可删除!');
									return;
								}
								Ext.Ajax.request({
									url: 'json_userInfoSave.asp?sType=del',
									params: 'id=' + row[i].get("id")
								});
							}
							user_search.removeAll();
							user_search.load({params: {start:0,limit:800}});
						}
					})
				}
			}
			,hidden:user_permission()
		}
	]
});

//生成新加机构点的菜单
function getuserForm(row)
{
	if(row){
		var stateCheck = (row?(row.get("permission")=="1")?true:false:false);
	}
	else
	{
		var stateCheck = true;
	}
	//网点数据结束
	return new Ext.FormPanel({
		id: 'user_form',
		name: 'user_form',
		//title: "",
		//bodyStyle: 'padding:5px 5px 0',
		width: 350,
		autoHeight: true,
		frame: true,
		renderTo: Ext.getBody(),
		layout: "form", // 整个大的表单是form布局
		labelWidth: 120,
		labelAlign: "right",
		items: [
			{xtype: 'hidden',name:'id',value:(row?row.get("id"):"")},
			{
				xtype: 'textfield',
				name:'username',
				fieldLabel: '用户名称',
				width:150,
				allowBlank:false,
				blankText: '用户名称不能为空',
				value:(row?row.get("username"):"")
				,readOnly:user_permission_name(row)
			},
			{xtype: 'textfield',name:'password',fieldLabel: '密码',width:150,allowBlank:false,blankText: '密码不能为空',value:(row?row.get("password"):"")},
			{
				xtype:"panel",
				layout:"column",
				fieldLabel:'用户权限',
				labelWidth:0.9,
				isFormField:false,
				items:[{
						columnWidth:0.4,
						//checked:(row?(row.get("stateDianPu")=="显示")?true:false:false),
						checked:stateCheck,
						xtype:'radio',
						boxLabel:'数据维护',
						name:'permission',
						inputValue:1
					},{
						columnWidth:0.6,
						checked:(row?(row.get("permission")=="0")?true:false:false),
						xtype:'radio',
						boxLabel:"查看",
						name:'permission',
						inputValue:0
					}
				]
			}
		],
		buttons: [{
			text: '确定',
			handler: function(){//添加网站
			//alert(customerInfo_win.getComponent('hall_form').form.findField("beginDateUpdate").getValue().replaceAll("-",","));
				if (user_win.getComponent('user_form').form.isValid()) {
					user_win.getComponent('user_form').form.submit({
						waitTitle: '请稍候',
						waitMsg: '正在提交数据,请稍候....',
						url: 'json_userInfoSave.asp?sType=add',
						method: 'POST',
						success: function(form,action){
							var Result = action.result;
							//alert(Result.success);
							if (Result.success == true) {
								if(Result.msg==0){
									Ext.MessageBox.alert('提示','添加用户信息成功!');
								}else if(Result.msg==3){
									Ext.MessageBox.alert('提示','修改用户信息成功!');
								}
								//alert(Result.msg);
								user_win.getComponent('user_form').form.reset();
								user_search.load({params: {start: 0,limit:2000}});
								user_win.close();
							}
							else
							{
								if(Result.msg==1){
									Ext.MessageBox.alert('提示','添加用户信息失败!');
								}else if(Result.msg==4){
									Ext.MessageBox.alert('提示','修改用户信息失败!');
								}
							}
						},
						failure: function(form,action){
							//Ext.MessageBox.alert('提示', Result.message);
							//Ext.MessageBox.alert('提示', Result.msg);
							user_search.load({params: {start: 0,limit:2000}});
							user_win.getComponent('user_form').form.reset();
							//customerInfo_win.getComponent('user_form').findById("hall_ezmarker").reset();
						}
					})
				}
			}
		}, {
			text: '取消',
			handler: function(){
				user_win.close();
			}
		}]
	});
}

//--------------------------------用户管理结束-------------------------------------------------	



//--------------------------------公共方法开始-------------------------------------------------	

//-------------全国城市列表开始-----------------------------
//城市列表窗口，参数type为树是否有复选框，1表示没有，2表示有
function citysWin(fun,type)
{
	citys_form_obj = citysForm(fun,type);
	citys_win = new Ext.Window({title: "城市列表",width: 213,height:375,modal: true,maximizable: false,resizable:false,items: citys_form_obj});
	citys_win.show();
}
function citysForm(fun,type)
{
	if(typeof type == "undefined" || type !=2 || type ==1)
	{
		var treeJSON = citys_tree_obj;
	}
	else
	{
		var treeJSON = citys_tree_obj_checked;
	}
	//全国的城市列表
	var treeCitys = new Ext.tree.TreePanel({
		//el: 'tree',
		//loader: new Ext.tree.TreeLoader({dataUrl:"citys/tree.asp"}),
		loader: new Ext.tree.TreeLoader(),
		//title: '系统管理',
		split: true,
		//border: true,
		rootVisible:false,
		autoScroll: true,
		//autoScroll:false,
		//collapsible: true,
		enableAllCheck:true,	//给树增加复选框
		width: 200,
		height:300
		//,
		//minSize: 80
	});
	
	var root = new Ext.tree.AsyncTreeNode({
		text:'root'
		,
		children: treeJSON
	});
	
	// 设置树的点击事件
	function treeClick(node, e)
	{
		//alert(node.text);
		
		//获取所有子节点
		/*node.cascade( function( node ){
			node.attributes.checked = flag;
			node.ui.checkbox.checked = flag;
			return true;
		});*/
		nodeCity = [];
		nodeCity.push(node.text);
		try
		{
			//获取所有父节点
			var pNode = node.parentNode;
			for(;pNode.id !="root";pNode = pNode.parentNode ){
				//alert(pNode.text);
				if (treeCitys.getChecked(id, node.parentNode) == "")
				{
					//alert(pNode.text);
					if(pNode.text!="root"&&pNode.text!="全国")
					{
						nodeCity.push(pNode.text);
					}
					//pNode.ui.checkbox.checked = flag;
					//pNode.attributes.checked = flag;
				}
			}
		}catch(e){}
	}
	// 增加鼠标单击事件
	treeCitys.on('click', function(node,e){
		nodeCity = [];
		nodeCity.push(node.text);
		try
		{
			//获取所有父节点
			var pNode = node.parentNode;
			for(;pNode.id !="root";pNode = pNode.parentNode ){
				if (treeCitys.getChecked(id, node.parentNode) == "")
				{
					if(pNode.text!="root"&&pNode.text!="全国")
					{
						nodeCity.push(pNode.text);
					}
				}
			}
		}catch(e){}							   
	});
	// 增加复选框架单击事件
	treeCitys.on('checkchange', function(node, checked){
		
		//nodeCityChecked = [];
		
		if(checked == false)
		{
			removeStr(nodeCityChecked,node.text);	
			return;
		}
		
		nodeCityChecked.push(node.text);
		/*try	//预留防止项目更改业务
		{
			//获取所有父节点
			var pNode = node.parentNode;
			for(;pNode.id !="root";pNode = pNode.parentNode ){
				alert(pNode.text);
				if (checked || treeCitys.getChecked(id, node.parentNode) == "")
				{
					if(pNode.text!="root"&&pNode.text!="全国")
					{
						nodeCityChecked.push(pNode.text);
					}
					pNode.ui.checkbox.checked = checked;
					pNode.attributes.checked = checked;
				}
			}
		}catch(e){}*/
	});
	
	treeCitys.setRootNode(root);
	treeCitys.expand();
	//root.reload();
	//Ajax提交新增请求后，在callback中刷新treeCitys的根节点，然后定位到当前节点
	//var path = currentNode.getPath('id');
	//treeCitys.getRootNode().reload();	//刷新树
	//treeCitys.expandPath(path,'id');
	
	var nodeCity = [];	//不带复选框返回的值
	var nodeCityChecked = [];	//带复选框返回的值
	var form1 = new Ext.form.FormPanel({
		width:200,
		//height:200,
		//frame:true,//圆角和浅蓝色背景
		//renderTo:Ext.getBody(),//呈现
		//title:"FormPanel",
		//bodyStyle:"padding:5px 5px 0",
		//defaults:{xtype:"textfield",width:120},
		items:[
			treeCitys
		],
		buttons:[
			{text:"确定",handler:function(){
				if(typeof type == "undefined" || type !=2 || type ==1)
				{
					//不带复选框返回的值
					fun(nodeCity);
				}
				else
				{
					//带复选框返回的值
					fun(nodeCityChecked);
				}
				
				citys_win.close()}
			},
			{text:"取消",handler:function(){citys_win.close()}}]
	});
	return form1;
}

//-------------全国城市列表结束-----------------------------

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
//图片预览
function imgPreview(value,cellmeta,record,store){
	var str="<img src='markerIcon/"+ record.data["iconInfoRoute"] +"'>";
	return str;
}







//将JSON对象转换成字符串
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
//--------------------------------公共方法结束-------------------------------------------------