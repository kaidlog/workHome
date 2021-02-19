<template>
  <div>
    <Table
      border
      :columns="userColumns"
      :data="userList"
      @on-sort-change="handleSortChange"
    >
    </Table>
  </div>
</template>

<script>
import f010101Api from "@api/f01/f010101-api";
import namingConverter from "@misc/naming-converter";

export default {
  components: {},
  props: {},
  data() {
    return {
      // 表單驗證項目
      formValidate: {
        uuid: "",
        creDateTime: "",
        updDateTime: "",
        id: "",
        name: "",
        addr: ""
      },
      // 資料筆數
      total: 0,
      // table目前頁面
      pageNo: 1,
      // table顯示筆數
      pageSize: 10,
      // 排序欄位
      sortColumn: null,
      // 排序方向
      sortType: null,
      // userList
      userList: [],
      userColumns: [
        {
          title: "uuid",
          key: "uuid",
          sortable: "custom"
        },
        {
          title: "資料建立時間",
          key: "creDateTime"
        },
        {
          title: "資料最後異動時間",
          key: "updDateTime",
          width: 250
        },
        {
          title: "身份證字號",
          key: "id",
          sortable: "custom"
        },
        {
          title: "姓名",
          key: "name",
          sortable: "custom"
        },
        {
          title: "地址",
          key: "addr",
          width: 250
        }
      ]
    };
  },
  computed: {},
  methods: {
    /**
     * 查詢使用者資料
     **/
    doGetUserInfoList: async function() {
      let result = await f010101Api.doGetUserInfoList({
        uuid: this.formValidate.uuid,
        creDateTime: this.formValidate.creDateTime,
        updDateTime: this.formValidate.updDateTime,
        id: this.formValidate.id,
        name: this.formValidate.name,
        addr: this.formValidate.addr,
        pageNo: this.pageNo,
        pageSize: this.pageSize,
        sortColumn: this.sortColumn,
        sortType: this.sortType
      });

      this.userList = result.userList;
      this.total = result.totalCount;
      this.pageNo = result.pageNo;
    },
    /**
     * 處理使用清單排序
     */
    handleSortChange: async function(col) {
      if (!this.total) {
        return;
      }

      // normal: 取消排序
      if (col.order === "normal") {
        this.pageNo = 1;
        this.sortColumn = null;
        this.sortType = null;
      }
      // normal: 取消排序
      if (col.order !== "normal") {
        this.pageNo = 1;
        this.sortColumn = namingConverter.camelCase2UnderscoreUppercase(
          col.key
        );
        this.sortType = col.order.toUpperCase();
      }
      // 依據條件使用資訊
      await this.doGetUserInfoList();
    }
  },
  watch: {},
  beforeCreate() {},
  created() {
    this.doGetUserInfoList();
  },
  beforeMount() {},
  mounted() {},
  activated() {},
  deactivated() {},
  beforeUpdate() {},
  updated() {},
  beforeDestroy() {},
  destroyed() {}
};
</script>

<style lang="scss" scoped></style>
