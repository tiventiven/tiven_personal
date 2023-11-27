alter role avnhasura set statement_timeout to '15s';
alter role avnhasura set idle_in_transaction_session_timeout to '30s';


alter role hasuraapiread set statement_timeout to '60s';
alter role hasuraapiread set idle_in_transaction_session_timeout to '30s';

alter role avninbound set statement_timeout to '15s';
alter role avninbound set idle_in_transaction_session_timeout to '15s';

alter role "avninbound-evco" set statement_timeout to '15s';
alter role "avninbound-evco" set idle_in_transaction_session_timeout to '15s';

alter role wmsinboundv3 set statement_timeout to '15s';
alter role wmsinboundv3 set idle_in_transaction_session_timeout to '15s';

alter role wmsinboundv3evco set statement_timeout to '15s';
alter role wmsinboundv3evco set idle_in_transaction_session_timeout to '15s';

alter role avnetl set statement_timeout to '30s';
alter role avnetl set idle_in_transaction_session_timeout to '30s';

\drds