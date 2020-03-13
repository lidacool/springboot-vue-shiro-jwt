<template>
  <div>
    <div style="margin-top: 50px;height: 250px">
      <h3 class="title modal-headline">添加图片</h3>
      <div slot="tip" class="el-upload__tip">只能上传jpg/png/jpeg/gif/svg/bmp格式图片，且图片大小不超过2MB，同名图片会默认覆盖</div>
      <el-upload
        class="upload-demo"
        accept=".png,.jpg,.jpeg,.gif,.svg,.bmp"
        ref="upload"
        :file-list="fileLists"
        :multiple="true"
        action="#"
        :on-change="handlePreview"
        :on-remove="handleRemove"
        list-type="text"
        :limit="100"
        :on-exceed="fileExceed"
        :auto-upload="false">
        <el-button slot="trigger" size="small" type="primary">选取文件</el-button>
        <el-button style="margin-left: 10px;" size="small" type="success" @click="submitUpload">上传到服务器
        </el-button>
      </el-upload>
    </div>


    <div>
      <h2>已上传的图片：共{{imgInfos.length}}张</h2>
      <h4>excel对应图片url地址：{{imgUrl}}+图片名</h4>
      <el-table
        :data="imgInfos"
        border
        style="width: 50%;margin: auto">
        <el-table-column
          prop="index"
          label="index"
          width="110">
          <template slot-scope="scope">
            {{scope.$index}}
          </template>
        </el-table-column>
        <el-table-column
          prop="data"
          label="图片名">
          <template slot-scope="scope">
            {{scope.row}}
          </template>
        </el-table-column>

        <el-table-column
          label="操作"
          width="110">
          <template slot-scope="scope">
            <el-button type="info" @click="del(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>

  export default {
    data() {
      return {
        fileLists: [],
        imgInfos: [],
        imgUrl: ''
      };
    },
    created() {
      this.convert();
    },
    methods: {
      convert() {
        this.$api.admin.getImg()
          .then(res => {
            this.imgInfos = res.imgList;
            this.imgUrl = res.imgUrl;
          }).catch(err => {
          this.$message.error('网络请求异常!');
        });
      },
      submitUpload() {
        let that = this;
        let params = new FormData();
        // 注意此处对文件数组进行了参数循环添加
        if (that.fileLists.length > 0) {
          that.fileLists.forEach(function (file) {
            params.append('questionImages', file.raw);
          });
          that.$api.admin.uploadImg(params)
            .then(res => {
              this.imgInfos = res.imgList;
              // 清空上传文件：
              that.fileLists = [];
              this.$refs['upload'].clearFiles();
              that.$message.success('上传成功!');
            })
            .catch(err => {
              that.$message.error(err.response.data.message);
            });
        } else {
          that.$message.warning("当前没有合适图片可以上传");
        }

      },

      handleRemove(file, fileList) {
        this.fileLists = fileList;
      },

      handlePreview(file, fileList) {
        let that = this;
        if (file.raw.type != 'image/jpg' && file.raw.type != 'image/png'
          && file.raw.type != 'image/gif' && file.raw.type != 'image/svg'
          && file.raw.type != 'image/bmp' && file.raw.type != 'image/jpeg') {
          that.$message.error('图片只能是jpg/png格式!');
          return;
        }
        if (file.raw.size > 1024 * 1024 * 2) {
          that.$message.error('上传文件大小不能超过 2MB!');
          return;
        }
        that.fileLists = fileList;
      },

      fileExceed: function (files, fileList) {
        this.$message.warning(`当前限制选择 100 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      },
      del(fileName) {
        let that = this;
        let params = new FormData();
        params.append('fileName', fileName);
        that.$api.admin.deleteImg(params)
          .then(res => {
            this.imgInfos = res.imgList;
            that.$message.success('修改成功!');
          })
          .catch(err => {
            that.$message.error(err.response.data.message);
          });
      },
    }
  }
</script>
