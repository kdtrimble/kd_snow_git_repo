----
--ASC_1681

      SELECT
        atr16
      , a.doc_line_id
      , a.doc_num
      , a.doc_line_num
      , a.item_num
      , a.id
     FROM
        rpro_rc_line_g a
     WHERE
        atr17 LIKE '%Rental%'
        AND crtd_prd_id = (select id from rpro_period_g) --current period
        AND ( cv_amt IS NOT NULL
              OR cum_cv_amt IS NOT NULL )
