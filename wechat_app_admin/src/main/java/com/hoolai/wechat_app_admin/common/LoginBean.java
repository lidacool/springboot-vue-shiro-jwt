package com.hoolai.wechat_app_admin.common;

import lombok.Data;

@Data
public class LoginBean {
    /** 用户名 */
    private String name;
    /** 密码 */
    private String password;
    /** 验证码 */
    private String captcha;
}
