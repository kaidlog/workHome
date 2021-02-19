package com.esuncard.demo.ctrl.f01;

import javax.validation.Valid;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.esuncard.core.bean.RestApiOneResponse;
import com.esuncard.demo.ctrl.AbstractBaseApController;
import com.esuncard.demo.service.f01.F010101Service;
import com.esuncard.model.demo.f01.f01010101.req.F01010101ReqModelBean;
import com.esuncard.model.demo.f01.f01010101.res.F01010101ResModelBean;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 代理資料 Controller
 * @author for demo by Esunbank
 * @date 2020年6月17日
 * @remark
 */
@RestController
@RequestMapping("/f010101")
@Api(tags = "(DEMO)使用者資料 Controller")
public class F010101Controller extends AbstractBaseApController {
    /** logger */
    private static Log logger = LogFactory.getLog(F010101Controller.class);

    /** 使用者資料 Service */
    @Autowired
    private F010101Service f010101Service;

    /**
     * 查詢使用者資料
     * @param reqModelBean 查詢條件
     * @return RestApiListResponse<F01010101ResModelBean> 查詢結果
     * @remark
     */
    @PostMapping("/01")
    @ApiOperation(value = "查詢單位/使用者代理資料")
    public RestApiOneResponse<F01010101ResModelBean> doGetUserInfoList(@Valid @RequestBody F01010101ReqModelBean reqModelBean) {
        if (logger.isDebugEnabled()) {
            logger.debug(new JSONObject());
        }

        return doGetDefaultOneResult(f010101Service.doGetUserInfoList(reqModelBean));
    }
}