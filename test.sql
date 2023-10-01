create table traffic_violations_p_2022
partition of traffic_violations_p
for values from ('2022-01-01') to ('2023-01-01') partition by range(date_of_stop);

CREATE TABLE brand_audi_recent PARTITION OF brand_audi FOR VALUES FROM ('2023-01-01 00:00:00') TO ('2023-06-30 23:59:59') partition by range(date_latest);


CREATE TABLE brand_audi_recent PARTITION OF penjualan_mobil FOR VALUES IN ('BMW') partition by range (waktu_pembuatan) FOR VALUES ('2023-01-01 00:00:00') TO ('2023-06-30 23:59:59');

CREATE TABLE brand_audi PARTITION OF penjualan_mobil FOR VALUES IN ('Audi') partition by range (waktu_pembuatan);

CREATE TABLE brand_audi_recent PARTITION OF brand_audi FOR VALUES FROM ('2023-01-01 00:00:00') TO ('2023-06-30 23:59:59');

SELECT c.oid,
	  n.nspname,
	  c.relname
	FROM pg_catalog.pg_class c
	     LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
	WHERE c.relname OPERATOR(pg_catalog.~) '^(large_test)$' COLLATE pg_catalog.default
	  AND pg_catalog.pg_table_is_visible(c.oid)
	ORDER BY 2, 3;
2023-09-20 12:25:12 WIB [1576040] postgres@belajar [local] LOG:  statement: SELECT c.relchecks, c.relkind, c.relhasindex, c.relhasrules, c.relhastriggers, c.relrowsecurity, c.relforcerowsecurity, false AS relhasoids, c.relispartition, pg_catalog.array_to_string(c.reloptions || array(select 'toast.' || x from pg_catalog.unnest(tc.reloptions) x), ', ')
	, c.reltablespace, CASE WHEN c.reloftype = 0 THEN '' ELSE c.reloftype::pg_catalog.regtype::pg_catalog.text END, c.relpersistence, c.relreplident, am.amname
	FROM pg_catalog.pg_class c
	 LEFT JOIN pg_catalog.pg_class tc ON (c.reltoastrelid = tc.oid)
	LEFT JOIN pg_catalog.pg_am am ON (c.relam = am.oid)
	WHERE c.oid = '18249';
2023-09-20 12:25:12 WIB [1576040] postgres@belajar [local] LOG:  statement: SELECT a.attname,
	  pg_catalog.format_type(a.atttypid, a.atttypmod),
	  (SELECT pg_catalog.pg_get_expr(d.adbin, d.adrelid, true)
	   FROM pg_catalog.pg_attrdef d
	   WHERE d.adrelid = a.attrelid AND d.adnum = a.attnum AND a.atthasdef),
	  a.attnotnull,
	  (SELECT c.collname FROM pg_catalog.pg_collation c, pg_catalog.pg_type t
	   WHERE c.oid = a.attcollation AND t.oid = a.atttypid AND a.attcollation <> t.typcollation) AS attcollation,
	  a.attidentity,
	  a.attgenerated,
	  a.attstorage,
	  a.attcompression AS attcompression,
	  CASE WHEN a.attstattarget=-1 THEN NULL ELSE a.attstattarget END AS attstattarget,
	  pg_catalog.col_description(a.attrelid, a.attnum)
	FROM pg_catalog.pg_attribute a
	WHERE a.attrelid = '18249' AND a.attnum > 0 AND NOT a.attisdropped
	ORDER BY a.attnum;
2023-09-20 12:25:12 WIB [1576040] postgres@belajar [local] LOG:  statement: SELECT c2.relname, i.indisprimary, i.indisunique, i.indisclustered, i.indisvalid, pg_catalog.pg_get_indexdef(i.indexrelid, 0, true),
	  pg_catalog.pg_get_constraintdef(con.oid, true), contype, condeferrable, condeferred, i.indisreplident, c2.reltablespace
	FROM pg_catalog.pg_class c, pg_catalog.pg_class c2, pg_catalog.pg_index i
	  LEFT JOIN pg_catalog.pg_constraint con ON (conrelid = i.indrelid AND conindid = i.indexrelid AND contype IN ('p','u','x'))
	WHERE c.oid = '18249' AND c.oid = i.indrelid AND i.indexrelid = c2.oid
	ORDER BY i.indisprimary DESC, c2.relname;
