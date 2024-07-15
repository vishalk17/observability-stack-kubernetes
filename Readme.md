# Monitoring & Alerting Setup for Kubernetes

This repository contains the setup for monitoring and alerting in a MicroK8s kubernetes cluster. 

## What is my goal here ( Monitoring & Alerting ) :

- node-level metrics
- pod-level metrics
- pod logs 
- node-level logs ( dmesg, /var/log/messages, syslog )

### Notification Method : 
 - send alerts via email using Prometheus Alertmanager.

## Components

- Node Exporters: for collecting node-level metrics
- Promtail-Loki: for collecting pod logs and node-level logs
- Prometheus: for collecting and storing metrics
- Alertmanager: for sending alerts via email

## Storage : 

This setup uses hostPath-based storage for observability, which can be changed according to your use case (If you decided not to go for hostpath based storage).

## Loki :

This setup uses Loki (single binary/monolithic) for log collection and storage. Other options like Loki-scalable are available but not covered in this setup.

## Kubernetes Distribution :  

This setup uses MicroK8s as the Kubernetes distribution.

## External URLs The following external URLs have been decided for:

- Prometheus UI
- Grafana
- AlertManager
- Promtail

Access All components are exposed using NodePort for externally public access. The format for accessing each component in my case is `Public_ip_of_kmaster:NodePort`.

-----------------------------------

# Other links:

Linkedin : https://www.linkedin.com/in/vishal-kapadi/

Github : https://github.com/vishalk17

My Github DevOps Repo: https://github.com/vishalk17/devops/

Youtube : https://www.youtube.com/@vishalk17

Telegram : http://t.me/vishalk17

Telegram Channel : https://t.me/vishalk17_devops


