--EVE_8967
SELECT
a.*
FROM
(
SELECT
schd.rc_id
, SUM(schd.amount) carveout_amount
FROM
rpro_rc_schd_g schd
, rpro_rc_line_g l
WHERE
1 = 1
AND substr(schd.indicators, 13, 1) = 'Y'  -- Initial Rep Entry Flag
AND substr(schd.indicators, 11, 1) = 'A' -- Schd Type Flag
AND post_prd_id = (
SELECT
id
FROM
rpro_period_g
)
AND l.id = schd.root_line_id
GROUP BY
schd.rc_id
HAVING
SUM(schd.amount) <> 0
UNION ALL
SELECT
rc_id
, SUM(cv_amt) carveout_amount
FROM
rpro_rc_line_g
WHERE
1 = 1
GROUP BY
rc_id
) a
WHERE
nvl(carveout_amount, 0) <> 0