2023-09-20 12:25:12 WIB [1576040] postgres@belajar [local] LOG:  statement: SELECT pol.polname, pol.polpermissive,
	  CASE WHEN pol.polroles = '{0}' THEN NULL ELSE pg_catalog.array_to_string(array(select rolname from pg_catalog.pg_roles where oid = any (pol.polroles) order by 1),',') END,
	  pg_catalog.pg_get_expr(pol.polqual, pol.polrelid),
	  pg_catalog.pg_get_expr(pol.polwithcheck, pol.polrelid),
	  CASE pol.polcmd
	    WHEN 'r' THEN 'SELECT'
	    WHEN 'a' THEN 'INSERT'
	    WHEN 'w' THEN 'UPDATE'
	    WHEN 'd' THEN 'DELETE'
	    END AS cmd
	FROM pg_catalog.pg_policy pol
	WHERE pol.polrelid = '18249' ORDER BY 1;
2023-09-20 12:25:12 WIB [1576040] postgres@belajar [local] LOG:  statement: SELECT oid, stxrelid::pg_catalog.regclass, stxnamespace::pg_catalog.regnamespace::pg_catalog.text AS nsp, stxname,
	pg_catalog.pg_get_statisticsobjdef_columns(oid) AS columns,
	  'd' = any(stxkind) AS ndist_enabled,
	  'f' = any(stxkind) AS deps_enabled,
	  'm' = any(stxkind) AS mcv_enabled,
	stxstattarget
	FROM pg_catalog.pg_statistic_ext
	WHERE stxrelid = '18249'
	ORDER BY nsp, stxname;
2023-09-20 12:25:12 WIB [1576040] postgres@belajar [local] LOG:  statement: SELECT pubname
	     , NULL
	     , NULL
	FROM pg_catalog.pg_publication p
	JOIN pg_catalog.pg_publication_rel pr ON p.oid = pr.prpubid
	WHERE pr.prrelid = '18249'
	UNION ALL
	SELECT pubname
	     , NULL
	     , NULL
	FROM pg_catalog.pg_publication p
	WHERE p.puballtables AND pg_catalog.pg_relation_is_publishable('18249')
	ORDER BY 1;
2023-09-20 12:25:12 WIB [1576040] postgres@belajar [local] LOG:  statement: SELECT c.oid::pg_catalog.regclass
	FROM pg_catalog.pg_class c, pg_catalog.pg_inherits i
	WHERE c.oid = i.inhparent AND i.inhrelid = '18249'
	  AND c.relkind != 'p' AND c.relkind != 'I'
	ORDER BY inhseqno;
2023-09-20 12:25:12 WIB [1576040] postgres@belajar [local] LOG:  statement: SELECT c.oid::pg_catalog.regclass, c.relkind, inhdetachpending, pg_catalog.pg_get_expr(c.relpartbound, c.oid)
	FROM pg_catalog.pg_class c, pg_catalog.pg_inherits i
	WHERE c.oid = i.inhrelid AND i.inhparent = '18249'
	ORDER BY pg_catalog.pg_get_expr(c.relpartbound, c.oid) = 'DEFAULT', c.oid::pg_catalog.regclass::pg_catalog.text;

    SELECT c.oid::pg_catalog.regclass, c.relkind, inhdetachpending, pg_catalog.pg_get_expr(c.relpartbound, c.oid)   
    FROM pg_catalog.pg_class c, pg_catalog.pg_inherits i                                                            
                  WHERE c.oid = i.inhrelid AND i.inhparent = '18249'                                                              
                  ORDER BY pg_catalog.pg_get_expr(c.relpartbound, c.oid) = 'DEFAULT', c.oid::pg_catalog.regclass::pg_catalog.text;