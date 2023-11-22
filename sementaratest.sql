EXPLAIN ANALYZE select
    i.status as status_v1,
    c.code as location_number,
    mt.id_v2 as tenant_id_v2,
    REPLACE(pv.sku_variant,'_PCS','') as sku,
    DATE(i.expiry_date) as expiry_date,
    DATE(i.created) as receiving_date,
    COUNT(i.entity_id) as quantity_v1
from
    `wms-inventory`.inventory i
    JOIN `wms-location`.container c ON i.container_entity_id = c.entity_id
    JOIN `wms-product`.product_variant pv ON pv.entity_id = i.product_variant_entity_id
    JOIN `wms-product`.map_v1_tenant mt ON i.tenant_entity_id = mt.id_v1
where
    mt.id_v2 IN (
        SELECT tenant_id FROM `wms-product`.tenant_group_map
        WHERE group_id IN (
            SELECT tn_group FROM `wms-product`.temp_tenant_group_config
        )
    ) AND pv.sku_variant NOT IN (SELECT sku_exclude FROM `wms-product`.temp_exclude_sku)
    and i.status = 'available'
group by 1,2,3,4,5,6;