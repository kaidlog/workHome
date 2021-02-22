create or replace PACKAGE BODY PG_MT_HISTORY_GOAL AS
 /** 查詢已經放棄的 procedure */
  PROCEDURE SP_QUERY_FORM_DATA_LIST(
    I_IDEAL_DISTANCE_BEG VARCHAR2,
    I_IDEAL_DISTANCE_END VARCHAR2,
    I_START_DATE VARCHAR2,
    I_END_DATE VARCHAR2,
    I_IDEAL_PACE_PER_KM_BEG NUMBER,
    I_IDEAL_PACE_PER_KM_END NUMBER,
    I_SET_PERIOD VARCHAR2,
    I_DIFFICULTY NUMBER,
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
                                                    END) DIFFICULTY 
        BULK COLLECT INTO FORM_DATA_LIST 
		FROM                                                                               
			TB_GOAL_MT_DIRECTORY A
		WHERE
            (
				I_DIFFICULTY IS NULL																						-- PK, ORACLE SYS_GUID()
				OR A.DIFFICULTY LIKE '%' || I_DIFFICULTY || '%'                                                             					-- PK, ORACLE SYS_GUID()
            )
        AND
        (
            I_IS_VALID IS NULL
            OR I_IS_VALID = A.IS_VALID 
        )
        AND
        (
            I_SET_PERIOD IS NULL
            OR I_SET_PERIOD = A.SET_PERIOD 
        )
        AND
        (
            I_IDEAL_PACE_PER_KM_BEG IS NULL
            OR I_IDEAL_PACE_PER_KM_BEG <= A.IDEAL_PACE_PER_KM 
        )
        AND
        (
            I_IDEAL_PACE_PER_KM_END IS NULL
            OR I_IDEAL_PACE_PER_KM_END >= A.IDEAL_PACE_PER_KM 
        )
        AND
        (
            I_IDEAL_DISTANCE_BEG IS NULL
            OR 
            I_IDEAL_DISTANCE_BEG <= A.IDEAL_DISTANCE          
        )
        AND
        (
            I_IDEAL_DISTANCE_END IS NULL
            OR
            I_IDEAL_DISTANCE_END >= A.IDEAL_DISTANCE 
                
        )
        AND
            A.UUID = I_UUID 
        ORDER BY
            (CASE WHEN I_SORT_COLUMN = 'GOAL_ID' AND I_SORT_TYPE = 'ASC' THEN A.GOAL_ID END) ASC,
            (CASE WHEN I_SORT_COLUMN = 'GOAL_ID' AND I_SORT_TYPE = 'DESC' THEN A.GOAL_ID END) DESC,
            (CASE WHEN I_SORT_COLUMN = 'UUID' AND I_SORT_TYPE = 'ASC' THEN A.UUID END) ASC,
            (CASE WHEN I_SORT_COLUMN = 'UUID' AND I_SORT_TYPE = 'DESC' THEN A.UUID END) DESC,
            (CASE WHEN I_SORT_COLUMN = 'SET_PERIOD' AND I_SORT_TYPE = 'ASC' THEN A.SET_PERIOD END) ASC, 
            (CASE WHEN I_SORT_COLUMN = 'SET_PERIOD' AND I_SORT_TYPE = 'DESC' THEN A.SET_PERIOD END) DESC,
            (CASE WHEN I_SORT_COLUMN = 'IDEAL_PACE_PER_KM' AND I_SORT_TYPE = 'ASC' THEN A.IDEAL_PACE_PER_KM END) ASC,
            (CASE WHEN I_SORT_COLUMN = 'IDEAL_PACE_PER_KM' AND I_SORT_TYPE = 'DESC' THEN A.IDEAL_PACE_PER_KM END) DESC,
            (CASE WHEN I_SORT_COLUMN = 'IDEAL_DISTANCE' AND I_SORT_TYPE = 'ASC' THEN A.IDEAL_DISTANCE END) ASC, 
            (CASE WHEN I_SORT_COLUMN = 'IDEAL_DISTANCE' AND I_SORT_TYPE = 'DESC' THEN A.IDEAL_DISTANCE END) DESC, -- PK, ORACLE SYS_GUID()
            (CASE WHEN I_SORT_COLUMN = 'CRE_DATE_TIME' AND I_SORT_TYPE = 'ASC' THEN A.CRE_DATE_TIME END) ASC,
            (CASE WHEN I_SORT_COLUMN = 'CRE_DATE_TIME' AND I_SORT_TYPE = 'DESC' THEN A.CRE_DATE_TIME END) DESC,
            (CASE WHEN I_SORT_COLUMN = 'UPD_DATE_TIME' AND I_SORT_TYPE = 'ASC' THEN A.UPD_DATE_TIME END) ASC,
            (CASE WHEN I_SORT_COLUMN = 'UPD_DATE_TIME' AND I_SORT_TYPE = 'DESC' THEN A.UPD_DATE_TIME END) DESC,-- PK, ORACLE SYS_GUID()
            (CASE WHEN I_SORT_COLUMN = 'CREATOR' AND I_SORT_TYPE = 'ASC' THEN A.CREATOR END) ASC,
            (CASE WHEN I_SORT_COLUMN = 'CREATOR' AND I_SORT_TYPE = 'DESC' THEN A.CREATOR END) DESC,
            (CASE WHEN I_SORT_COLUMN = 'UPDATER' AND I_SORT_TYPE = 'ASC' THEN A.UPDATER END) ASC, 
            (CASE WHEN I_SORT_COLUMN = 'UPDATER' AND I_SORT_TYPE = 'DESC' THEN A.UPDATER END) DESC,-- PK, ORACLE SYS_GUID()
            (CASE WHEN I_SORT_COLUMN = 'IS_VALID' AND I_SORT_TYPE = 'ASC' THEN A.IS_VALID END) ASC,
            (CASE WHEN I_SORT_COLUMN = 'IS_VALID' AND I_SORT_TYPE = 'DESC' THEN A.IS_VALID END) DESC,
            (CASE WHEN I_SORT_COLUMN = 'DIFFICULTY' AND I_SORT_TYPE = 'ASC' THEN A.DIFFICULTY END) ASC, 
            (CASE WHEN I_SORT_COLUMN = 'DIFFICULTY' AND I_SORT_TYPE = 'DESC' THEN A.DIFFICULTY END) DESC             			-- PK, ORACLE SYS_GUID()
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