package com.zyt.test;


import com.zyt.bean.Department;
import com.zyt.bean.Employee;
import com.zyt.dao.DepartmentMapper;
import com.zyt.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.ws.rs.core.Context;
import java.util.UUID;

/*
*
 * @author 老K咯咖路
 * @date 2020/11/26 15:18
 * @param
 * @return
 * @throws
 *  测试dao层工作的方法
 * 推荐spring的项目就可以使用spring的单元测试，可以自动注入我们需要的组件
* */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    //测试departmentMapper
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
        /*//创建springIOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        //从容器中获取mapper
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
        System.out.println(departmentMapper);
        //插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部2"));
//        departmentMapper.insertSelective(new Department(null,"测试部2"));
//        //生成员工数据，测试员工插入
        //employeeMapper.insertSelective(new Employee(null,"安安3","女","aa3@zyt.com",1));
        //批量插入多个员工，使用可执行批量操作的sqlSession
        /*for (){
            employeeMapper.insertSelective(new Employee(null,"安安3","女","aa3@zyt.com",1));
        }*/
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i <1000 ; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uid,"女",uid+"@zyt.com",2));
        }
        System.out.println("完成...");
        //employeeMapper.insertSelective(new Employee(null,"安安3","女","aa3@zyt.com",1));
    }
}
