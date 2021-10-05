
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
        <title>韩城市环境监察大队管理系统登陆</title>
        <link rel="stylesheet" type="text/css" href="ext-3.3.1/resources/css/ext-all.css" />
    
    <!-- GC -->
 	<!-- LIBS -->
 	<script type="text/javascript" src="ext-3.3.1/adapter/ext/ext-base.js"></script>
 	<!-- ENDLIBS -->

    <script type="text/javascript" src="ext-3.3.1/ext-all.js"></script>
        </script>
		  <script language=javascript>
 Ext.BLANK_IMAGE_URL = 'ext-3.3.1/resources/images/default/s.gif';
</script>
<style type="text/css">
body{

background-image:url(img/indexbg.jpg)}
</style>
        <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    </head>
    <body>
        <script>
            Ext.onReady(function(){
                Ext.QuickTips.init();//开启表单提示
                Ext.form.Field.prototype.msgTarget = 'side';//设置提示信息位置为边上
                var simple = new Ext.FormPanel({//初始化表单面板
                    id: 'login',
                    name: 'login',
                    labelWidth: 50, // 默认标签宽度板
                    baseCls: 'x-plain',//不设置该值，表单将保持原样，设置后表单与窗体完全融合（-_-!!，说不清了，大家可以去掉运行下看看）
                    bodyStyle: 'padding:5px 5px 0',
                    width: 350,
                    border: false,
                    defaults: {
                        width: 230
                    },
                    defaultType: 'textfield',//默认字段类型
                    items: [{
                        fieldLabel: '帐户',
                        name: 'username',
                        allowBlank: false,//禁止为空
                        blankText: '帐户不能为空'
                    }, {
                        fieldLabel: '密码',
                        name: 'userpass',
                        inputType: 'password',
                        allowBlank: false,//禁止为空
                        blankText: '密码不能为空'//可限制多种类型，具体参照api文档
                    }/**{
                        fieldLabel: '验证码',
                        id: 'chknumber',
                        name: 'chknumber',
                        width: 50,
                        style: 'background:url(chknumber.php);background-repeat: no-repeat;',
                        allowBlank: false,//禁止为空
                        blankText: '验证码不能为空'//可限制多种类型，具体参照api文档
                    }**/],
                    keys: {
                        key: 13,
                        fn: submit_login
                    },
                    buttons: [{
                        text: '登录',
                        handler:submit_login
                    }, {
                        text: '取消',
                        handler: function(){
                            simple.form.reset();
                        }//重置表单
                    }]
                });
                 function submit_login(){
                            if (win.getComponent('login').form.isValid()) {
                                win.getComponent('login').form.submit({
                                    url: 'login_chk.asp',
                                    waitTitle: '提示',
                                    method: 'POST',
                                    waitMsg: '正在登录验证,请稍候...',
                                    success: function(form, action){
                                        var loginResult = action.result.success;
                                        if (loginResult == false) {
                                            Ext.MessageBox.alert('提示', action.result.message);
											//simple.findById("chknumber").el.dom.style.backgroundImage="url(chknumber.php?t="+new Date().valueOf()+")";
                                        }
                                        else 
                                            if (loginResult == true) {
                                                Ext.MessageBox.alert('提示', action.result.message);
                                                try{window.location.href = 'hancheng.asp';}catch(e){}
                                            }
                                    },
                                    failure: function(form, action){
										//simple.findById("chknumber").el.dom.style.backgroundImage="url(chknumber.php?t="+new Date().valueOf()+")";
                                        Ext.MessageBox.alert('提示', action.result.message);
                                        win.getComponent('login').form.reset();
                                        
                                    }
                                });
                            }
                        }
                //构建窗体，窗体会在之后具体讲
                win = new Ext.Window({
                    id: 'win',
                    title: '登陆',
                    layout: 'fit',
                    width: 360,
                    height: 180,
                    bodyStyle: 'padding:5px;',
                    maximizable: false,
                    closeAction: 'close',
                    closable: false,
                    collapsible: true,
                    plain: true,
                    buttonAlign: 'center',
                    items: simple//作为窗体元素
                });
                win.show();
            });
        </script>
    </body>
</html>
