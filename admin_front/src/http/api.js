/*
 * 接口统一集成模块
 */
import * as login from './moudules/login'
import * as user from './moudules/user'
import * as role from './moudules/role'
import * as menu from './moudules/menu'
import * as dict from './moudules/dict'
import * as log from './moudules/log'
import * as sys from './moudules/jvm'
import * as admin from './moudules/wechatAppAdmin'


// 默认全部导出
export default {
    login,
    user,
    role,
    menu,
    dict,
    log,
    sys,
    admin
}
