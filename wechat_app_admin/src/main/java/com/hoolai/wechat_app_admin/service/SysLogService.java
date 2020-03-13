package com.hoolai.wechat_app_admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hoolai.wechat_app_admin.common.page.PageRequest;
import com.hoolai.wechat_app_admin.common.page.PageResult;
import com.hoolai.wechat_app_admin.entity.SysLog;

public interface SysLogService extends IService<SysLog> {

    PageResult findPage(PageRequest pageRequest);
}
