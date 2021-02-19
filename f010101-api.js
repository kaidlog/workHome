const axios = require("axios");

export default {
  /**
   * 查詢單位/使用者代理資料
   * @param {*} payload 查詢條件
   */
  doGetUserInfoList: async function(payload) {
    let result = await axios.post("/f010101/01", payload);
    return result.data.body;
  }
};
