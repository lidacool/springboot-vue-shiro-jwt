package com.hoolai.wechat_app_admin.controller;

import com.hoolai.wechat_app_admin.aspect.Log;
import com.hoolai.wechat_app_admin.common.page.PageRequest;
import com.hoolai.wechat_app_admin.common.result.CommonResult;
import com.hoolai.wechat_app_admin.entity.SysUser;
import com.hoolai.wechat_app_admin.service.UserService;
import com.hoolai.wechat_app_admin.utils.PasswordUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @Log("新增/修改用户")
    @RequiresPermissions({"sys:user:add", "sys:user:edit"})
    @PostMapping(value="/save")
    public CommonResult save(@RequestBody SysUser record) {
        SysUser user = userService.findById(record.getId());
        if(user != null) {
            if("admin".equalsIgnoreCase(user.getName())) {
                return CommonResult.error("超级管理员不允许修改!");
            }
        }
        if(record.getPassword() != null) {
            if(user == null) {
                // 新增用户
                if(userService.findByName(record.getName()) != null) {
                    return CommonResult.error("用户名已存在!");
                }
                PasswordUtil.encryptPassword(record);
            } else {
                // 修改用户, 且修改了密码
                if(!record.getPassword().equals(user.getPassword())) {
                    PasswordUtil.encryptPassword(record);
                }
            }
        }
        return CommonResult.success(userService.save(record));
    }

    @Log("删除用户")
    @RequiresPermissions("sys:user:delete")
    @PostMapping(value="/delete")
    public CommonResult delete(@RequestBody List<SysUser> records) {
        for(SysUser record : records) {
            SysUser sysUser = userService.findById(record.getId());
            if(sysUser != null && "admin".equalsIgnoreCase(sysUser.getName())) {
                return CommonResult.error("超级管理员不允许删除!");
            }
        }
        return CommonResult.success(userService.delete(records));
    }

    @RequiresPermissions("sys:user:view")
    @GetMapping(value="/findByName")
    public CommonResult findByUserName(@RequestParam String name) {
        return CommonResult.success(userService.findByName(name));
    }

    @RequiresPermissions("sys:user:view")
    @GetMapping(value="/findPermissions")
    public CommonResult findPermissions(@RequestParam String name) {
        return CommonResult.success(userService.findPermissions(name));
    }

    @RequiresPermissions("sys:user:view")
    @GetMapping(value="/findUserRoles")
    public CommonResult findUserRoles(@RequestParam Long userId) {
        return CommonResult.success(userService.findUserRoles(userId));
    }

    @Log("查看用户")
    @RequiresPermissions("sys:user:view")
    @PostMapping(value="/findPage")
    public CommonResult findPage(@RequestBody PageRequest pageRequest) {
        return CommonResult.success(userService.findPage(pageRequest));
    }
}
