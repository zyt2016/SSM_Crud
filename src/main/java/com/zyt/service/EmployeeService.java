package com.zyt.service;

import com.zyt.bean.Employee;
import com.zyt.bean.EmployeeExample;
import com.zyt.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;
    //查询所有员工
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }
    //员工保存方法
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }
    //检验用户名是否可用
    public boolean checkUserName(String empName) {

        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count==0;
    }
    //按照员工id查询员工
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }
    //员工更新信息
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
    //员工删除
    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }
    //批量删除
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from 表 where emp_id in(1 ,2 ,3)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
