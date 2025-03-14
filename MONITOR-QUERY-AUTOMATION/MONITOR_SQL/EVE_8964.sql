------------
--EVE_8964

SELECT (SELECT atr16
              FROM   rpro_rc_line_g rrl
              WHERE  rrl.rc_id = id
              limit 1) source_system
            ,a.* FROM
            (
            SELECT id
                , COUNT(id) cnt
            FROM rpro_rc_head_g
            GROUP BY id
            HAVING COUNT(id) > 1) a