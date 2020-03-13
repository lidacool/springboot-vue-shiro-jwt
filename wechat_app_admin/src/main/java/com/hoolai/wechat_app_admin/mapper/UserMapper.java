package com.hoolai.wechat_app_admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hoolai.wechat_app_admin.entity.SysUser;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserMapper extends BaseMapper<SysUser> {
}
