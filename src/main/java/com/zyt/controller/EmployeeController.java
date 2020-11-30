package com.zyt.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyt.bean.Employee;
import com.zyt.bean.Msg;
import com.zyt.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/*
* 处理员工的增删查改请求
* */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;
    //导入jackson包
    /*●URI:
        ●/emp/{id} GET 查询员工
        ●/emp POST保存员工
        ●/emp/{id} PUT修改员工
        ●/emp/{id} DELETE 删除员工
    * */
    @RequestMapping("/checkUserName")
    @ResponseBody
    public Msg checkUserName(String empName){
        boolean result=employeeService.checkUserName(empName);
        return null;
    }
    //员工保存 //返回json数据
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pageNumber",defaultValue = "1") Integer pageNumber,
                               Model model) {
        //这是所有的员工数据
        //引入PageHelper分页插件
        //在查询之前只需要调用下面这个,传入页码以及每页的大小
        PageHelper.startPage(pageNumber,5);
        List<Employee> employeeList=employeeService.getAll();
        //使用PageInfo包装查询后的结果,只需将pageinfo交给页面就可以了
        //封装了详细的分页信息,包括查询出来的数据,传入连续显示的页面
        PageInfo page= new PageInfo(employeeList,5);
        return Msg.success().add("pageInfo",page);

    }
    /*//查询员工数据(分页查询)
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pageNumber",defaultValue = "1") Integer pageNumber,
                          Model model) {
        //这是所有的员工数据
        //引入PageHelper分页插件
        //在查询之前只需要调用下面这个,传入页码以及每页的大小
        PageHelper.startPage(pageNumber,5);
        List<Employee> employeeList=employeeService.getAll();
        //使用PageInfo包装查询后的结果,只需将pageinfo交给页面就可以了
        //封装了详细的分页信息,包括查询出来的数据,传入连续显示的页面
        PageInfo page= new PageInfo(employeeList,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }*/
}
