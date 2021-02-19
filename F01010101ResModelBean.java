package com.esuncard.model.demo.f01.f01010101.res;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.esuncard.core.bean.model.AbstractBasePaggingResModelBean;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 使用者資料清單 Response Model Bean
 * @author Winnie Lin by Esunbank
 * @date 2021年01月22日
 * @remark
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class F01010101ResModelBean extends AbstractBasePaggingResModelBean implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 代理資料清單 */
    @ApiModelProperty(value = "代理資料清單", allowEmptyValue = true, required = false)
    private List<UserInfoResModelBean> userList = new ArrayList<UserInfoResModelBean>();
    
    @ApiModelProperty(value = "員工清單", allowEmptyValue = true, required = false)
    private List<EmployeeResModelBean> employeeList = new ArrayList<EmployeeResModelBean>();
}