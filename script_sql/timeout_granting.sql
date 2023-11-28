alter role avnhasura set statement_timeout to '15s';
alter role avnhasura set idle_in_transaction_session_timeout to '30s';
alter role avnhasura set idle_session_timeout to '0s';

alter role hasuraapiread set statement_timeout to '60s';
alter role hasuraapiread set idle_in_transaction_session_timeout to '30s';
alter role hasuraapiread set idle_session_timeout to '0s';

alter role avninbound set statement_timeout to '15s';
alter role avninbound set idle_in_transaction_session_timeout to '15s';
alter role avninbound set idle_session_timeout to '0s';

alter role "avninbound-evco" set statement_timeout to '15s';
alter role "avninbound-evco" set idle_in_transaction_session_timeout to '15s';
alter role "avninbound-evco" set idle_session_timeout to '0s';

alter role wmsinboundv3 set statement_timeout to '15s';
alter role wmsinboundv3 set idle_in_transaction_session_timeout to '15s';
alter role wmsinboundv3 set idle_session_timeout to '0s';

alter role wmsinboundv3evco set statement_timeout to '15s';
alter role wmsinboundv3evco set idle_in_transaction_session_timeout to '15s';
alter role wmsinboundv3evco set idle_session_timeout to '0s';

alter role avnetl set statement_timeout to '30s';
alter role avnetl set idle_in_transaction_session_timeout to '30s';
alter role avnetl set idle_session_timeout to '0s';

alter role avnshipment set statement_timeout to '60s';
alter role avnshipment set idle_in_transaction_session_timeout to '30s';
alter role avnshipment set idle_session_timeout to '0s';

alter role "avnstock-scheduler" set statement_timeout to '60s';
alter role "avnstock-scheduler" set idle_in_transaction_session_timeout to '30s';
alter role "avnstock-scheduler" set idle_session_timeout to '0s';

alter role avnwarehouse set statement_timeout to '60s';
alter role avnwarehouse set idle_in_transaction_session_timeout to '30s';
alter role avnwarehouse set idle_session_timeout to '0s';

alter role avnoutbound set statement_timeout to '60s';
alter role avnoutbound set idle_in_transaction_session_timeout to '30s';
alter role avnoutbound set idle_session_timeout to '0s';

alter role "avnemail-evco" set statement_timeout to '60s';
alter role "avnemail-evco" set idle_in_transaction_session_timeout to '30s';
alter role "avnemail-evco" set idle_session_timeout to '0s';

alter role "avnshipment-evco" set statement_timeout to '60s';
alter role "avnshipment-evco" set idle_in_transaction_session_timeout to '30s';
alter role "avnshipment-evco" set idle_session_timeout to '0s';

alter role avnuser set statement_timeout to '60s';
alter role avnuser set idle_in_transaction_session_timeout to '30s';
alter role avnuser set idle_session_timeout to '0s';

alter role avnjob set statement_timeout to '60s';
alter role avnjob set idle_in_transaction_session_timeout to '30s';
alter role avnjob set idle_session_timeout to '0s';

alter role avnproduct set statement_timeout to '60s';
alter role avnproduct set idle_in_transaction_session_timeout to '30s';
alter role avnproduct set idle_session_timeout to '0s';

alter role wmschgateway set statement_timeout to '60s';
alter role wmschgateway set idle_in_transaction_session_timeout to '30s';
alter role wmschgateway set idle_session_timeout to '0s';

alter role "avncounting-evco" set statement_timeout to '60s';
alter role "avncounting-evco" set idle_in_transaction_session_timeout to '30s';
alter role "avncounting-evco" set idle_session_timeout to '0s';

alter role "avnjob-evco" set statement_timeout to '60s';
alter role "avnjob-evco" set idle_in_transaction_session_timeout to '30s';
alter role "avnjob-evco" set idle_session_timeout to '0s';

alter role wmswhtransfer set statement_timeout to '60s';
alter role wmswhtransfer set idle_in_transaction_session_timeout to '30s';
alter role wmswhtransfer set idle_session_timeout to '0s';

alter role "avnoutbound-scheduler" set statement_timeout to '15s';
alter role "avnoutbound-scheduler" set idle_in_transaction_session_timeout to '15s';
alter role "avnoutbound-scheduler" set idle_session_timeout to '0s';

alter role wmspackagingrecommenderevco set statement_timeout to '60s';
alter role wmspackagingrecommenderevco set idle_in_transaction_session_timeout to '30s';
alter role wmspackagingrecommenderevco set idle_session_timeout to '0s';

alter role wmschgatewayevco set statement_timeout to '60s';
alter role wmschgatewayevco set idle_in_transaction_session_timeout to '30s';
alter role wmschgatewayevco set idle_session_timeout to '0s';

alter role wmsoutboundwave set statement_timeout to '60s';
alter role wmsoutboundwave set idle_in_transaction_session_timeout to '30s';
alter role wmsoutboundwave set idle_session_timeout to '0s';

alter role wmsoutboundresolver set statement_timeout to '15s';
alter role wmsoutboundresolver set idle_in_transaction_session_timeout to '30s';
alter role wmsoutboundresolver set idle_session_timeout to '0s';

alter role avnstock set statement_timeout to '60s';
alter role avnstock set idle_in_transaction_session_timeout to '30s';
alter role avnstock set idle_session_timeout to '0s';

alter role "avnstock-evco" set statement_timeout to '60s';
alter role "avnstock-evco" set idle_in_transaction_session_timeout to '30s';
alter role "avnstock-evco" set idle_session_timeout to '0s';

alter role "avnoutbound-evco" set statement_timeout to '60s';
alter role "avnoutbound-evco" set idle_in_transaction_session_timeout to '30s';
alter role "avnoutbound-evco" set idle_session_timeout to '0s';

alter role "avnzpl-generator" set statement_timeout to '60s';
alter role "avnzpl-generator" set idle_in_transaction_session_timeout to '30s';
alter role "avnzpl-generator" set idle_session_timeout to '0s';

alter role "avnproduct-evco" set statement_timeout to '60s';
alter role "avnproduct-evco" set idle_in_transaction_session_timeout to '30s';
alter role "avnproduct-evco" set idle_session_timeout to '0s';

alter role avncounting set statement_timeout to '60s';
alter role avncounting set idle_in_transaction_session_timeout to '30s';
alter role avncounting set idle_session_timeout to '0s';

alter role wmschscheduler set statement_timeout to '60s';
alter role wmschscheduler set idle_in_transaction_session_timeout to '30s';
alter role wmschscheduler set idle_session_timeout to '0s';

\drds