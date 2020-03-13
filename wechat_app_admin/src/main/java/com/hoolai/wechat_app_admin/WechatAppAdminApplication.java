package com.hoolai.wechat_app_admin;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@MapperScan(basePackages = {"com.hoolai.wechat_app_admin.mapper"})
@ComponentScan(basePackages = { "com.hoolai.wechat","com.hoolai.wechat_app_admin"})
public class WechatAppAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(WechatAppAdminApplication.class, args);
    }

}
