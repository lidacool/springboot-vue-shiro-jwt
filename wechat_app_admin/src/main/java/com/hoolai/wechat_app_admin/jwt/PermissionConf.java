package com.hoolai.wechat_app_admin.jwt;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Data
@Configuration
//@ConfigurationProperties(prefix = "my.shiro")
public class PermissionConf {

    @Value("${my.shiro.anonUrl}")
    private String anonUrl;

    @Value("${my.shiro.jwtTimeOut}")
    private long jwtTimeOut;
}
