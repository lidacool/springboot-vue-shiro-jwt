<template>
  <div>
    <el-dialog
      title="新增"
      :visible.sync="dialogFormVisible"
      width="30%">
      <el-form :model="formData" :rules="rules" ref="formData" label-width="100px" class="demo-ruleForm">
        <el-form-item label="id" prop="id">
          <el-input v-model="formData.id" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="appid" prop="appid">
          <el-input v-model="formData.appid"></el-input>
        </el-form-item>
        <el-form-item label="confKey" prop="confKey">
          <el-input v-model="formData.confKey"></el-input>
        </el-form-item>
        <el-form-item label="confValue" prop="confValue">
          <el-input v-model="formData.confValue"></el-input>
        </el-form-item>
        <el-form-item label="description" prop="description">
          <el-input v-model="formData.description"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('formData')">立即创建</el-button>
          <el-button @click="resetForm('formData')">重置</el-button>
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
      <el-form :model="formData" :rules="rules" ref="formData" label-width="100px" class="demo-ruleForm">
        <el-form-item label="id" prop="id">
          <el-input v-model="formData.id" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="appid" prop="appid">
          <el-input v-model="formData.appid"></el-input>
        </el-form-item>
        <el-form-item label="confKey" prop="confKey">
          <el-input v-model="formData.confKey"></el-input>
        </el-form-item>
        <el-form-item label="confValue" prop="confValue">
          <el-input v-model="formData.confValue"></el-input>
        </el-form-item>
        <el-form-item label="description" prop="description">
          <el-input v-model="formData.description"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="updateApp('formData')">修改</el-button>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
    <el-button type="primary" @click="closeDialog3">取消</el-button>
  </span>
    </el-dialog>
    <h2>wechat_conf_app</h2>
    <el-table
      :data="tableData"
      style="width: 100%;margin-bottom: 20px;"
      row-key="id"
      border
      :tree-props="{children: 'children', hasChildren: 'hasChildren'}">
      <el-table-column
        prop="id"
        label="id"
        sortable
        width="180">
      </el-table-column>
      <el-table-column
        prop="appid"
        label="appid"
        sortable
        width="180">
      </el-table-column>
      <el-table-column
        prop="confKey"
        label="confKey"
        width="180">
      </el-table-column>
      <el-table-column
        prop="confValue"
        label="confValue">
      </el-table-column>
      <el-table-column
        prop="description"
        label="description">
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
  export default {
    data() {
      return {
        appConfs: [],
        tableData: [],
        formData: {
          id: '',
          appid: '',
          confKey: '',
          confValue: '',
          description: ''
        },
        dialogFormVisible2: false,
        dialogFormVisible: false,
        rules: {
          id: [],
          appid: [
            {required: true, message: '请输入appid', trigger: 'blur'}
          ],
          confKey: [
            {required: true, message: '请输入confKey', trigger: 'change'}
          ],
          confValue: [
            {required: true, message: '请输入confValue', trigger: 'change'}
          ],
          description: [
            {required: true, message: '请输入description', trigger: 'change'}
          ]
        }
      }
    },
    created() {
      this.convert();
    },
    methods: {
      convert() {
        this.$api.admin.appConfs().then((res) => {
            this.appConfs = res.apps;
            this.tableData = this.transformTozTreeFormat(this.appConfs);
        }).catch((res) => {
            this.$message.error('网络请求异常!');
        });
      },
      transformTozTreeFormat: function (sNodes) { //将普通的数组转换为父子结构
        let i, j, k, l;
        let r = [];
        let copy = [];
        for (i = 0, k = sNodes.length; i < k; i++) {
          if (copy.includes(sNodes[i].id)) {
            continue;
          }
          copy.push(sNodes[i].id);
          for (j = i + 1, l = sNodes.length; j < l; j++) {
            if (copy.includes(sNodes[j].id)) {
              continue;
            }
            if (sNodes[i].appid == sNodes[j].appid) {
              copy.push(sNodes[j].id);
              let children = this.nodeChildren(sNodes[i]);
              if (!children) {
                children = this.nodeChildren(sNodes[i], []);
              }
              children.push(sNodes[j]);
            }
          }
          r.push(sNodes[i]);
        }
        return r;
      },
      nodeChildren: function (node, newChildren) {
        if (typeof newChildren !== 'undefined') {
          node.children = newChildren;
        }
        return node.children;
      },
      openDialog2(row) {
        this.formData = {
          id: row.id,
          appid: row.appid,
          confKey: row.confKey,
          confValue: row.confValue,
          description: row.description
        };
        this.dialogFormVisible2 = true;
      },
      closeDialog3() {
        this.formData = {};
        this.dialogFormVisible2 = false;
      },
      updateApp(fromData) {
        this.$refs[fromData].validate((valid) => {
          if (valid) {
            this.$api.admin.updateAppConf(JSON.stringify(this.formData))
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
      openDialog() {
        this.formData = {
          id: '',
          appid: '',
          confKey: '',
          confValue: '',
          description: ''
        };
        this.dialogFormVisible = true;
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      },
      submitForm(fromData) {
        this.$refs[fromData].validate((valid) => {
          if (valid) {
            this.$api.admin.createAppConf(JSON.stringify(this.formData))
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

    },
  }
</script>
