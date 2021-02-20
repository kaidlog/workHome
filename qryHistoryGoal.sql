create or replace PACKAGE PG_MT_HISTORY_GOAL AS 
   /** 查詢目標的資料 */
    -- 表單資料
    TYPE TO_FORM_DATA IS RECORD(
	    GOAL_ID  TB_GOAL_MT_DIRECTORY.GOAL_ID%TYPE,
        UUID  TB_GOAL_MT_DIRECTORY.UUID%TYPE,
	    SET_PERIOD  VARCHAR2(6),
	    IDEAL_PACE_PER_KM  TB_GOAL_MT_DIRECTORY.IDEAL_PACE_PER_KM%TYPE,
	    IDEAL_DISTANCE  TB_GOAL_MT_DIRECTORY.IDEAL_DISTANCE%TYPE,
	    CRE_DATE_TIME  VARCHAR2(10),
	    UPD_DATE_TIME  VARCHAR2(10),
	    CREATOR  TB_GOAL_MT_DIRECTORY.CREATOR%TYPE,
	    UPDATER  TB_GOAL_MT_DIRECTORY.UPDATER%TYPE,
	    IS_VALID  VARCHAR2(36),
        DIFFICULTY VARCHAR2(6)
    );
    -- 表單資料清單
    TYPE TT_FORM_DATA_LIST IS TABLE OF TO_FORM_DATA;
    -- 查詢條件 ----------------------------------------------------------------------------------------------------
    PROCEDURE SP_QUERY_FORM_DATA_LIST(
        -- (0,1,2) 查詢目標的條件 ----------------------------------------------------------------------------------
        I_IS_VALID VARCHAR2,      
        -- 使用者的 id ----------------------------------------------------------------------------------------
        I_UUID VARCHAR2  ,                                                                                          
        -- 分頁排序條件 ------------------------------------------------------------------------------------------------
        I_PAGE_NO IN NUMBER,                                                                                        
        I_PAGE_SIZE IN NUMBER,                                                                                   
        I_SORT_COLUMN IN VARCHAR2,                                                                              
        I_SORT_TYPE IN VARCHAR2,                                                                              
        -- 輸出結果 ----------------------------------------------------------------------------------------------------
        O_TOTAL_COUNT OUT NUMBER,                                                                              
        O_DATA OUT SYS_REFCURSOR,                                                                              
        O_PAGE_NO OUT NUMBER                                                                                
    );

END PG_MT_HISTORY_GOAL;