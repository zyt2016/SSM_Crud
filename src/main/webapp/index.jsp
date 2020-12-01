<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>

    <%--web路径 不以/开始的相对路径以当前资源的路径为基准
        以/开始的路径是以服务器的路径为标准HTTP://localhost:3306/ 需要加上项目名称

        --%>
    <%pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/jQuery-v3.1.1.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>

</head>
<body>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <%--添加表单--%>
                    <form class="form-horizontal" id="add_form">
                        <div class="form-group">
                            <label for="emp_add_input" class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="emp_add_input" placeholder="安安">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_add_input1" value="男" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_add_input2" value="女"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">邮箱</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@zyt.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">部门名称</label>
                            <div class="col-sm-4">
                                <%--部门信息使用部门id即可--%>
                                <select class="form-control" name="dId" id="dept_add_select">

                                </select>
                            </div>
                        </div>

                    </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="emp_close_btn">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--搭建显示页面 使用BootStrap搭建--%>
<%--         固定宽度--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>增删改查标题占据12列(全部)中型屏幕</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-12">
            <button class="btn btn-primary" id="empAddModel_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_allBtn">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息
当前页码："+pageInfo.getPageNum()"总页码："+pageInfo.getPages());"总记录数："+pageInfo.getTotal());
        --%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <%--添加表单--%>
                <form class="form-horizontal" id="update_form">
                    <div class="form-group">
                        <label for="emp_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="emp_update_static"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_update_input1" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_update_input2" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@zyt.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-4">
                            <%--部门信息使用部门id即可--%>
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
        var totalRecord,currentPage;//全局总记录数
        //页面加载完成以后，直接发送一个Ajax请求,要到分页数据
        $(function () {
            //去首页
            to_page(1);
        });
        function to_page(pageNumber) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pageNumber="+pageNumber,
                type:"GET",
                success:function (data) {
                    console.log(data);
                    //1.解析并显示员工数据
                    build_emps_table(data);
                    //2.解析并显示分页信息
                    build_page_info(data);
                    build_page_nav(data);
                }
            });
        }
        function build_emps_table(data) {
            //加载之前清空以前表格数据
            $("#emps_table tbody").empty();
            var emps=data.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd= $("<td></td>").append(item.empId);
                var empNameTd= $("<td></td>").append(item.empName);
                var genderTd= $("<td></td>").append(item.gender);
                var emailTd= $("<td></td>").append(item.email);
                var deptNameTd= $("<td></td>").append(item.department.deptName);
                /*<button class="btn btn-primary btn-sm">
                  <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                    编辑</button>
                  <button class="btn btn-danger btn-sm">
                   <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                    删除 </button>
                * */
                var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                //为编辑按钮添加一个自定义属性表示当前员工的id
                editBtn.attr("edit-id",item.empId);
                var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义属性表示当前员工的id
                delBtn.attr("del-id",item.empId);
                var btnTd= $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //append方法执行完成之后还是返回原来的元素
                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd).append(empNameTd).append(genderTd)
                    .append(emailTd).append(deptNameTd).append(btnTd)
                    .appendTo("#emps_table tbody");
            });
        }
        //解析显示分页信息
        function build_page_info(data) {
            $("#page_info_area").empty();
            $("#page_info_area").append("当前第-"+data.extend.pageInfo.pageNum+"-页" +
                "&nbsp;&nbsp;共-"+data.extend.pageInfo.pages+"-页&nbsp;&nbsp;总计&nbsp;"+data.extend.pageInfo.total+"&nbsp;条记录");
            totalRecord=data.extend.pageInfo.total;
            currentPage=data.extend.pageInfo.pageNum;
        }
        //解析显示分页条,并跳转
        function build_page_nav(data) {
            //$("#page_nav_area");
            $("#page_nav_area").empty();
            var ul=$("<ul></ul>").addClass("pagination");
            //构造元素
            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
            if (data.extend.pageInfo.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else {
                //给元素添加单击翻页效果
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(data.extend.pageInfo.pageNum-1);
                });
            }

            var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
            if (data.extend.pageInfo.hasNextPage==false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                nextPageLi.click(function () {
                    to_page(data.extend.pageInfo.pageNum+1);
                });
                lastPageLi.click(function () {
                    to_page(data.extend.pageInfo.pages);
                });
            }

            //添加首页和前一页的提示
            ul.append(firstPageLi).append(prePageLi);
            //1 2 3 4 5页码 遍历添加到ul中
            $.each(data.extend.pageInfo.navigatepageNums,function (index,item) {
                var pageNumLi=$("<li></li>").append($("<a></a>").append(item));
                if (data.extend.pageInfo.pageNum==item){
                    pageNumLi.addClass("active");
                }
                pageNumLi.click(function () {
                    to_page(item);
                });
                ul.append(pageNumLi);
            });
            //添加下一页和尾页
            ul.append(nextPageLi).append(lastPageLi);
            //把ul加入到nav中
            var navEle=$("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }
        //清空表单样式和内容
        function reset_form(ele){
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error");
            $(ele).find("*").removeClass("has-success");
            $(ele).find(".help-block").text("");
        }
        //点击新增按钮弹出模态框
        $("#empAddModel_btn").click(function () {
            //清楚表单数据(表单重置)
            reset_form("#add_form");
            //发送Ajax请求，查出部门信息，显示在下拉列表中
            getDepts("#dept_add_select");
            //弹出模态框
            $("#empAddModel").modal({
                backdrop:"static"
            });
        });
        //查出所有的部门信息并显示在下拉列表中
        function getDepts(ele) {
            $(ele).empty();
            $.ajax({
                url: "${APP_PATH}/depts",
                type: "GET",
                success:function (data) {
                    console.log(data);
                    //显示部门信息在下拉列表中
                    $.each(data.extend.depts,function () {
                       var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                       optionEle.appendTo(ele);

                    });
                }
            });
        }
        //校验表单数据
        function validate_add_form(){
            //1、拿到校验的数据 使用正则表达式
            var empName = $("#emp_add_input").val();
            var regName=/(^[a-zA-Z0-9_-]{6,10}$)|(^[\u2E80-\u9FFF]{2,5}$)/;//6到10位
            if (!regName.test(empName)){
                //alert("用户名必须是2-5位中文或者6-10位的字母和数字的组合");
                show_validate_msg("#emp_add_input","error","用户名必须是2-5位中文或者6-10位的字母和数字的组合validate_add_form");
                return false;
            }else {
                show_validate_msg("#emp_add_input","success","");
            }
            //校验邮箱信息
            var email = $("#email_add_input").val();
            var regEmail=/^([a-z0-9_\\.-]+)@([\da-z\\.-]+)\.([a-z\\.]{2,6})$/;
            if (!regEmail.test(email)){
                //alert("邮箱格式错误...");
                show_validate_msg("#email_add_input","error","邮箱格式错误...validate_add_form");
                return false;
            }else {
                show_validate_msg("#email_add_input","success","");
            }
            return true;
        }
        //显示校验结果信息的显示
        function show_validate_msg(ele,status,msg){
            //应该清空元素的校验状态
            $(ele).parent().removeClass("has-success");
            $(ele).parent().removeClass("has-error");
            $(ele).next("span").text("");
            if ("success"==status){
                $(ele).parent().addClass("has-success");
            }else if ("error"==status){
                $(ele).parent().addClass("has-error");
            }
            $(ele).next("span").text(msg);
        }
        //检验用户名是否可用
        $("#emp_add_input").change(function () {
            //发送Ajax请求校验用户名是否可用
            var empName = this.value;
            $.ajax({
                url:"${APP_PATH}/checkUserName",
                data:"empName="+empName,
                type:"POST",
                success:function (data1) {
                    if (data1.code==101){
                        show_validate_msg("#emp_add_input","success","用户名可用emp_add_input");
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else {
                        show_validate_msg("#emp_add_input","error",data1.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
                }
            });
        });

        //模态框中的保存员工按钮点击保存事件
        $("#emp_save_btn").click(function () {
            //模态框中填写的表单数据提交给服务器进行保存
            //校验填写的数据格式
            if (!validate_add_form()){
                return false;
            }
            //判断之前的Ajax请求校验用户名是否可用
            if ($(this).attr("ajax-va")=="error"){
                return false;
            }
            //发送ajax请求保存员工
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#add_form").serialize(),
                success:function (data1) {
                    if (data1.code == 101){
                        //员工保存成功
                        //1.关闭模态框
                        $("#empAddModel").modal('hide');
                        //2.来到最后一页发送Ajax请求并显示保存数据
                        to_page(totalRecord);
                    }else {
                        //显示检验失败信息
                        //console.log(data);
                        //有哪个字段的错误信息就显示那个字段的
                        if (undefined!=data1.extend.errorFields.email){
                            show_validate_msg("#email_add_input","error",data1.extend.errorFields.email);
                        }
                        if (undefined!=data1.extend.errorFields.empName){
                            show_validate_msg("#emp_add_input","error",data1.extend.errorFields.empName);
                        }
                    }

                }
            });
        });
        //编辑按钮点击事件
        //使用on去给后添加的元素的后代绑定单击事件
        $(document).on("click",".edit_btn",function () {
            //1.查出部门信息并显示
            getDepts("#dept_update_select");
            //2.查出员工信息并显示
            getEmp($(this).attr("edit-id"));
            //把员工的id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
            //弹出模态框
            $("#empUpdateModel").modal({
                backdrop:"static"
            });
        });
        //获取某id的员工
        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (data1) {
                    var empData=data1.extend.emp;
                    $("#emp_update_static").text(empData.empName);
                    $("#email_update_input").text(empData.email);
                    $("#empUpdateModel input[name=gender]").val([empData.gender]);
                    $("#empUpdateModel select").val([empData.dId]);

                }
            });
        }
        //点击更新，更新员工信息
        $("#emp_update_btn").click(function () {
            //验证邮箱是否合法
            var email = $("#email_update_input").val();
            var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)){
                //alert("邮箱格式错误...");
                show_validate_msg("#email_update_input","error","邮箱格式错误...validate_add_form");
                return false;
            }else {
                show_validate_msg("#email_update_input","success","");
            }
            //发送Ajax请求保存更新的员工数据
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#update_form").serialize(),
                success:function (data1) {
                    //1.关闭模态框
                    $("#empUpdateModel").modal("hide");
                    //2.来到原来页发送Ajax请求并显示保存数据
                    to_page(currentPage);
                }
            });
        });
        //删除按钮点击事件
        //使用on去给后添加的元素的后代绑定单击事件
        $(document).on("click",".delete_btn",function () {
            //弹出确认删除的对话框
            var empName=$(this).parent("td").parent("tr").find("td:eq(2)").text();
            if (confirm("确认删除【"+empName+"】吗？")){
                //确认，发送Ajax请求删除即可
                $.ajax({
                    url:"${APP_PATH}/emp/"+$(this).attr("del-id"),
                    type:"DELETE",
                    success:function (data1) {
                        alert(data1.msg);
                        to_page(currentPage);
                    }
                });
            }
        });
        //完成全选/全不选功能
        $("#check_all").click(function () {
            //dom原生的属性:attr获取自定义属性
            //prop修改和读取dom原生属性的值
            $(".check_item").prop("checked",$(this).prop("checked"));
        });
        //check_item
        $(document).on("click",".check_item",function () {
            //判断当前选择中的元素是否是5个
            var flag = $(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked",flag);
        });
        //点击全部删除
        $("#emp_delete_allBtn").click(function () {
            var empNames="";
            var del_ids="";
            $.each($(".check_item:checked"),function () {
                empNames+=$(this).parent("td").parent("tr").find("td:eq(2)").text()+",";
                //组装员工id字符串
                del_ids+=$(this).parent("td").parent("tr").find("td:eq(1)").text()+"-";
            });
            //去除empNames多余的分隔符,
            empNames=empNames.substring(0,empNames.length-1);
            //去除id多余的-
            del_ids=del_ids.substring(0,del_ids.length-1);
            if (confirm("确认删除【"+empNames+"】吗？")){
                //发送Ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_ids,
                    type:"DELETE",
                    success:function (data1) {
                        alert(data1.msg);
                        to_page(currentPage);
                    }
                });
            }
        });
    </script>
</body>
</html>
