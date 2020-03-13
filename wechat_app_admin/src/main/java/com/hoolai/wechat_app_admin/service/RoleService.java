package com.hoolai.wechat_app_admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hoolai.wechat_app_admin.common.page.PageRequest;
import com.hoolai.wechat_app_admin.common.page.PageResult;
import com.hoolai.wechat_app_admin.entity.SysMenu;
import com.hoolai.wechat_app_admin.entity.SysRole;
import com.hoolai.wechat_app_admin.entity.SysRoleMenu;

import java.util.List;
import java.util.Set;

public interface RoleService extends IService<SysRole> {

    Set<String> findRoleByUserId(long userId);

    void delete(List<SysRole> roles);

    PageResult findPage(PageRequest pageRequest);

    List<SysMenu> findRoleMenus(long roleId);

    void saveRoleMenus(List<SysRoleMenu> sysRoleMenus);

    List<SysRole> findByName(String name);

}
