--ASC_1528
SELECT
a.id
, a.line_id cost_line_id
, c.atr16 source_system
, a.doc_line_id
, a.amount
, a.def_amt
, a.rec_amt
, c.rec_amt ln_rec_amt
, c.def_amt ln_def_amt
, ( alctbl_xt_prc + nvl(cv_amt, 0) ) net_revenue
, a.rc_id
, b.line_id schd_line_id
, b.pob_id schd_pob_id
, b.amount schd_amount
, b.indicators
FROM
rpro_ln_cost_g a
, rpro_rc_schd_g b
, rpro_rc_line_g c
WHERE
1 = 2
AND a.line_id = b.root_line_id
AND a.line_id = c.id
AND a.amount <> 0
AND a.def_amt > 0
AND a.rec_amt = 0
AND c.rec_amt <> 0
AND ( alctbl_xt_prc + nvl(cv_amt, 0) ) > 0
AND NOT EXISTS (
SELECT
1
FROM
rpro_rc_schd_g d
WHERE
1 = 1
AND a.line_id = d.root_line_id
AND substr(d.indicators, 11, 1) = 'C'
)
