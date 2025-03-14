--ASC_1927
SELECT DISTINCT
rc_line.num3 AS ba_number,
lh.updt_by AS hold_applied_by,
rc_line.atr16 AS source_system,
lh.updt_dt AS hold_applied_on,
lh.comments AS hold_comments,
rc_line.id,
rc_line.doc_num,
rc_line.doc_line_num,
rc_line.doc_line_id,
rc_line.item_num,
rc_line.rc_id
FROM
rpro_ln_hold_g lh
JOIN rpro_rc_line_g rc_line
ON rc_line.rc_id = lh.rc_id
JOIN rpro_rc_schd_g rs
ON rc_line.id = rs.root_line_id
WHERE
lh.rev_hold_id = 10005 -- Perpetual hold
AND substr(lh.indicators, 1, 1) = 'N' -- Hold is not released
AND rc_line.rel_pct > 0
AND rc_line.rel_pct < 100 -- Release pct > 0 but less than 100
AND (rc_line.ext_sll_prc <> 0 OR nvl(rc_line.cum_cv_amt, 0) <> 0)
AND rc_line.end_date > (
SELECT end_date
FROM rpro_calendar_g
WHERE id = (SELECT MAX(id)
FROM rpro_calendar_g
WHERE id < (select id from rpro_period_g) )) -- Update the period to the previous period
AND rs.post_prd_id = (select id from rpro_period_g)-- Current open period
