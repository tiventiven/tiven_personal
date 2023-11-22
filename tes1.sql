SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb
FROM trx_stock_movement_balance
WHERE tenant_id = 11871050 AND original_timestamp >= '2023-07-01 00:00:00' AND original_timestamp <= '2023-09-13 23:59:59' 
ORDER BY movement_balance_id DESC LIMIT 100 OFFSET 0

SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, 
request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb 
FROM trx_stock_movement_balance WHERE tenant_id = 1854168 AND original_timestamp >= 2023-09-01 00:00:00 
AND original_timestamp <= 2023-10-30 23:59:59 
AND warehouse_id IN (13056835) ORDER BY movement_balance_id DESC LIMIT 101 OFFSET 0;

    SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, created_by, is_vb 
    FROM trx_stock_movement_balance 
    WHERE movement_balance_id > 3151067 AND 
    tenant_id = 1854168 
    AND original_timestamp >= '2023-01-01 00:00:00' 
    AND original_timestamp <= '2023-10-30 23:59:59' 
    AND warehouse_id IN (13056835) 
    ORDER BY movement_balance_id ASC 
    LIMIT 101 OFFSET 0; 


    SELECT movement_balance_id, product_id, tenant_id, service_id, warehouse_id, partner_id, 
    request_id, movement_code, ref, ref_type, notes, original_timestamp, stock_detail, created_at, 
    created_by, is_vb FROM trx_stock_movement_balance WHERE movement_balance_id < 13328457 
    AND tenant_id = 1854168 AND original_timestamp >= '2023-09-01 00:00:00' 
    AND original_timestamp <= '2023-10-30 23:59:59' AND warehouse_id IN (13056835) 
    ORDER BY movement_balance_id DESC LIMIT 101 OFFSET 0;
     create index CONCURRENTLY testing1 on trx_stock_movement_balance (original_timestamp, movement_balance_id, tenant_id,ref,movement_code)
