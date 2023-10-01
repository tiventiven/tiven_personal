CREATE FUNCTION public.func_prevent_drop_table() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    obj record;
BEGIN
    FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
    LOOP
        RAISE EXCEPTION 'COMMAND % is disabled for this table' ,tg_tag;
    END LOOP;
END;
$$;

ALTER FUNCTION public.func_prevent_drop_table() OWNER TO postgres;


CREATE TABLE events (
    event_id BIGSERIAL,
    operation CHAR(1),
    value FLOAT(24),
    parent_event_id BIGINT,
    event_type VARCHAR(25),
    org_id BIGSERIAL,
    created_at TIMESTAMP,
    CONSTRAINT pk_data_mart_event PRIMARY KEY (event_id, created_at)
    )partition by range (created_at);