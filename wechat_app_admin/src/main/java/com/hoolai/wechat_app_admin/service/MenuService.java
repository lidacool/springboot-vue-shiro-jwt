package com.hoolai.wechat_app_admin.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.hoolai.wechat_app_admin.entity.SysMenu;

import java.util.List;
import java.util.Set;

public interface MenuService extends IService<SysMenu> {

    Set<String> findPermsByUserId(long userId);

    List<SysMenu> findByUser(long userId, String userName, Wrapper<SysMenu> queryWrapper);

    List<SysMenu> findTree(String userName, int menuType, String name);
}
