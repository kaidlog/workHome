package com.esuncard.demo.service.f01.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.esuncard.core.utils.SimpleJdbcCallUtils;
import com.esuncard.demo.service.AbstractBaseApService;
import com.esuncard.demo.service.f01.F010101Service;
import com.esuncard.model.demo.f01.f01010101.req.EmployeeReqModelBean;
import com.esuncard.model.demo.f01.f01010101.req.F01010101ReqModelBean;
import com.esuncard.model.demo.f01.f01010101.res.EmployeeResModelBean;
import com.esuncard.model.demo.f01.f01010101.res.F01010101ResModelBean;
import com.esuncard.model.demo.f01.f01010101.res.UserInfoResModelBean;

/**
 * 使用者資料 Service
 * @author Winnie Lin by Esunbank
 * @date 2021年01月22日
 * @remark
 */
@Service
@Transactional
public class F010101ServiceImpl extends AbstractBaseApService implements F010101Service {
    /** logger */
    private static Log logger = LogFactory.getLog(F010101ServiceImpl.class);

    @Override
    @Transactional(readOnly = true)
    public F01010101ResModelBean doGetUserInfoList(F01010101ReqModelBean reqModelBean) {
        if (logger.isDebugEnabled()) {
            JSONObject logParams = new JSONObject();
            logParams.put("reqModelBean", reqModelBean);

            logger.debug(logParams);
        }

        // 1. 組合執行參數 -----------------------------------------------------------------------------------------------
        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("I_UUID", reqModelBean.getUuid())
                .addValue("I_CRE_DATE_TIME", reqModelBean.getCreDateTime())
                .addValue("I_UPD_DATE_TIME", reqModelBean.getUpdDateTime())
                .addValue("I_ID", reqModelBean.getId())
                .addValue("I_NAME", reqModelBean.getName())
                .addValue("I_ADDR", reqModelBean.getAddr())
                .addValue("I_PAGE_NO", reqModelBean.getPageNo())
                .addValue("I_PAGE_SIZE", reqModelBean.getPageSize())
                .addValue("I_SORT_COLUMN", StringUtils.defaultIfBlank(reqModelBean.getSortColumn(), "UUID"))
                .addValue("I_SORT_TYPE", StringUtils.defaultIfBlank(reqModelBean.getSortType(), "ASC"));

        // 2. 呼叫DB Procedure並回傳處理結果 -------------------------------------------------------------------------------
        Map<String, Object> result = getGeneralSimpleJdbcCallDAO().doCallProcedure(
                "PG_F010101",
                "SP_FOR_DEMO", // 依據條件查詢代理資料內容
                parameterSource);

        // 3. 處理回傳ModelBean ----------------------------------------------------------------------------------------
        F01010101ResModelBean resModelBean = new F01010101ResModelBean();
        resModelBean.setUserList(SimpleJdbcCallUtils.convertMapList2BeanList((List<?>) result.get("O_DATA"), UserInfoResModelBean.class));
        resModelBean.setTotalCount((BigDecimal) result.get("O_TOTAL"));
        resModelBean.setPageNo((BigDecimal) result.get("O_PAGE_NO"));

        return resModelBean;
    }
}