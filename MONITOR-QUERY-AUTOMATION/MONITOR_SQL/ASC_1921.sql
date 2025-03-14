----
---ASC_1921

      SELECT
         ln.atr16
       , ln.doc_line_id
       , ln.id
       , ln.doc_num
       , ln.doc_line_num
       , ln.item_num
      FROM
         rpro_rc_line_g ln
       , rpro_rc_head_g rh
      WHERE
            1 = 1
         AND ln.rc_id = rh.id
         AND substr(rh.indicators, 6, 1) = 'N'
         AND ( ln.cv_amt IS NOT NULL
               OR ln.cv_amt <> 0 )