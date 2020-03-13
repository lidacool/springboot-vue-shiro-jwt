<template>
  <div>
    <el-dialog
      title="新增"
      :visible.sync="dialogFormVisible"
      width="30%">
      <el-form :model="form" :rules="rules" ref="form" label-width="100px" class="demo-ruleForm">
        <el-form-item label="appid" prop="appid">
          <el-input v-model="form.appid"></el-input>
        </el-form-item>
        <el-form-item label="secret" prop="secret">
          <el-input v-model="form.secret"></el-input>
        </el-form-item>
        <el-form-item label="appName" prop="appName">
          <el-input v-model="form.appName"></el-input>
        </el-form-item>
        <el-form-item label="accessToken" prop="accessToken">
          <el-input v-model="form.accessToken"></el-input>
        </el-form-item>
        <el-form-item label="expireTime" required>
          <el-col :span="11">
            <el-form-item prop="expireTime">
              <el-date-picker type="datetime" placeholder="选择日期" v-model="form.expireTime"
                              format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
            </el-form-item>
          </el-col>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('form')">立即创建</el-button>
          <el-button @click="resetForm('form')">重置</el-button>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
    <el-button type="primary" @click="dialogFormVisible = false">取消</el-button>
  </span>
    </el-dialog>
    <el-dialog
      title="修改"
      :visible.sync="dialogFormVisible2"
      width="30%">
      <el-form :model="form" :rules="rules" ref="form" label-width="100px" class="demo-ruleForm">
        <el-form-item label="appid" prop="appid">
          <el-input v-model="form.appid" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="secret" prop="secret">
          <el-input v-model="form.secret"></el-input>
        </el-form-item>
        <el-form-item label="appName" prop="appName">
          <el-input v-model="form.appName"></el-input>
        </el-form-item>
        <el-form-item label="accessToken" prop="accessToken">
          <el-input v-model="form.accessToken"></el-input>
        </el-form-item>
        <el-form-item label="expireTime" required>
          <el-col :span="11">
            <el-form-item prop="expireTime">
              <el-date-picker type="datetime" placeholder="选择日期" v-model="form.expireTime"
                              format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
            </el-form-item>
          </el-col>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="updateApp('form')">修改</el-button>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
    <el-button type="primary" @click="closeDialog2">取消</el-button>
  </span>
    </el-dialog>
    <h2>wechat_app</h2>
    <el-table
      ref="singleTable"
      highlight-current-row
      :data="apps"
      border
      style="width: 50%;margin: auto">
      <el-table-column
        prop="appid"
        label="appid"
        width="110">
      </el-table-column>
      <el-table-column
        prop="secret"
        label="secret">
      </el-table-column>
      <el-table-column
        prop="appName"
        label="appName">
      </el-table-column>
      <el-table-column
        prop="accessToken"
        label="accessToken">
      </el-table-column>
      <el-table-column
        label="expireTime"
        width="200px">
        <template slot-scope="scope">
          <span>{{dateFormat(scope.row.expireTime)}}</span>
        </template>
      </el-table-column>

      <el-table-column
        label="操作"
        width="100">
        <template slot-scope="scope">
          <el-button type="text" size="small">查看</el-button>
          <el-button type="text" size="small" @click="openDialog2(scope.row)">修改</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div style="margin-top: 20px">
      <el-button @click="openDialog()">新增</el-button>
    </div>
  </div>
</template>

<script>
  import {format} from "@/utils/datetime"

  export default {
    data() {
      return {
        apps: [],
        dialogFormVisible: false,
        dialogFormVisible2: false,
        form: {
          appid: '',
          secret: '',
          appName: '',
          accessToken: '',
          expireTime: ''
        },
        rules: {
          appid: [
            {required: true, message: '请输入appid', trigger: 'blur'}
          ],
          secret: [
            {required: true, message: '请输入secret', trigger: 'change'}
          ],
          appName: [
            {required: true, message: '请输入appName', trigger: 'change'}
          ],
          accessToken: [
            {required: true, message: '请输入accessToken', trigger: 'change'}
          ],
          expireTime: [
            {type: 'date', required: true, message: '请选择日期', trigger: 'change'}
          ]
        }
      }
    },
    created() {
      this.convert();
    },
    methods: {
      convert() {
        let params = new FormData();
        params.append("appid", "");
        this.$api.admin.apps(params)
          .then(res => {
            this.apps = res.apps;
          }).catch(err => {
          this.$message.error('网络请求异常!');
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      },
      submitForm(form) {
        this.$refs[form].validate((valid) => {
          if (valid) {
            this.$api.admin.createNewApp(JSON.stringify(this.form))
              .then(res => {
                this.dialogFormVisible = false;
                this.convert();
              })
              .catch(err => {
                this.$message.error('网络请求异常!');
              });
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      updateApp(form) {
        this.$refs[form].validate((valid) => {
          if (valid) {
            this.$api.admin.updateApp(JSON.stringify(this.form))
              .then(res => {
                this.dialogFormVisible2 = false;
                this.convert();
              })
              .catch(err => {
                this.$message.error('网络请求异常!');
              });
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      openDialog2(row) {
        this.form = {
          appid: row.appid,
          secret: row.secret,
          appName: row.appName,
          accessToken: row.accessToken,
          expireTime: row.expireTime
        };
        this.dialogFormVisible2 = true;
      },
      closeDialog2() {
        this.form = {};
        this.dialogFormVisible2 = false;
      },
      openDialog() {
        this.form = {
          appid: '',
          secret: '',
          appName: '',
          accessToken: '',
          expireTime: ''
        };
        this.dialogFormVisible = true;
      },
      dateFormat(value) {
        return format(value)
      }
    }
  }
</script>
