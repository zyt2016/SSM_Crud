package com.zyt.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyt.bean.Employee;
import com.zyt.bean.Msg;
import com.zyt.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        配置HttpPutFormContentFilter过滤器将请求头中的数据解析包装成一个map，
        request被重新包装 request.getParameter()被重写，就从自己封装的map中取数据
    * */
    //员工删除(单个和批量都可以) 1-2-3 1 2 3
    @RequestMapping(value = "/emp/{ids}",method =RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            //批量删除
            List<Integer> del_ids=new ArrayList<>();
            String[] strIds = ids.split("-");
            //组装id的集合
            for (String strId : strIds) {
                del_ids.add(Integer.parseInt(strId));
            }
            employeeService.deleteBatch(del_ids);
        }else {
            Integer id= Integer.parseInt(ids);
            employeeService.deleteEmpById(id);
        }

        return Msg.success();
    }
    //员工更新
    @RequestMapping(value = "/emp/{empId}",method =RequestMethod.PUT)
    @ResponseBody
    public Msg saveUser(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    //根据id查询员工
    @RequestMapping(value = "/emp/{id}",method =RequestMethod.GET)
    @ResponseBody
    public Msg updateUserName(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }
    //检查用户名是否可用
    @RequestMapping("/checkUserName")
    @ResponseBody
    public Msg checkUserName(@RequestParam("empName") String empName){
        System.out.println("到达checkUserName主体");
        //先判断用户名是否是合法的表达式
        String regName="(^[a-zA-Z0-9_-]{6,10}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if (!empName.matches(regName)){
            System.out.println("到达checkUserName方法");
            return Msg.fail().add("va_msg","用户名必须是2-5位中文或者6-10位的字母和数字的组合checkUserName");
        }
        //数据库用户名重复校验
        boolean result=employeeService.checkUserName(empName);
        if (result){
            return  Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名被占用checkUserName");
        }
    }
    //员工保存 //返回json数据
    //支持JSR303校验，导入Hibernate-Validator
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败返回失败
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }

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
