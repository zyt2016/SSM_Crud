package com.zyt.bean;


import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

//通用返回的类
public class Msg {
    //状态码 101-成功 202-失败
    private int code;
    //提示信息
    private String msg;
    //用户要返回给浏览器的数据
    private Map<String,Object> extend=new HashMap<>();

    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(101);
        msg.setMsg("成功...");
        return msg;
    }
    public static Msg fail(){
        Msg msg = new Msg();
        msg.setCode(202);
        msg.setMsg("失败...");
        return msg;
    }
    public Msg add(String key, Object value) {
        this.getExtend().put(key,value);
        return this;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }


}
