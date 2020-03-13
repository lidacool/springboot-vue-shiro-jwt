package com.hoolai.wechat_app_admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hoolai.wechat_app_admin.entity.SysRoleMenu;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface RoleMenuMapper extends BaseMapper<SysRoleMenu> {
}
