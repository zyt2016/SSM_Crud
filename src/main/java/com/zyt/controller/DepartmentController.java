package com.zyt.controller;


import com.zyt.bean.Department;
import com.zyt.bean.Msg;
import com.zyt.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

//处理和部门有关的请求
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    //返回所有的部门信息
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        System.out.println("到达depts");
        List<Department> list=departmentService.getDepts();
        return Msg.success().add("depts",list);
    }

}
