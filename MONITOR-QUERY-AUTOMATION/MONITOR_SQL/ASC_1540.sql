-----
---ASC_1540

      SELECT
         ab.rc_id
       , line_bill_def_amt
       , line_bill_rec_amt
       , bill_def_amt
       , bill_rec_amt
      FROM
         (
            SELECT
               ln.rc_id
             , SUM(ln.bld_def_amt) line_bill_def_amt
             , SUM(ln.bld_rec_amt) line_bill_rec_amt
            FROM
               rpro_rc_line_g ln
            WHERE
               1 = 1
            GROUP BY
               ln.rc_id
         ) ab
       , (
            SELECT
               bl.rc_id
             , SUM(bl.def_amt) bill_def_amt
             , SUM(bl.rec_amt) bill_rec_amt
            FROM
               rpro_rc_bill_g bl
            WHERE
               1 = 1
            GROUP BY
               bl.rc_id
         ) ab1
      WHERE
            ab.rc_id = ab1.rc_id
         AND ( line_bill_def_amt <> bill_def_amt
               OR line_bill_rec_amt <> bill_rec_amt )