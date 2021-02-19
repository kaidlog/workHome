package com.esuncard.model.demo.f01.f01010101.req;

import java.io.Serializable;

import javax.validation.constraints.Size;

import com.esuncard.core.bean.model.AbstractBasePaggingReqModelBean;
import com.esuncard.core.constraints.ValidDate;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 使用者資料查詢條件 Request Model Bean
 * @author Winnie Lin by Esunbank
 * @date 2021年01月22日
 * @remark
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class F01010101ReqModelBean extends AbstractBasePaggingReqModelBean implements Serializable {
    private static final long serialVersionUID = 1L;

    /** PK, ORACLE SYS_GUID() */
    @ApiModelProperty(value = "PK, ORACLE SYS_GUID()", allowEmptyValue = false, required = true)
    @Size(max = 32, message = "PK, ORACLE SYS_GUID()長度不得超過32碼")
    private String uuid;
    /** 資料建立時間(YYYY/MM/DD HH24:MI:SS) */
    @ApiModelProperty(value = "資料建立時間(YYYY/MM/DD HH24:MI:SS)", allowEmptyValue = true, required = false)
    @ValidDate(pattern = "YYYY/MM/DD HH24:MI:SS")
    @Size(max = 19, message = "資料建立時間(YYYY/MM/DD HH24:MI:SS)長度不得超過19碼")
    private String creDateTime;
    /** 資料最後異動時間(YYYY/MM/DD HH24:MI:SS) */
    @ApiModelProperty(value = "資料最後異動時間(YYYY/MM/DD HH24:MI:SS)", allowEmptyValue = true, required = false)
    @ValidDate(pattern = "YYYY/MM/DD HH24:MI:SS")
    @Size(max = 19, message = "資料最後異動時間(YYYY/MM/DD HH24:MI:SS)長度不得超過19碼")
    private String updDateTime;
    /** 身份證字號 */
    @ApiModelProperty(value = "身份證字號", allowEmptyValue = true, required = false)
    @Size(max = 10, message = "身份證字號長度不得超過10碼")
    private String id;
    /** 姓名 */
    @ApiModelProperty(value = "姓名", allowEmptyValue = true, required = false)
    @Size(max = 90, message = "姓名長度不得超過90碼")
    @ValidDate(pattern = "姓名")
    private String name;
    /** 姓名 */
    @ApiModelProperty(value = "地址", allowEmptyValue = true, required = false)
    @Size(max = 150, message = "地址長度不得超過150碼")
    @ValidDate(pattern = "地址")
    private String addr;
}