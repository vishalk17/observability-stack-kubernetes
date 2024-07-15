Execute Following commands to install promtail. 

`kubectl apply -f promtail-service.yaml`

`helm upgrade --install --values promtail-values.yaml promtail grafana/promtail -n observability`