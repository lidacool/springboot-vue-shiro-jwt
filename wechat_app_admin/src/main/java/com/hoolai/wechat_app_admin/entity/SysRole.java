package com.hoolai.wechat_app_admin.entity;

import lombok.Data;


@Data
public class SysRole extends BaseModel {

    private String name;

    private String remark;

    private Byte delFlag;


}
