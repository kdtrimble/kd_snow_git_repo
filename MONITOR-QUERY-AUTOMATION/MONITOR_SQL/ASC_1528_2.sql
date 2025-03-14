--ASC_1528_2
SELECT
a.atr16
, a.line_id
, a.doc_num
, a.doc_line_id
, a.item_num
, a.amount
, a.def_amt
, a.rec_amt
, a.rc_id
FROM
rpro_ln_cost_g a
WHERE
1 = 2
AND rec_amt = 0 --FULLY Def in cost table
AND def_amt <> 0
AND line_id IN (
SELECT
id
FROM
rpro_rc_line_g
WHERE
1 = 1
AND def_amt = 0-- revenue recognized
AND rec_amt > 0
)
