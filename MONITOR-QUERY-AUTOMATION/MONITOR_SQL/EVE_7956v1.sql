select 
	  REVENUECONTRACTID as rc_id
	, substr(ACCOUNTINGSEGMENT,1,3) as BA
	, sum(TRANSACTIONDEBITAMOUNT) as dr_amount
	, sum(TRANSACTIONCREDITAMOUNT) as cr_amount
	, TRANSACTIONALCURRENCY as curr
	, CREATEDACCOUNTINGPERIOD as prd_id
from REVPRO_ZUORA_VSM2KMD.ZUORA_VSM2KMD.REVENUECONTRACTACCOUNTINGENTRIES
where CREATEDACCOUNTINGPERIOD= (select id from rpro_period_g)  --CURRENT PERIOD
       AND   rc_id IN ( SELECT   rc_id
                       FROM     rpro_rc_line_g
                       GROUP BY rc_id
                       HAVING   COUNT(DISTINCT sob_id) > 1)
	GROUP BY 
		  REVENUECONTRACTID
		, substr(ACCOUNTINGSEGMENT,1,3)
		, TRANSACTIONALCURRENCY
		, CREATEDACCOUNTINGPERIOD;