----
---ASC_2102
--asc2102_1

SELECT a.rc_id
       , a.atr16
       , a.rec_amt
      FROM
         rpro_rc_line_g a
       , rpro_rc_schd_g s
      WHERE
            1 = 1
         AND a.rc_id = s.rc_id
         AND s.prd_id = (select id from rpro_period_g)
         AND a.num3 = 415 -- BA
         AND substr(s.indicators, 1, 1) = 'N'