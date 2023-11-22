select * from shipment.waybill where number ILIKE '%INV/20230402/MPL/31492%' 
and tracking_number ILIKE '%GTL007308%' AND status = 'delivered' and is_group = 'f' limit 2;

CREATE INDEX CONCURRENTLY testing ON shipment.waybill (number,tracking_number)