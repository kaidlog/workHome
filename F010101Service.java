package com.esuncard.demo.service.f01;

import com.esuncard.model.demo.f01.f01010101.req.F01010101ReqModelBean;
import com.esuncard.model.demo.f01.f01010101.res.F01010101ResModelBean;

/**
 * 使用者資料 Service
 * @author Winnie Lin by Esunbank
 * @date 2021年01月22日
 * @remark
 */
public interface F010101Service {
    /**
     * 查詢使用者資料
     * @param reqModelBean 查詢條件
     * @return F01010101ResModelBean 使用者資料清單
     * @remark
     */
    F01010101ResModelBean doGetUserInfoList(F01010101ReqModelBean reqModelBean);
}