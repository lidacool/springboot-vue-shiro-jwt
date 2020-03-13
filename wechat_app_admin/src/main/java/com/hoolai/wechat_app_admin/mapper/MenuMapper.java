package com.hoolai.wechat_app_admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hoolai.wechat_app_admin.entity.SysMenu;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface MenuMapper extends BaseMapper<SysMenu> {

    /**
     * 根据用户id查询资源集合
     *
     * @param roleId
     * @return set
     */
    List<SysMenu> findByRoleId(Long roleId);

}
