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
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
            <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp" >
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                       <%-- <th>${emp.gender=="M"?"男":"女"}</th>--%>
                        <th>${emp.gender}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
            <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息
 当前页码："+pageInfo.getPageNum()"总页码："+pageInfo.getPages());"总记录数："+pageInfo.getTotal());
            --%>
            <div class="col-md-6">
                当前第-${pageInfo.pageNum}-页&nbsp;&nbsp;共-${pageInfo.pages}-页&nbsp;&nbsp;总计&nbsp;${pageInfo.total}&nbsp;条记录
            </div>
                <%--分页条信息--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li>
                            <a href="${APP_PATH}/emps?pageNumber=1">首页</a>
                        </li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pageNumber=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num==pageInfo.pageNum}">
                                <li class="active"><a href="#">${page_Num}</a></li>
                            </c:if>
                            <c:if test="${page_Num!=pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pageNumber=${page_Num}">${page_Num}</a></li>
                            </c:if>

                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pageNumber=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li>
                            <a href="${APP_PATH}/emps?pageNumber=${pageInfo.pages}">尾页</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
