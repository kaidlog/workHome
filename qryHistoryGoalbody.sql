create or replace PACKAGE BODY PG_MT_HISTORY_GOAL AS
 /** 查詢已經放棄的 procedure */
  PROCEDURE SP_QUERY_FORM_DATA_LIST(
    I_IS_VALID VARCHAR2,                                                                                       
    I_UUID VARCHAR2,                                                                                          
    -- 分頁排序條件 ------------------------------------------------------------------------------------------------
    I_PAGE_NO IN NUMBER,                                                                                   
    I_PAGE_SIZE IN NUMBER,                                                                                      
    I_SORT_COLUMN IN VARCHAR2,                                                                               
    I_SORT_TYPE IN VARCHAR2,                                                                                 
    -- 輸出結果 ----------------------------------------------------------------------------------------------------
    O_TOTAL_COUNT OUT NUMBER,                                                                              
    O_DATA OUT SYS_REFCURSOR,                                                                              
    O_PAGE_NO OUT NUMBER                                                                                       
    )
  AS
    FORM_DATA_LIST TT_FORM_DATA_LIST; 
  BEGIN
    -- TODO: 必須實行 PROCEDURE PG_MT_HISTORY_GOAL.SP_QUERY_FORM_DATA_LIST
    SELECT
            A.GOAL_ID, 
            A.UUID,
            (CASE A.SET_PERIOD WHEN '0' THEN '6'
                                                    WHEN '1' THEN '12'
                                                    WHEN '2' THEN '18'
                                                    END) SET_PERIOD ,
            A.IDEAL_PACE_PER_KM, 
            A.IDEAL_DISTANCE, 
--            A.CRE_DATE_TIME,
--            A.UPD_DATE_TIME,
            TO_CHAR(A.CRE_DATE_TIME, 'yyyy-MM-dd') CRE_DATE_TIME,
--            TOCAHR(A.UPD_DATE_TIME ),
            TO_CHAR(A.UPD_DATE_TIME,'yyyy-MM-dd') UPD_DATE_TIME,
            A.CREATOR,
            A.UPDATER,
--            A.IS_VALID
            (CASE A.IS_VALID WHEN '0' THEN '已經放棄'
                                                    WHEN '1' THEN '正在執行'
                                                    WHEN '2' THEN '有效完成'
                                                    END) IS_VALID ,
            (CASE A.DIFFICULTY WHEN '0' THEN '嚴格'
                                                    WHEN '1' THEN '中等'
                                                    WHEN '2' THEN '簡單'
                                                    END) IS_VALID 
        BULK COLLECT INTO FORM_DATA_LIST 
		FROM                                                                               
			TB_GOAL_MT_DIRECTORY A
		WHERE
            I_IS_VALID = A.IS_VALID 
        AND 
            A.UUID = I_UUID 
        ;

        -- 3. 取得資料總筆數 -------------------------------------------------------------------------------------------
        O_TOTAL_COUNT := FORM_DATA_LIST.COUNT;                                                                    

        -- 4. 取得實際頁次 ---------------------------------------------------------------------------------------------
        O_PAGE_NO := GREATEST(LEAST(CEIL(O_TOTAL_COUNT / I_PAGE_SIZE), I_PAGE_NO), 1);                             

        -- 5. 取得分頁後的資料 -----------------------------------------------------------------------------------------
        OPEN O_DATA FOR                                                                                          
        SELECT
            F.*
        FROM 
            TABLE(FORM_DATA_LIST) F  
        OFFSET (O_PAGE_NO - 1) * I_PAGE_SIZE ROWS   
        FETCH NEXT I_PAGE_SIZE ROWS ONLY    
        ;                                                                           
  END SP_QUERY_FORM_DATA_LIST;

END PG_MT_HISTORY_GOAL;