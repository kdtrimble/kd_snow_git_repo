--ASC_1528_3
SELECT
a.id
, a.line_id cost_line_id
, c.atr16 source_system
, a.doc_line_id
, a.amount
, a.def_amt
, a.rec_amt
, c.ext_sll_prc
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
AND a.amount <> 0 --line which has cost amt
AND a.def_amt > 0 -- fully deferred
AND a.rec_amt = 0
AND c.ext_sll_prc = 0 --including zero dollar lines
AND c.cv_amt <> 0 --has carve amount
AND ( alctbl_xt_prc + nvl(cv_amt, 0) ) > 0 -- line which has net revenue
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
AND EXISTS --Check if allocation exists in schedules.
(
SELECT
1
FROM
rpro_rc_schd_g e
WHERE
e.root_line_id = c.id
AND substr(indicators, 11, 1) = 'A'
)
