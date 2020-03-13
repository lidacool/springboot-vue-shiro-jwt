import axios from '../axios'

/********app内部管理模块*********/
export const appConfs = (params) => {
  return axios({
    url: '/admin/appConfs',
    method: 'get',
    params
  })
}
// 修改app配置表createAppConf
export const updateAppConf = (data) => {
  return axios({
    url: '/admin/updateAppConf',
    method: 'post',
    headers: {
      'Content-Type': 'application/json'
    },
    data
  })
}
// 新增app配置表
export const createAppConf = (data) => {
  return axios({
    url: '/admin/createAppConf',
    method: 'post',
    headers: {
      'Content-Type': 'application/json'
    },
    data
  })
}
// 获取app内容
export const apps = (params) => {
  return axios({
    url: '/admin/apps',
    method: 'get',
    params
  })
}
//新增app
export  const createNewApp = (data) =>{
  return axios({
    url: '/admin/createNewApp',
    method: 'post',
    headers: {
      'Content-Type': 'application/json'
    },
    data
  })
}
//修改app
export  const updateApp = (data) =>{
  return axios({
    url: '/admin/updateApp',
    method: 'post',
    headers: {
      'Content-Type': 'application/json'
    },
    data
  })
}

/************截图选老婆************/
export  const getImg = (params) =>{
  return axios({
    url: '/admin/getImg',
    method: 'get',
    headers: {
      "appid": "1"
    },
    params
  })
}
//图片上传
export  const uploadImg = (data) =>{
  return axios({
    url: '/admin/uploadImg',
    method: 'post',
    headers: {
      "Content-Type": "multipart/form-data",
      "appid": "1"
    },
    data
  })
}
//图片删除
export  const deleteImg = (data) =>{
  return axios({
    url: '/admin/deleteImg',
    method: 'post',
    headers: {
      "appid": "1"
    },
    data
  })
}

/************其他功能************/
//Excel上传
export  const syncExcelToMysql = (data) =>{
  return axios({
    url: '/admin/syncExcelToMysql',
    method: 'post',
    headers: {
      "Content-Type": "multipart/form-data"
    },
    data
  })
}

