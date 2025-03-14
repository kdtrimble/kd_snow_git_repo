------
---ASC_1713

      SELECT
         a.*
      FROM
         ( SELECT a.rc_id
             , a.atr16 source_system
             , doc_line_id
             , doc_date
             , item_num
             , doc_num
             , atr25
             , atr19
             , ext_sll_prc
			 , alctbl_xt_prc
             , rel_pct
             , def_amt
             , rec_amt
             , bld_def_amt
             , bld_rec_amt
             , overstated_amt
             , rc_pob_id
             , cv_amt
             , ( SELECT  SUM(amount)
                  FROM
                     rpro_rc_schd_g
                  WHERE
                        1 = 1
                     AND root_line_id = a.id
                     AND substr(indicators, 2, 2) IN ( 'LR', 'UR' )
               ) rev_amt
            FROM
               rpro_rc_line_g  a
             , rpro_rc_pob_g   b
             , rpro_pob_tmpl_g c
            WHERE
                  1 = 1
               AND a.rc_pob_id = b.id
               AND b.pob_id = c.id
               AND substr(c.indicators, 20, 1) = 'A'
               AND a.batch_id >= 16254
               AND type = 'SO'
               AND nvl(overstated_amt, 0) <> 0
         ) a
      WHERE rev_amt <> alctbl_xt_prc