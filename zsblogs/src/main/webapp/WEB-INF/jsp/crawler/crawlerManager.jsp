<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<jsp:include page="/WEB-INF/jsp/part/include_bootstrap.jsp"/>
    <base href="<%=basePath%>">
    <title>爬虫管理</title>
    <script type="text/javascript">
    	
    $(function(){
    	refreshHtml();
    });
    function refreshHtml(){
    	pullRequest({
    		urlb:"/api/crawler/info",
    		type:"get",
    		success:function(data){
   				$("#blogSer").html(data.blogSer?"[已加载]":"[未加载]");
   				var str="";
   				$.each(data.urls, function(key, val) {
   					str=str+val+"<br>";
   				});
   				$("#urls").html(str);
   				$("#isBegin").html(data.isBegin?"true":"false");
   				
   				if (data.isBegin) {//已开启
					$("#btn_begin").addClass("disabled");
					$("#btn_finish").removeClass("disabled");
				}else{//已关闭
					$("#btn_begin").removeClass("disabled");
					$("#btn_finish").addClass("disabled");
				}
    		}
    	});
    }
    function addURL(){
    	pullRequest({
    		urlb:"/api/crawler/addurl",
    		type:"post",
    		data:{url:$("#targetURL").val()},
    		success:function(data){
    			alert(data);
    			refreshHtml();
    		}
    	});
    }
    function begin(){
    	pullRequest({
    		urlb:"/api/crawler/control",
    		type:"get",
    		data:{isBegin:true},
    		success:function(data){
    			alert(data);
    			refreshHtml();
    		}
    	});
    }
    function finish(){
    	pullRequest({
    		urlb:"/api/crawler/control",
    		type:"get",
    		data:{isBegin:false},
    		success:function(data){
    			alert(data);
    			refreshHtml();
    		}
    	});
    }
    </script>
    <style type="text/css">
    
    </style>
  </head>
  
  <body>
  	<jsp:include page="/WEB-INF/jsp/part/left_part.jsp"/>
  	<div class="p_body">
		
		<div class="body_top_jiange"></div>	
  		<div class="container" style="width: 90%;">
		    
		    
		    
			<h3>爬虫机器人1号</h3>
	    	
	    	<div class="btn-group">
		    	<button id="btn_begin" class="btn btn-danger span2" onclick="begin()">开启</button>
		    	<button id="btn_finish" class="btn btn btn-danger span2" onclick="finish()">关闭</button>
		    	<button id="btn_finish" class="btn btn btn-danger span2" onclick="refreshHtml()">刷新</button>
	    	</div>
	    	
	    	
	    	<br>
	    	<br>
	    	
	    	<div class="input-append">
				<input class="span3" id="targetURL" type="text" placeholder="请输入目标URL..." style="height: inherit;">
				<button class="btn" type="button" onclick="addURL()">添加</button>
			</div>
	    	
	    	<div>
		    	<h4>目前的参数数值</h4>
		    	<table class="table">
					<tr>
						<td>blogSer</td>
						<td id="blogSer"></td>
					</tr>
					<tr>
						<td>urls</td>
						<td id="urls"></td>
					</tr>
					<tr>
						<td>isBegin</td>
						<td id="isBegin"></td>
					</tr>		    		
		    	</table>
	    	</div>
	    	
		    
		    
	    </div>
  		
  		
  		
  	</div>
  	
  </body>
</html>
