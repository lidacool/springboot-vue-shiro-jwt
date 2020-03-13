<template>
    <div class="insuranceDataImport" style="margin-top: 50px">

        <el-form ref="addForm" class="eldialogForm" id="addForm">
            <el-form-item label>
                <el-upload
                        class="upload-demo"
                        drag
                        :file-list="fileLists"
                        :on-exceed="handleExceed"
                        :limit="100"
                        :on-change="beforeUpload"
                        :on-remove="handleRemove"
                        list-type="text"
                        multiple
                        ref="upload"
                        action
                        :auto-upload="false">
                    <i class="el-icon-upload"></i>
                    <div class="el-upload__text">
                        将文件拖到此处，或
                        <em>点击上传</em>
                    </div>
                    <div class="el-upload__tip" slot="tip">只能上传Excel文件，且不超过500kb</div>
                </el-upload>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="postFile()" :disabled="uploading">确 定</el-button>
        </div>

    </div>
</template>

<script>

    export default {
        data() {
            return {
                files: [],
            }
        },
        methods: {
            beforeUpload(file,fileList) {
                this.files = fileList;
                if (file.type == "" || file.type == null || file.type == undefined) {
                    const FileExt = file.name.replace(/.+\./, "").toLowerCase();
                    if (
                        FileExt == "xls" ||
                        FileExt == "xlsx" ||
                        FileExt == "XLS" ||
                        FileExt == "XLSX"
                    ) {
                        return true;
                    } else {
                        this.$message.error("上传文件必须是Excel格式!请删除后继续上传!");
                        return false;
                    }
                } else {
                    const isText = file.type === "application/vnd.ms-excel";
                    const isTextComputer =
                        file.type ===
                        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    if (!isText && !isTextComputer) {
                        this.$message.error("上传文件必须是Excel格式!请删除后继续上传!");
                    }
                    return isText || isTextComputer;
                }
            },
            handleRemove(file, fileList) {
                this.files = fileList;
            },
            // 上传文件个数超过定义的数量
            handleExceed(files, fileList) {
                this.$message.warning(`当前限制选择 100 个文件，请删除后继续上传`);
            },
            postFile() {
                let fileData = new FormData();
                if (this.files.length > 0) {
                    this.files.forEach(function (file) {
                        fileData.append('files', file.raw);
                    });
                    this.$api.admin.syncExcelToMysql(fileData)
                      .then(res => {
                        this.files = [];
                        this.$refs['upload'].clearFiles();
                            this.$message.success("上传成功！");
                    }).catch(err => {
                        this.$message.error(err.response.data.message);
                        });
                    setTimeout(function () {
                        this.uploading = false;
                    }, 1500);
                } else {
                    this.$message.warning("当前没有合适excel可以上传");
                }
            },
        }
    }
</script>
