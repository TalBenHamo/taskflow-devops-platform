# TaskFlow DevOps Platform

![Python](https://img.shields.io/badge/Python-3.12-blue)
![Docker](https://img.shields.io/badge/Docker-Enabled-2496ED)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Production-326CE5)
![Helm](https://img.shields.io/badge/Helm-Deployed-0F1689)
![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-red)
![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC)
![Ansible](https://img.shields.io/badge/Ansible-Automation-black)

## Project Overview

TaskFlow is a complete end-to-end DevOps project demonstrating a modern CI/CD workflow and cloud-native deployment.

The application is built with Flask and deployed using Docker, Kubernetes and Helm, automated through Jenkins, provisioned with Terraform, configured using Ansible and monitored using Prometheus and Grafana.

---

# Technologies

- Python Flask
- Docker
- Docker Compose
- GitHub Container Registry (GHCR)
- Jenkins
- Terraform
- AWS EC2
- Ansible
- Kubernetes
- Helm
- Prometheus
- Grafana

---

# Architecture

```text
Developer
    |
    v
GitHub Repository
    |
    v
Jenkins CI/CD
    |
    +--> Validate
    +--> Build Docker Image
    +--> Automated Tests
    +--> Health Check
    +--> Tag Image
    +--> Push Image to GHCR
              |
       +------+------+
       |             |
       v             v
 AWS Deployment   Kubernetes Deployment
       |             |
    Ansible       Raw Manifests
       |             |
    AWS EC2          Helm
                     |
                   Ingress
                     |
                 Prometheus
                     |
                  Grafana

---

# Repository Structure

```
app/
ansible/
docs/
infra/
kubernetes/
monitoring/
scripts/
tests/
```

---

# Features

- Dockerized Flask application
- Multi-stage Jenkins Pipeline
- Automated Docker image publishing
- Infrastructure as Code with Terraform
- Configuration Management using Ansible
- Kubernetes production deployment
- Health Checks
- Rolling Updates
- Rollback
- Persistent Storage
- Ingress
- Helm Chart
- Monitoring with Prometheus
- Visualization with Grafana

---

# Screenshots

See:

docs/screenshots/

---

# Project Workflow

Development

↓

Docker Build

↓

CI Pipeline

↓

Push Image

↓

Deploy

↓

Monitor

↓

Rollback (if needed)

---

# Monitoring

Monitoring is implemented using:

- Prometheus
- Grafana
- kube-state-metrics
- Node Exporter

---

# Deployment Options

The application supports multiple deployment methods:

- Docker Compose
- AWS EC2
- Kubernetes Manifests
- Helm Chart

Monitoring is provided using Prometheus and Grafana.


# Author

Tal Ben Hamo
