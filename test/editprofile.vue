<template>
  <div id="editprofile">
    <Card>
      <Span style="font-weight: bold"><p>PROFILE</p></Span>
    </Card>
    <Card>
      <div class="demo-avatar" style="text-align: center">
        <!-- src放圖片 -->
        <Avatar icon="ios-person" size="200" />
        <Span style="font-weight: bold">
          <p><br /></p>
          <p>Test User</p>
        </Span>
        <Span style="font-size: 10px; color: blue">
          <p><br /></p>
          <p>Taiwan</p></Span
        >
        <Span>
          <p><br /></p>
          <p><code>Marathon Train</code> user since 2021/02/16</p></Span
        >
        <p><br /></p>
        <Button style="secondary"> view full profile </Button>
      </div>
    </Card>
    <Card>
      <Span>
        <p @click="doEditProfile">
          <Icon type="md-person" /><Span style="margin: 0px 30px 0px 30px"
            >Edit Profile</Span
          >
        </p></Span
      >
    </Card>
    <Card
      ><Span
        ><p @click="goNotification">
          <Icon type="ios-notifications" /><Span
            style="margin: 0px 30px 0px 30px"
            >Notification</Span
          >
        </p></Span
      ></Card
    >
    <Card
      ><Span
        ><p @click="doEditProfile">
          <Icon type="ios-planet" /><Span style="margin: 0px 30px 0px 30px"
            >Language</Span
          >
        </p></Span
      ></Card
    >
    <Card
      ><Span
        ><p @click="doEditProfile">
          <Icon type="ios-settings" /><Span style="margin: 0px 30px 0px 30px"
            >Password</Span
          >
        </p></Span
      ></Card
    >
    <Card
      ><Span>
        <p @click="doEditProfile">
          <Icon type="ios-trash" /><Span style="margin: 0px 30px 0px 30px"
            >刪除此帳號</Span
          >
        </p></Span
      ></Card
    >
  </div>
</template>
<script>
export default {
  name: "editprofile",
  data() {
    return {
      value1: "1",
    };
  },
  methods: {
    doEditProfile() {
      this.$swal("info", "info", "info");
    },
    goNotification() {
      this.$router.push("notification");
    },
  },
};
</script>
