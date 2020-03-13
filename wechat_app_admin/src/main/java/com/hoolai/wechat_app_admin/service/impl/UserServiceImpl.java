package com.hoolai.wechat_app_admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hoolai.wechat_app_admin.common.page.ColumnFilter;
import com.hoolai.wechat_app_admin.common.page.PageRequest;
import com.hoolai.wechat_app_admin.common.page.PageResult;
import com.hoolai.wechat_app_admin.entity.SysRole;
import com.hoolai.wechat_app_admin.entity.SysUser;
import com.hoolai.wechat_app_admin.entity.SysUserRole;
import com.hoolai.wechat_app_admin.mapper.RoleMapper;
import com.hoolai.wechat_app_admin.mapper.UserMapper;
import com.hoolai.wechat_app_admin.mapper.UserRoleMapper;
import com.hoolai.wechat_app_admin.service.MenuService;
import com.hoolai.wechat_app_admin.service.UserService;
import com.hoolai.wechat_app_admin.utils.PasswordUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, SysUser> implements UserService {

    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private MenuService menuService;
    @Autowired
    private UserRoleMapper userRoleMapper;

    @Override
    public boolean save(SysUser record) {
        Long id = null;
        if(record.getId() == null || record.getId() == 0) {
            // 新增用户
            super.save(record);
            id = record.getId();
        } else {
            // 更新用户信息
            updateById(record);
        }
        // 更新用户角色
        if(id != null && id == 0) {
            return true;
        }
        if(id != null) {
            for(SysUserRole sysUserRole:record.getUserRoles()) {
                sysUserRole.setUserId(id);
            }
        } else {
            userRoleMapper.delete(new LambdaQueryWrapper<SysUserRole>().eq(SysUserRole::getUserId, record.getId()));
        }
        for(SysUserRole sysUserRole:record.getUserRoles()) {
            userRoleMapper.insert(sysUserRole);
        }
        return true;
    }

    @Override
    public PageResult findPage(PageRequest pageRequest) {
        PageResult pageResult = null;
        String name = getColumnFilterValue(pageRequest, "name");
        String email = getColumnFilterValue(pageRequest, "email");
        int pageNum = pageRequest.getPageNum();
        int pageSize = pageRequest.getPageSize();
        Page<SysUser> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<SysUser> queryWrapper = new LambdaQueryWrapper<>();
        if(!StringUtils.isEmpty(name)) {
            queryWrapper.eq(SysUser::getName, name);
            if(!StringUtils.isEmpty(email)) {
                queryWrapper.eq(SysUser::getEmail, email);
            }
        }
        IPage<SysUser> result = baseMapper.selectPage(page, queryWrapper);
        // 加载用户角色信息
        findUserRoles(result);
        pageResult = new PageResult(result);
        return pageResult;
    }

    @Override
    public SysUser findById(Long userId) {
        LambdaQueryWrapper<SysUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysUser::getId, userId);
        return baseMapper.selectOne(wrapper);
    }

    @Override
    public SysUser findByName(String userName) {
        LambdaQueryWrapper<SysUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysUser::getName, userName);
        return baseMapper.selectOne(wrapper);
    }

    @Override
    public void updateLoginTime(SysUser user) {
        user.setLastUpdateTime(new Date());
        updateById(user);
    }

    /**
     * 获取过滤字段的值
     * @param filterName
     * @return
     */
    public String getColumnFilterValue(PageRequest pageRequest, String filterName) {
        String value = null;
        ColumnFilter columnFilter = pageRequest.getColumnFilters().get(filterName);
        if(columnFilter != null) {
            value = columnFilter.getValue();
        }
        return value;
    }

    /**
     * 加载用户角色
     * @param page
     */
    private void findUserRoles(IPage page) {
        List<?> content = page.getRecords();
        for(Object object:content) {
            SysUser sysUser = (SysUser) object;
            List<SysUserRole> userRoles = findUserRoles(sysUser.getId());
            sysUser.setUserRoles(userRoles);
            sysUser.setRoleNames(getRoleNames(userRoles));
        }
    }

    private String getRoleNames(List<SysUserRole> userRoles) {
        StringBuilder sb = new StringBuilder();
        for(Iterator<SysUserRole> iter = userRoles.iterator(); iter.hasNext();) {
            SysUserRole userRole = iter.next();
            SysRole sysRole = roleMapper.selectById(userRole.getRoleId());
            if(sysRole == null) {
                continue ;
            }
            sb.append(sysRole.getRemark());
            if(iter.hasNext()) {
                sb.append(", ");
            }
        }
        return sb.toString();
    }

    @Override
    public void createUser(SysUser user) {
        user.setCreateTime(new Date());
        PasswordUtil.encryptPassword(user);
        save(user);
    }

    @Override
    public Set<String> findPermissions(String userName) {
        SysUser user = findByName(userName);
        if (user != null) {
            return menuService.findPermsByUserId(user.getId());
        }
        return new HashSet<>();
    }

    @Override
    public List<SysUserRole> findUserRoles(Long userId) {
        LambdaQueryWrapper<SysUserRole> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysUserRole::getUserId, userId);
        return userRoleMapper.selectList(wrapper);
    }

    public int delete(List<SysUser> users) {
        for (SysUser user : users) {
            removeById(user.getId());
        }
        return 1;
    }

}
