--ASC_2102_2
SELECT
a.rc_id
, a.atr16
, a.rec_amt
, lh.rev_hold_id
, lh.indicators
FROM
rpro_rc_line_g a
, rpro_ln_hold_g lh
WHERE
1 = 1
AND a.rc_id = lh.rc_id
AND substr(lh.indicators, 1, 1) = 'N'
AND lh.rev_hold_id = 10005 --Perpetual Hold
AND a.rc_id IN (
SELECT DISTINCT
rc_id
FROM
rpro_rc_schd_g
WHERE
prd_id = (select id from rpro_period_g)
AND substr(indicators, 1, 1) = 'N'
)
