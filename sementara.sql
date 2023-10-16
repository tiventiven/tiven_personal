SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, 
partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE product_id IN (?, ?, ?) AND original_timestamp >= ? AND original_timestamp <= ? 
AND warehouse_id IN (?, ?) AND ref = ? AND movement_code IN (?, ?) ORDER BY movement_balance_id ASC LIMIT 100 OFFSET 0



SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, 
partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb 
FROM trx_stock_movement_balance 
WHERE tenant_id = ? AND original_timestamp >= ? AND original_timestamp <= ? 
AND warehouse_id IN (?, ?) AND ref = ? AND movement_code IN (?, ?) ORDER BY movement_balance_id ASC LIMIT 100 OFFSET 0

SELECT movement_balance_id, product_id, tenant_id, service_id, 
warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb 
FROM trx_stock_movement_balance 
WHERE product_id IN (?, ?, ?) AND tenant_id = ? AND original_timestamp >= ? 
AND original_timestamp <= ? AND warehouse_id IN (?, ?) AND ref = ? AND movement_code IN (?, ?) ORDER BY movement_balance_id ASC 
LIMIT 100 OFFSET 0

SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, 
partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE movement_balance_id > (?) AND product_id IN (?, ?, ?) AND original_timestamp >= ? AND original_timestamp <= ? 
AND warehouse_id IN (?, ?) AND ref = ? AND movement_code IN (?, ?) ORDER BY movement_balance_id ASC LIMIT 100 

CREATE INDEX CONCURRENTLY testing ON trx_stock_movement_balance (product_id,original_timestamp)
create index concurrently trx_stock_movement_balance_tenant_id_original_timestamp_index on trx_stock_movement_balance (tenant_id, original_timestamp);
SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE product_id IN (8333922477) AND original_timestamp >= '2023-08-01' AND original_timestamp <= '2023-08-31 
ORDER BY movement_balance_id ASC 
LIMIT 100 OFFSET 0;

SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE product_id IN (1608538299,389588397,6981302886 ) AND original_timestamp >= '2023-10-04' AND original_timestamp <= '2023-10-31'
ORDER BY movement_balance_id ASC
LIMIT 11 OFFSET 0;


SELECT movement_balance_id, product_id, original_timestamp
FROM trx_stock_movement_balance
WHERE product_id IN (1608538299,389588397,6981302886 ) AND original_timestamp >= '2023-10-04' AND original_timestamp <= '2023-10-31'
ORDER BY movement_balance_id ASC
LIMIT 11 OFFSET 0;

21
create index concurrently testingasc on trx_stock_movement_balance (product_id, original_timestamp, movement_balance_id ASC NULLS FIRST );

create index concurrently testingasc on trx_stock_movement_balance (movement_balance_id ASC,product_id, original_timestamp  );
create index concurrently testingdesc on trx_stock_movement_balance ( movement_balance_id DESC,product_id, original_timestamp );

create index concurrently testingdesc on trx_stock_movement_balance (product_id, original_timestamp, movement_balance_id DESC );
create index concurrently testing on trx_stock_movement_balance (product_id, original_timestamp );


create index concurrently trx_stock_movement_balance_tenant_id_original_timestamp_index on trx_stock_movement_balance (tenant_id, original_timestamp);

SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE product_id IN (10524460582, 3699060894) AND original_timestamp >= '2023-05-01' AND original_timestamp <= '2023-12-01'
ORDER BY movement_balance_id ASC NULLS FIRST LIMIT 11 OFFSET 0;


SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE movement_balance_id >= 3151067 and product_id IN (10524460582, 618149441, 3609909, 3610082, 3578118) AND original_timestamp >= '2023-09-01' AND original_timestamp <= '2023-10-01'
ORDER BY movement_balance_id DESC LIMIT 11 OFFSET 0;

SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE product_id IN (655112055, 618149441, 670814141) AND original_timestamp >= '2023-08-01' AND original_timestamp <= '2023-09-01'
ORDER BY movement_balance_id aSC LIMIT 50;

SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE movement_balance_id >= 3151067 and product_id IN (655112055, 618149441, 670814141) AND original_timestamp >= '2023-06-01' AND original_timestamp <= '2023-09-01'
ORDER BY movement_balance_id DESC LIMIT 11;

SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE movement_balance_id >= 3151067 and product_id ANY (Array[655112055,618149441, 670814141] AND original_timestamp >= '2023-06-01' AND original_timestamp <= '2023-09-01'
ORDER BY movement_balance_id DESC LIMIT 11;


SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE movement_balance_id >= 3151067 and product_id IN  (values (655112055), (618149441), (670814141)) AND original_timestamp >= '2023-06-01' AND original_timestamp <= '2023-09-01'
ORDER BY movement_balance_id DESC LIMIT 11;


SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE product_id = '609909' AND original_timestamp >= '2023-08-10' AND original_timestamp <= '2023-09-01'
ORDER BY movement_balance_id ASC; #still bitmap heap scan, range maximum nya sepertinya 20 harian.

SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE movement_balance_id >= 3151067 AND movement_balance_id <= 3151078 AND product_id IN (609909, 3609909) AND original_timestamp >= '2023-08-01' AND original_timestamp <= '2023-09-01'
ORDER BY movement_balance_id ASC;

SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE movement_balance_id >= 3151067  AND product_id IN (3610082, 3609909) AND original_timestamp >= '2023-08-01' AND original_timestamp <= '2023-09-01'
ORDER BY movement_balance_id DESC LIMIT 11;

explain SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE product_id = '609909' AND original_timestamp >= '2023-08-10' AND original_timestamp <= '2023-09-01'
ORDER BY movement_balance_id ASC;


SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE tenant_id IN (11871050,216863, 2068287) AND original_timestamp >= '2023-09-01 00:00:00' AND original_timestamp <= '2023-09-13 23:59:59'
ORDER BY movement_balance_id ASC LIMIT 50 OFFSET 0;

create index concurrently trx_stock_movement_balance_mbid_asc_tid_time_ref_code_index on trx_stock_movement_balance (original_timestamp, tenant_id, movement_balance_id, ref, movement_code);