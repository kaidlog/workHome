<template>
  <div id="notification">
    <Table :columns="columns1" :data="data1" align="left"></Table>
  </div>
</template>
<script>
export default {
  name: "notification",
  data() {
    return {
      columns1: [
        {
          title: "Date",
          width: "200",
          key: "date",
        },
        {
          title: "Message",
          key: "message",
        },
      ],
      data1: [
        {
          Date: "John Brown",
          age: 18,
          address: "New York No. 1 Lake Park",
          date: "2016-10-03",
        },
      ],
    };
  },
  methods: {
    time() {
      this.$Notice.open({
        title: "Notification title",
        desc:
          "This notification does not automatically close, and you need to click the close button to close.",
        duration: 0,
      });
    },
  },
  activated() {
    this.time();
  },
};
</script>
