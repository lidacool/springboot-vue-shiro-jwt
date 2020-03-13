package com.hoolai.wechat_app_admin.controller;

import com.hoolai.wechat_app_admin.aspect.Log;
import com.hoolai.wechat_app_admin.common.page.PageRequest;
import com.hoolai.wechat_app_admin.common.result.CommonResult;
import com.hoolai.wechat_app_admin.entity.SysDict;
import com.hoolai.wechat_app_admin.service.DictService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("dict")
public class DictController {

    @Autowired
    private DictService dictService;

    @Log("新增字典")
    @RequiresPermissions({"sys:dict:add", "sys:dict:edit"})
    @PostMapping(value="/save")
    public CommonResult save(@RequestBody SysDict record) {
        return CommonResult.success(dictService.saveOrUpdate(record));
    }

    @Log("删除字典")
    @RequiresPermissions("sys:dict:delete")
    @PostMapping(value="/delete")
    public CommonResult delete(@RequestBody List<SysDict> records) {
        dictService.delete(records);
        return CommonResult.success(1);
    }

    @RequiresPermissions("sys:dict:view")
    @PostMapping(value="/findPage")
    public CommonResult findPage(@RequestBody PageRequest pageRequest) {
        return CommonResult.success(dictService.findPage(pageRequest));
    }

    @RequiresPermissions("sys:dict:view")
    @GetMapping(value="/findByLable")
    public CommonResult findByLable(@RequestParam String lable) {
        return CommonResult.success(dictService.findByLable(lable));
    }
}
