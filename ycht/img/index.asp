
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
        <title>�����л�������ӹ���ϵͳ��½</title>
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
                Ext.QuickTips.init();//��������ʾ
                Ext.form.Field.prototype.msgTarget = 'side';//������ʾ��Ϣλ��Ϊ����
                var simple = new Ext.FormPanel({//��ʼ�������
                    id: 'login',
                    name: 'login',
                    labelWidth: 50, // Ĭ�ϱ�ǩ��Ȱ�
                    baseCls: 'x-plain',//�����ø�ֵ����������ԭ�������ú���봰����ȫ�ںϣ�-_-!!��˵�����ˣ���ҿ���ȥ�������¿�����
                    bodyStyle: 'padding:5px 5px 0',
                    width: 350,
                    border: false,
                    defaults: {
                        width: 230
                    },
                    defaultType: 'textfield',//Ĭ���ֶ�����
                    items: [{
                        fieldLabel: '�ʻ�',
                        name: 'username',
                        allowBlank: false,//��ֹΪ��
                        blankText: '�ʻ�����Ϊ��'
                    }, {
                        fieldLabel: '����',
                        name: 'userpass',
                        inputType: 'password',
                        allowBlank: false,//��ֹΪ��
                        blankText: '���벻��Ϊ��'//�����ƶ������ͣ��������api�ĵ�
                    }/**{
                        fieldLabel: '��֤��',
                        id: 'chknumber',
                        name: 'chknumber',
                        width: 50,
                        style: 'background:url(chknumber.php);background-repeat: no-repeat;',
                        allowBlank: false,//��ֹΪ��
                        blankText: '��֤�벻��Ϊ��'//�����ƶ������ͣ��������api�ĵ�
                    }**/],
                    keys: {
                        key: 13,
                        fn: submit_login
                    },
                    buttons: [{
                        text: '��¼',
                        handler:submit_login
                    }, {
                        text: 'ȡ��',
                        handler: function(){
                            simple.form.reset();
                        }//���ñ�
                    }]
                });
                 function submit_login(){
                            if (win.getComponent('login').form.isValid()) {
                                win.getComponent('login').form.submit({
                                    url: 'login_chk.asp',
                                    waitTitle: '��ʾ',
                                    method: 'POST',
                                    waitMsg: '���ڵ�¼��֤,���Ժ�...',
                                    success: function(form, action){
                                        var loginResult = action.result.success;
                                        if (loginResult == false) {
                                            Ext.MessageBox.alert('��ʾ', action.result.message);
											//simple.findById("chknumber").el.dom.style.backgroundImage="url(chknumber.php?t="+new Date().valueOf()+")";
                                        }
                                        else 
                                            if (loginResult == true) {
                                                Ext.MessageBox.alert('��ʾ', action.result.message);
                                                try{window.location.href = 'hancheng.asp';}catch(e){}
                                            }
                                    },
                                    failure: function(form, action){
										//simple.findById("chknumber").el.dom.style.backgroundImage="url(chknumber.php?t="+new Date().valueOf()+")";
                                        Ext.MessageBox.alert('��ʾ', action.result.message);
                                        win.getComponent('login').form.reset();
                                        
                                    }
                                });
                            }
                        }
                //�������壬�������֮����彲
                win = new Ext.Window({
                    id: 'win',
                    title: '��½',
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
                    items: simple//��Ϊ����Ԫ��
                });
                win.show();
            });
        </script>
    </body>
</html>
