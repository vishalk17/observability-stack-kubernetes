------------------------

**Loki Single Binary ( Monolithic Installation Instructions )
**

------------------------
referances :

       https://grafana.com/docs/loki/latest/configure/
        https://grafana.com/docs/loki/latest/setup/install/helm/install-monolithic/
------------------------
Install pv-pvc for loki first

`kubectl apply -f loki-pv-pvc.yaml `

Install configmap for alerting rules ( this is needed before deploying loki using helm otherwise container will not create)

`kubectl apply -f loki-rules-configmap.yaml `

Install loki

`helm upgrade --install --values loki-values.yaml loki grafana/loki -n observability`

