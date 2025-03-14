-------
--ASC1784

SELECT 
         a.rc_id
       , a.atr16 source_system
       , COUNT(DISTINCT a.curr) curr_count
      FROM
         rpro_rc_line_g a
      WHERE
            1 = 1
         AND EXISTS (  SELECT   1
            FROM rpro_rc_schd_g s
            WHERE  1 = 1
               AND a.rc_id = s.rc_id
               AND s.post_prd_id = (select id from rpro_period_g) --current period
               AND substr(s.indicators, 2, 2) IN ( 'NW', 'WX' )  )
      GROUP BY
         a.rc_id
       , a.atr16
      HAVING COUNT(DISTINCT a.curr) <> 1