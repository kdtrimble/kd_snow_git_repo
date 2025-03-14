---------
---ASC_1284

WITH RC_LINE(RC_ID,ATR16)
as
(SELECT rc_id,atr16
              FROM   rpro_rc_line_g rrl)
SELECT rl.atr16 source_system
       , rh.id
       , rh.indicators
      FROM rpro_rc_head_g rh,RC_LINE rl
      WHERE rl.rc_id = rh.id
      AND substr(rh.indicators, 6, 1) = 'Y'
      AND EXISTS ( SELECT 1
                   FROM   rpro_ln_hold_g lh
                   WHERE  lh.rc_id                    = rh.id
                   AND    lh.rev_hold_id              = 10005
                   AND    substr(lh.indicators, 1, 1) = 'N'
                 )