--ASC_2102_3
SELECT
ln.rc_id
, ln.atr16
, ln.doc_line_id
, x.*
FROM
(
SELECT
*
FROM
(
SELECT
SUM(amount)
, rc_id schd_rc_id
FROM
rpro_rc_schd_g
WHERE
1 = 1
AND substr(indicators, 2, 2) IN ( 'NL', 'LR' )
AND prd_id = (select id from rpro_period_g)
AND substr(indicators, 1, 1) = 'N'
GROUP BY
rc_id
, substr(indicators, 2, 2)
HAVING
SUM(amount) <> 0
)
) x
, rpro_rc_line_g ln
, rpro_ln_hold_g lh
WHERE
1 = 1
AND ln.rc_id = x.schd_rc_id
AND ln.rc_id = lh.rc_id
AND lh.rev_hold_id = 10005 --PERPETUAL HOLD
AND substr(lh.indicators, 1, 1) = 'N' --PROCESSED_FLAG
