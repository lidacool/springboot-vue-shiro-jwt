-- ----------------------------
-- 禁用外键约束
-- ----------------------------
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `value` varchar(100) NOT NULL COMMENT '数据值',
  `label` varchar(100) NOT NULL COMMENT '标签名',
  `type` varchar(100) NOT NULL COMMENT '类型',
  `description` varchar(100) NOT NULL COMMENT '描述',
  `sort` decimal(10,0) NOT NULL COMMENT '排序（升序）',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', 'true', '菜单状态', 'sys_show_hide', '菜单状态', '0', 'admin', '2020-03-11 17:57:54', null, null, '菜单状态', '0');
INSERT INTO `sys_dict` VALUES ('2', 'true', '系统开关', 'sys_normal_disable', '系统开关', '1', 'admin', '2020-03-11 19:53:17', null, null, '系统开关', '0');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL,类型：1.普通页面（如用户管理， /sys/user） 2.嵌套完整外部页面，以http(s)开头的链接 3.嵌套服务器页面，使用iframe:前缀+目标URL(如SQL监控， iframe:/druid/login.html, iframe:前缀会替换成服务器地址)',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：sys:user:add,sys:user:edit)',
  `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='菜单管理';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', null, '', '0', 'el-icon-setting', '2', null, null, null, null, '0'), ('2', '用户管理', '1', '/sys/user', '', '1', 'el-icon-service', '1', null, null, null, null, '0'), ('3', '角色管理', '1', '/sys/role', '', '1', 'el-icon-view', '4', null, null, null, null, '0'), ('4', '菜单管理', '1', '/sys/menu', '', '1', 'el-icon-menu', '5', null, null, null, null, '0'), ('5', '字典管理', '1', '/sys/dict', '', '1', 'el-icon-collection', '7', null, null, null, null, '0'), ('6', '系统日志', '24', '/sys/log', 'sys:log:view', '1', 'el-icon-tickets', '8', null, null, null, null, '0'), ('7', '查看', '2', null, 'sys:user:view', '2', null, '0', null, null, null, null, '0'), ('8', '新增', '2', null, 'sys:user:add', '2', null, '0', null, null, null, null, '0'), ('9', '修改', '2', null, 'sys:user:edit', '2', null, '0', null, null, null, null, '0'), ('10', '删除', '2', null, 'sys:user:delete', '2', null, '0', null, null, null, null, '0'), ('11', '查看', '3', null, 'sys:role:view', '2', null, '0', null, null, null, null, '0'), ('12', '新增', '3', null, 'sys:role:add', '2', null, '0', null, null, null, null, '0'), ('13', '修改', '3', null, 'sys:role:edit', '2', null, '0', null, null, null, null, '0'), ('14', '删除', '3', null, 'sys:role:delete', '2', null, '0', null, null, null, null, '0'), ('15', '查看', '4', null, 'sys:menu:view', '2', null, '0', null, null, null, null, '0'), ('16', '新增', '4', null, 'sys:menu:add', '2', null, '0', null, null, null, null, '0'), ('17', '修改', '4', null, 'sys:menu:edit', '2', null, '0', null, null, null, null, '0'), ('18', '删除', '4', null, 'sys:menu:delete', '2', null, '0', null, null, null, null, '0'), ('19', '查看', '5', null, 'sys:dict:view', '2', null, '0', null, null, null, null, '0'), ('20', '新增', '5', null, 'sys:dict:add', '2', null, '0', null, null, null, null, '0'), ('21', '修改', '5', null, 'sys:dict:edit', '2', null, '0', null, null, null, null, '0'), ('22', '删除', '5', null, 'sys:dict:delete', '2', null, '0', null, null, null, null, '0'), ('23', 'icon图标', '0', '/icon/index', '', '1', 'el-icon-picture-outline', '4', null, null, null, null, '0'), ('24', '系统监控', '0', '', '', '0', 'el-icon-info', '3', 'admin', null, null, null, '0'), ('25', '系统主页', '0', '/', '', '1', 'el-icon-monitor', '0', null, null, null, null, '0'), ('26', 'jvm信息', '24', '/monitor/jvm', '', '1', 'el-icon-set-up', '2', null, null, null, null, '0'), ('27', '系统信息', '24', '/monitor/system', '', '1', 'el-icon-cpu', '4', null, null, null, null, '0'), ('28', 'App管理', '0', '', '', '0', 'el-icon-menu', '1', null, null, null, null, '0'), ('29', 'app', '28', '', '', '0', 'el-icon-goods', '1', null, null, null, null, '0'), ('30', '截图选老婆', '28', '', '', '0', 'el-icon-female', '2', null, null, null, null, '0'), ('31', '日历小程序', '28', '', '', '0', 'el-icon-time', '3', null, null, null, null, '0'), ('32', '其他', '28', '', '', '0', 'el-icon-news', '4', null, null, null, null, '0'), ('33', 'app配置表', '29', '/appManager/apps/appConf', '', '1', 'el-icon-key', '1', null, null, null, null, '0'), ('34', '管理app', '29', '/appManager/apps/appManager', '', '1', 'el-icon-wind-power', '2', null, null, null, null, '0'), ('35', '轮播图片管理', '30', '/appManager/chooseWife/uploadImg', '', '1', 'el-icon-picture', '1', null, null, null, null, '0'), ('36', '上传Excel', '32', '/appManager/other/uploadExcel', '', '1', 'el-icon-upload', '1', null, null, null, null, '0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色管理';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', 'admin', '超级管理员', 'admin', '2020-03-10 00:00:00', 'admin', '2020-03-10 19:07:18', '0');
INSERT INTO `sys_role` VALUES ('2', 'test', '测试人员', 'admin', '2020-03-10 00:00:00', 'admin', '2020-03-10 00:00:00', '0');
INSERT INTO `sys_role` VALUES ('3', 'visitor', '游客', 'admin', '2020-03-10 00:00:00', 'admin', '2020-03-10 00:00:00', '0');


-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='角色菜单';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '1', '1', 'admin', '2020-03-10 16:22:41', null, null), ('2', '1', '2', 'admin', '2020-03-10 16:22:41', null, null), ('3', '1', '3', 'admin', '2020-03-10 16:22:41', null, null), ('4', '1', '4', 'admin', '2020-03-10 16:22:41', null, null), ('5', '1', '5', 'admin', '2020-03-10 16:22:41', null, null), ('6', '1', '6', 'admin', '2020-03-10 16:22:41', null, null), ('7', '1', '7', 'admin', '2020-03-10 16:22:41', null, null), ('8', '1', '8', 'admin', '2020-03-10 16:22:41', null, null), ('9', '1', '9', 'admin', '2020-03-10 16:22:41', null, null), ('10', '1', '10', 'admin', '2020-03-10 16:22:41', null, null), ('11', '1', '11', 'admin', '2020-03-10 16:22:41', null, null), ('12', '1', '12', 'admin', '2020-03-10 16:22:41', null, null), ('13', '1', '13', 'admin', '2020-03-10 16:22:41', null, null), ('14', '1', '14', 'admin', '2020-03-10 16:22:41', null, null), ('15', '1', '15', 'admin', '2020-03-10 16:22:41', null, null), ('16', '1', '16', 'admin', '2020-03-10 16:22:41', null, null), ('17', '1', '17', 'admin', '2020-03-10 16:22:41', null, null), ('18', '1', '18', 'admin', '2020-03-10 16:22:41', null, null), ('19', '1', '19', 'admin', '2020-03-10 16:22:41', null, null), ('20', '1', '20', 'admin', '2020-03-10 16:22:41', null, null), ('21', '1', '21', 'admin', '2020-03-10 16:22:41', null, null), ('22', '1', '22', 'admin', '2020-03-10 16:22:41', null, null), ('23', '1', '23', 'admin', '2020-03-10 16:22:41', null, null), ('24', '1', '24', 'admin', '2020-03-10 16:22:41', null, null), ('25', '1', '25', 'admin', '2020-03-10 16:22:41', null, null), ('26', '1', '26', 'admin', '2020-03-10 16:22:41', null, null), ('27', '1', '27', 'admin', '2020-03-10 16:22:41', null, null), ('51', '3', '25', null, null, null, null), ('52', '3', '1', null, null, null, null), ('53', '3', '2', null, null, null, null), ('54', '3', '7', null, null, null, null), ('55', '3', '3', null, null, null, null), ('56', '3', '11', null, null, null, null), ('57', '3', '4', null, null, null, null), ('58', '3', '15', null, null, null, null), ('59', '3', '5', null, null, null, null), ('60', '3', '19', null, null, null, null), ('61', '3', '24', null, null, null, null), ('62', '3', '6', null, null, null, null), ('63', '3', '23', null, null, null, null), ('64', '2', '25', null, null, null, null), ('65', '2', '28', null, null, null, null), ('66', '2', '29', null, null, null, null), ('67', '2', '33', null, null, null, null), ('68', '2', '34', null, null, null, null), ('69', '2', '30', null, null, null, null), ('70', '2', '35', null, null, null, null), ('71', '2', '31', null, null, null, null), ('72', '2', '32', null, null, null, null), ('73', '2', '36', null, null, null, null), ('74', '2', '1', null, null, null, null), ('75', '2', '2', null, null, null, null), ('76', '2', '7', null, null, null, null), ('77', '2', '3', null, null, null, null), ('78', '2', '11', null, null, null, null), ('79', '2', '4', null, null, null, null), ('80', '2', '15', null, null, null, null), ('81', '2', '5', null, null, null, null), ('82', '2', '19', null, null, null, null), ('83', '2', '24', null, null, null, null), ('84', '2', '26', null, null, null, null), ('85', '2', '27', null, null, null, null), ('86', '2', '6', null, null, null, null), ('87', '2', '23', null, null, null, null);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `salt` varchar(40) DEFAULT NULL COMMENT '盐',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户管理';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'e9e38f4785af638faee697314387606d', '8A0SUW+RWGipDZgEevhplg==', 'admin@qq.com', '119', '1', 'admin', '2020-03-10 00:00:00', 'admin', '2020-03-10 01:21:18', '0');
INSERT INTO `sys_user` VALUES ('2', 'test', '3b69d2672bbafe626fa9a43ffc863699', 'XsMlh0JpHOlyffSu+Ft44g==', 'test@qq.com', '110', '1', 'admin', '2020-03-10 02:17:15', 'admin', '2020-03-10 02:17:15', '0');
INSERT INTO `sys_user` VALUES ('3', 'visitor', '2ef9bc0d92916ff67791fa7ee5dfc02c', 'IRw4F41jiX3B46SXkdsjhQ==', 'visitor@qq.com', '110', '1', 'admin', '2020-03-10 02:17:15', 'admin', '2020-03-10 02:17:45', '0');


-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1', '1', null, null, null, null);
INSERT INTO `sys_user_role` VALUES ('2', '2', '2', null, null, null, null);
INSERT INTO `sys_user_role` VALUES ('3', '3', '3', null, null, null, null);
