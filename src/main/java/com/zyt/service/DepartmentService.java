package com.zyt.service;

import com.zyt.bean.Department;
import com.zyt.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        System.out.println("到达DepartmentService的getdepts");
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
