--ASC_761
SELECT header_id
, je.id
, je.amount
, schd_amount
FROM
rpro_je_line_g je,
rpro_je_head_g jeh,
(
SELECT
line_id,
SUM(amount) schd_amount
FROM
rpro_rc_schd_g
WHERE
substr(indicators, 11, 1) = 'M'
AND amount < 0
GROUP BY
line_id
) rs
WHERE
je.header_id = jeh.id
AND je.id = rs.line_id
AND je.amount + schd_amount <> 0
AND jeh.atr1 IS NULL
AND jeh.id = (SELECT Max(ID) from RPRO_JE_LINE_g where crtd_prd_id = (select id from rpro_period_g))
AND je.header_id <> 854265