<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">

<link rel="stylesheet" type="text/css" href="<%=path %>/framework/jquery-easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/framework/jquery-easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/framework/jquery-easyui/demo/demo.css">
<script type="text/javascript" src="<%=path %>/framework/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/framework/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path %>/framework/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path %>/framework/My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path %>/framework/css/zs.css">
<script type="text/javascript" src="<%=path %>/framework/js/zs.js"></script>
<script type="text/javascript" src="<%=path %>/framework/js/public.js"></script>
<script type="text/javascript" src="<%=path %>/framework/json2/json2.js"></script>

<link rel="stylesheet" type="text/css" href="<%=path%>/framework/css/mainPagePart.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/framework/css/public.css">


<script type="text/javascript">
/*张顺，2017-2-25
 * ajax添加头信息
 * */
/* 
$.ajaxSetup({ 
	headers : {"token":"${user.licence}"},
	error:function(XMLHttpRequest, textStatus, errorThrown){
		alert(textStatus+" : "+XMLHttpRequest.status+"  "+errorThrown);
	}
}); 
*/
//------------张顺，2017-6-29，第一次进入页面不加载数据（开始）-------------------
var dg_options={};//数据表格的属性
var isDgInit=false;//数据表格是否初始化
/*该方法会在每个需要自定义列模板的jsp页面重写*/
function stylesheet(){
	return null;
}
function setColumns(sst){
	if(sst){
		$('#dg').datagrid({
			columns:sst
		});
	}
}
/*查询方法，如果需要自定义查询，请在自己的jsp中重写该方法*/
function search_toolbar(){
	var f=$('#search');
	if(f.form('validate')){
		isDgInit=true;
		var json=formToJson(f);
		$('#dg').datagrid('load', json);
	}
}
/**
 * 张顺，2017-10-20，重载查询方法，新增一个参数，使之可以自定义除了查询条件之外的额外参数
 */
function search_toolbar_2(opt){
	if(opt){
		var int1,int2,int3,int4,str1,str2,str3,str4,date1,date2,date3,date4;
		int1=opt.int1?opt.int1:null;
		int2=opt.int2?opt.int2:null;
		int3=opt.int3?opt.int3:null;
		int4=opt.int4?opt.int4:null;
		str1=opt.str1?opt.str1:null;
		str2=opt.str2?opt.str2:null;
		str3=opt.str3?opt.str3:null;
		str4=opt.str4?opt.str4:null;
		date1=opt.date1?opt.date1:null;
		date2=opt.date2?opt.date2:null;
		date3=opt.date3?opt.date3:null;
		date4=opt.date4?opt.date4:null;
		var f=$('#search');
		if(f.form('validate')){
			isDgInit=true;
			var json=formToJson(f);
			if(int1)json.int1=int1;
			if(int2)json.int2=int2;
			if(int3)json.int3=int3;
			if(int4)json.int4=int4;
			if(str1)json.str1=str1;
			if(str2)json.str2=str2;
			if(str3)json.str3=str3;
			if(str4)json.str4=str4;
			if(date1)json.date1=date1;
			if(date2)json.date2=date2;
			if(date3)json.date3=date3;
			if(date4)json.date4=date4;
			$('#dg').datagrid('load', json);
		}
	}else{
		search_toolbar();
	}
}
$(function(){
	//-----第一次进入不查---------------------------------------------
	dg_options.onLoadSuccess=function (data) {
		$(this).datagrid("fixRownumber");
	};
	dg_options.onBeforeLoad=function(param){
		if(isDgInit==false){
			return false;
		}else{
			return true;
		}
	};
	dg_options.loadFilter=function(data){
		var a=eval('('+"{'total':'0',rows:''}"+')');
		if (data){
			if(data.result){
				if(data.result=='error'){
					alert("错误:"+data.code+"  "+data.data);
					return a;
				}
			}else{
				return data;
			}
		}else{
			return a;
		}
	};
	dg_options.onLoadError=function(){
		alert("错误：-1  \n您操作太快了。\n也可能是未知原因，请联系开发者检查原因：(IT部)张顺、黄光辉。\n也可能是您还未登录。");
	};
	var sst=stylesheet();
	if(sst){
		dg_options.columns=sst;
	}
	$('#dg').datagrid(dg_options);
	//-------------张顺，2017-6-29，第一次进入页面不加载数据（结束）-----------------------------
});
</script>
<jsp:include page="/WEB-INF/jsp/part/hintModal.jsp"></jsp:include>