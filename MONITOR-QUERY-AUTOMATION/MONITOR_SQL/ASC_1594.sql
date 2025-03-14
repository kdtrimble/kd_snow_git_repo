---
---ASC_1594

 SELECT a.RC_ID,
              a.atr16,
             a.ATR60,
           a.DOC_LINE_ID,
           a.DOC_DATE,
           a.CRTD_PRD_ID,
           a.EXT_SLL_PRC,
           a.OVERSTATED_AMT Line_OVERSTATED_AMT,
           a.BLD_DEF_AMT+a.BLD_REC_AMT BILLED_AMT,
           a.DEF_AMT,
           a.REC_AMT,
           a.CV_AMT,
           a.CUM_CV_AMT,
           a.ORD_QTY,
           a.INV_QTY LINE_INV_QTY,
           sum(bl.INV_QTY) BILL_INV_QTY,
            a.UPDT_DT,
            A.ATR19,
            A.NUM3 BA 
            FROM RPRO_RC_LINE_G A , RPRO_RC_BILL_G BL
         WHERE 1=1
           AND a.id           = BL.line_id
           AND bl.crtd_prd_id = (select id from rpro_period_g)                -- Invoice created period ID
             AND bl.type        = 'INV'
           AND ABS (NVL (OVERSTATED_AMT, 0)) > 1
           AND NOT EXISTS
           (SELECT 1
           FROM RPRO_LN_HOLD_G HG
           WHERE A.RC_ID                 = HG.RC_ID
           AND A.ID                      = HG.LINE_ID
           AND HG.REV_HOLD_ID            = 10005         -- Perpetual Hold
           AND SUBSTR (INDICATORS, 1, 1) = 'N'
           )
         AND SUBSTR (a.INDICATORS, 1, 1) = 'Y'           -- CV Elegible Flag\
         AND not exists
         (
            select 1 from RPRO_RC_BILL_G b2
            where a.rc_id = b2.rc_id
            and a.atr60 = b2.atr60
            and b2.doc_line_id like '%CREDIT%'
            and b2.ext_sll_prc <0
         )
         AND a.doc_date                 >= '01-JUL-20'
         group by a.RC_ID, a.atr60,
           a.atr16,
           a.DOC_LINE_ID,
           a.DOC_DATE,
           a.CRTD_PRD_ID,
           a.EXT_SLL_PRC,
           a.OVERSTATED_AMT,
           a.DEF_AMT,
           a.REC_AMT,
           a.CV_AMT,
           a.CUM_CV_AMT,
           a.ORD_QTY,
           a.INV_QTY ,
           a.UPDT_DT,
           A.ATR19,
           A.NUM3,
           a.BLD_DEF_AMT+a.BLD_REC_AMT