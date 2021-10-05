<%@ codepage=65001%>
<%
session("login")="isOk"
session("admin")=null
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>后台管理登录界面</title>
    <link href="style/alogin.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
<body>
    <form action="login_chk.asp" method="post" name="login" id="login">
    <div class="Main">
        <ul>
            <li class="top"></li>
            <li class="top2"></li>
            <li class="topA"></li>
            <li class="topB"><span>
                <img src="images/login/logo.gif" alt="" style="" />
            </span></li>
            <li class="topC"></li>
            <li class="topD">
                <ul class="login">
                    <li>
						<span class="left">用户名：</span>
						<span style="left">
							<input id="username" name="username" type="text" class="txt" />
						</span>
					</li>
					<li>
						<span class="left">密 码：</span>
						<span style="left">
						   <input id="userpass" name="userpass" type="password" class="txt" />
						</span>
					</li>
					<li>
						<span class="left">登录类型：</span>
						<span style="left">
						   <select id="loginType" name="loginType">
								<option>查询</option>
								<option>管理</option>
							</select>
						</span>
					</li>
					<li>
						<span class="left">验证码：</span>
						<span style="left">
							<input id="txt_check" name="txt_check" type="text" class="txtCode" />
						</span>
						<span style=" position:absolute;top:274px">
							<img width="50px" height="20px" src="checkcode.asp" alt="验证码,看不清楚?请点击刷新验证码" style="cursor : pointer;" onClick="this.src='checkcode.asp?t='+(new Date().getTime());" >
						</span>
					</li>
<!--                    <li>
                    	<span class="left">记住我：</span>
                        <input id="Checkbox1" type="checkbox" />
						
                    </li>-->
                </ul>
            </li>
            <li class="topE"></li>
            <li class="middle_A"></li>
            <li class="middle_B"></li>
            <li class="middle_C">
            <span class="btn">
				<input type="submit" name="submit" value="" class="bottom"/>
               <!-- <img alt="" src="images/login/btnlogin.gif" />-->
            </span>
            </li>
            <li class="middle_D"></li>
            <li class="bottom_A"></li>
            <li class="bottom_B"></li>
        </ul>
    </div>
    </form>
</body>
</html>