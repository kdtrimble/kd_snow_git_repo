----
--ASC_1728

WITH RC_LINE(RC_ID,ATR16)
as
(SELECT rc_id,atr16
              FROM   rpro_rc_line_g rrl)
SELECT DISTINCT a.rc_id
          , rl.atr16 source_system
          , b.name
          , DECODE(SUBSTR(b.indicators, 5, 1), 'L', 'Line', 'P', 'POB'
                   , 'R', 'Rc') hold_level
      FROM rpro_ln_hold_g  a
         , rpro_rev_hold_g b
		 , RC_LINE rl
      WHERE rl.rc_id = a.rc_id
	  AND a.rc_id IN (SELECT rc_id
                      FROM ( SELECT DISTINCT rc_id
                                  , SIGN(ext_sll_prc) sn
                             FROM  rpro_rc_line_g
                             WHERE ext_sll_prc <> 0 )
                      GROUP BY rc_id
                      HAVING COUNT(1) > 1
                      UNION ALL
                      SELECT rc_id
                      FROM   rpro_rc_line_g
                      GROUP BY rc_id
                      HAVING SIGN(SUM(alctbl_xt_prc)) <> sign(SUM(ext_fv_prc))
                     )
         AND SUBSTR(a.indicators, 1, 1) =     'N'
         AND a.rev_hold_id              =     b.id
         AND UPPER(b.name)              LIKE '%HYBRID%'