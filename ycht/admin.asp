<%@ codepage=65001%>
<%if session("login")<>"ok" then%>
<script language="JavaScript">
location.href="login.asp"
</script>
<%
response.End
end if%>
<HTML xmlns:v="urn:schemas-microsoft-com:vml">
<HEAD>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>管理后台</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<link rel="stylesheet" type="text/css" href="ext/ext-3.3.1/resources/css/ext-all.css" />
<!---->
<style type= "text/css"  media= "all" >    
    .allow- float  {clear:none!important;}  /* 允许该元素浮动 */    
    .stop- float  {clear:both!important;}  /* 阻止该元素浮动 */    
    .sex-male { float :right;}    
    .sex-female { float :left;}    
    .age-field { float :left;padding:0 0 0 58px;*padding:0 0 0 50px!important;*padding:0 0 0 50px;}    
    </style>
<!---->
<!-- GC -->
<!-- LIBS -->
<script type="text/javascript" src="ext/ext-3.3.1/adapter/ext/ext-base.js"></script>
<!-- ENDLIBS -->
<script type="text/javascript" src="ext/ext-3.3.1/ext-all.js"></script>
<!--<script type="text/javascript" src="ext/ext-3.3.1/src/locale/ext-lang-zh_CN.js"></script>-->
<script type="text/javascript" src="citys/tree.js"></script>
<script type="text/javascript" src="citys/tree_checked.js"></script>
<!--引入JavaScript文件-->
<!--<script language="javascript" src="http://58inn.com/shandongshihua/api/js/maps.js"></script>-->
<script language="javascript" src="http://api.51ditu.com/js/maps.js"></script>
<script language="javascript" src="http://api.51ditu.com/js/ezmarker.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script type="text/javascript" src="baiduAPI/MarkerTool_min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/CityList/1.2/src/CityList_min.js"></script>

<script language=javascript>
	Ext.BLANK_IMAGE_URL = 'ext/ext-3.3.1/resources/images/default/s.gif';
	function loginSearch()
	{
		location.href="search.asp";
	}
	
	var user_p = <%=session("p")%>;
	
	<%
		userAdmin = "'"&session("admin")&"'"
	%>
	
	var user_admin = <%=userAdmin%>;
	//alert(user_p);
</script>
<script language="javascript" src="config.js"></script>
<script language="javascript" src="admin.js"></script>
<style type="text/css">v\:*{behavior:url(#default#VML);}</style>
<style type="text/css">
.gradient{ 
/*width:300px; */
height:50px; 
text-align:right;
background:repeat-x 0 0;
background-image:url(img/bg.png); 
}

</style>
</HEAD>
<BODY leftmargin=0 topmargin=0 marginheight="0" marginwidth="0">
<div id="ezmarkerDiv" style="position:absolute;width:650px; height:450px; display:none">
<script language="javascript">
	var ezmarker=new LTEZMarker("ezmarker",1,document.getElementById("ezmarkerDiv"));	//创建一个ezmarker
	ezmarker.setIcon(new LTIcon("http://api.51ditu.com/img/ezmarker/tack.gif",[78,39]));
	ezmarker.setDefaultView("beijing",3);//设置ezmarker地图的默认视图位置到深圳
	//ezmarker.setSearch(true,"深圳");//设置默认搜索城市
	ezmarker.setSearch(true,"北京");//设置默认搜索城市
</script>
</div>
<div id="ezmarkerDivClose" style="position:absolute;width:14px; height:14px; display:none; background:url(http://api.51ditu.com/img/ezmarker/close.gif);"></div>
<div id="north-div" style="background-image:url(images/bg_head.jpg)"><img src="images/logo.png">
  <div style="position:absolute; right:160; top:15;font-size:12px">欢迎<%=session("admin")%>登陆</div>
  <div style="cursor:pointer" onClick="loginSearch();">
  	<div style="position:absolute; right:105; top:15;font-size:12px; background-image:url(images/logo.png); width:20px; height:20px"></div>
	<div style="position:absolute; right:30; top:15;font-size:12px">登录查询页面</div>
  </div>
</div>
<div id="shuoming">
  <div style="padding:20px;">
    <p class="STYLE1"> 后台系统说用简单说明： </p>
    <p class="STYLE1"> 1.点击左侧的列表选择管理的项目，并可以在上方的标签页之间切换 </p>
  </div>
</div>
<div id="window-win"></div>
<div id="south-div" style="font-size:12px;"><%=CC_CopyRight%></div>
</BODY>
</HTML>