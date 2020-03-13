package com.hoolai.wechat_app_admin.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class SysUser extends BaseModel {

    private String name;

    private String password;

    private String salt;

    private String email;

    private String mobile;

    private Byte status;

    private Byte delFlag;
    @TableField(exist = false)
    private String roleNames;
    @TableField(exist = false)
    private List<SysUserRole> userRoles = new ArrayList<>();



}
