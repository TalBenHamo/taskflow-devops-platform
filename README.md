# TaskFlow DevOps Platform

## Overview

TaskFlow is a lightweight task and project management platform designed for small teams.

The project started as an internal task management solution for a remote-first company and evolved into a platform that demonstrates a complete DevOps workflow.

The current implementation includes application development, containerization, automated testing, CI/CD, Infrastructure as Code, AWS provisioning, automated server configuration, deployment, and health validation.

---

## Features

- Flask web application
- PostgreSQL database
- SQLAlchemy ORM
- Docker containerization
- Docker Compose
- Persistent database storage
- Automated tests with Pytest
- Bash health-check automation
- Jenkins CI/CD pipeline
- Docker image versioning
- GitHub Container Registry
- AWS infrastructure
- Terraform Infrastructure as Code
- Ansible server configuration
- Linux hardening
- Automated deployment to AWS

---

## Architecture

```text
Developer
    |
    v
GitHub Repository
    |
    v
Jenkins CI/CD Pipeline
    |
    +--> Validate Python and Ansible
    +--> Build Docker Image
    +--> Start Test Environment
    +--> Run Pytest
    +--> Run Health Check
    +--> Tag Image
    |       +--> Build Number
    |       +--> Git Commit SHA
    |       +--> latest
    +--> Push Image to GHCR
    +--> Run Ansible Deployment
    +--> Validate AWS Health Endpoint
              |
              v
        AWS Infrastructure
              |
       +------+------+
       |             |
       v             v
   EC2 Ubuntu     AWS Network
       |          VPC / Subnet
       |          Route Table
       |          Security Group
       v
Docker Compose
   |
   +--> Flask
   |
   +--> PostgreSQL
```

---

## Technology Stack

| Category | Technology |
|---|---|
| Language | Python 3.12 |
| Framework | Flask |
| Database | PostgreSQL 16 |
| ORM | SQLAlchemy |
| Operating System | Ubuntu 22.04 LTS |
| Containerization | Docker |
| Multi-Container Runtime | Docker Compose |
| Testing | Pytest |
| CI/CD | Jenkins |
| Version Control | Git and GitHub |
| Container Registry | GitHub Container Registry |
| Cloud Platform | AWS |
| Infrastructure as Code | Terraform |
| Configuration Management | Ansible |
| Compute | Amazon EC2 |
| Networking | Amazon VPC |

---

## Project Structure

```text
taskflow-devops-platform/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── templates/
├── ansible/
│   ├── ansible.cfg
│   ├── inventory.ini
│   ├── playbook.yml
│   ├── deploy.yml
│   ├── group_vars/
│   └── roles/
├── infra/
│   └── terraform/
├── tests/
├── scripts/
├── docs/
│   └── screenshots/
├── Dockerfile
├── compose.yaml
├── Jenkinsfile
└── README.md
```

---

## CI/CD Pipeline

The Jenkins pipeline performs the following stages:

1. Checkout source code
2. Validate Python syntax
3. Validate the Ansible deployment playbook
4. Build the Docker image
5. Start an isolated Docker Compose test environment
6. Wait for PostgreSQL readiness
7. Run automated Pytest tests
8. Verify the local health endpoint
9. Tag the image with:
   - Jenkins build number
   - Git commit SHA
   - `latest`
10. Push all image tags to GitHub Container Registry
11. Deploy TaskFlow to AWS using Ansible
12. Verify the health endpoint on the AWS server
13. Clean up the temporary CI environment

---

## AWS Infrastructure

Terraform provisions the following AWS resources:

- VPC
- Public subnet
- Internet gateway
- Public route table
- Route table association
- Security group
- SSH key pair
- Ubuntu EC2 instance

SSH access is limited to the configured administrator CIDR.

Terraform state files, variable files, saved plans, and local provider files are excluded from Git.

---

## Ansible Automation

Ansible prepares and deploys the AWS server.

The automation:

- Installs Docker and Docker Compose
- Installs Git, Python, pip, curl, and required packages
- Enables the Docker service
- Creates a dedicated `taskflow` deployment user
- Configures SSH public-key authentication
- Disables root SSH login
- Disables password authentication
- Clones the TaskFlow repository
- Starts the application with Docker Compose
- Verifies the application health endpoint

A second playbook execution completes with `changed=0`, proving idempotency.

---

## Running Locally

Clone the repository:

```bash
git clone git@github.com:TalBenHamo/taskflow-devops-platform.git
cd taskflow-devops-platform
```

Start the application:

```bash
docker compose up --build -d
```

Check the services:

```bash
docker compose ps
```

Verify the application:

```bash
curl http://localhost:5000/health
```

Run automated tests:

```bash
docker compose exec web sh -c "PYTHONPATH=/app pytest -v /tests"
```

Stop the environment:

```bash
docker compose down
```

---

## Terraform

Initialize and validate:

```bash
cd infra/terraform
terraform init
terraform fmt -check
terraform validate
terraform plan
```

Infrastructure variables and state files are stored locally and are not committed to Git.

---

## Ansible

Check connectivity:

```bash
cd ansible
ansible all -m ping
```

Configure and deploy a new server:

```bash
ansible-playbook playbook.yml
```

Deploy only the application:

```bash
ansible-playbook deploy.yml
```

---

## Current Status

Completed:

- Application foundation
- Docker and Docker Compose
- Automated testing
- Jenkins CI/CD
- GitHub Container Registry
- Terraform and AWS
- Ansible deployment
- Linux hardening

Planned next phases:

- Kubernetes
- Helm
- Prometheus
- Grafana
