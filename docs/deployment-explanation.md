# Deployment Explanation

## Current Deployment Flow

TaskFlow uses GitHub, Jenkins, Docker, Docker Compose, and GitHub Container Registry (GHCR).

```text
Developer
    |
    v
Git Push
    |
    v
GitHub Repository
    |
    v
Jenkins Pipeline
    |
    +--> Checkout Source Code
    +--> Validate Python Syntax
    +--> Build Docker Image
    +--> Start Docker Compose Environment
    +--> Run Automated Tests
    +--> Execute Health Check
    +--> Tag Docker Image
    +--> Push Image to GitHub Container Registry
    +--> Clean Up Temporary Environment
```

## Source Control

Development is performed using feature branches.

Each feature is developed independently, reviewed through a Pull Request, and merged into the `main` branch after successful validation.

## Continuous Integration

Jenkins automatically executes the pipeline defined in the `Jenkinsfile`.

The pipeline performs:

1. Checkout the source code.
2. Validate Python syntax.
3. Build the Docker image.
4. Start a temporary Docker Compose environment.
5. Wait for PostgreSQL to become healthy.
6. Run automated Pytest tests.
7. Verify the application health endpoint.
8. Tag the Docker image.
9. Publish the image to GitHub Container Registry.
10. Remove the temporary environment.

## Local Deployment

Developers can clone the repository and start the complete environment using:

```bash
docker compose up --build -d
```

The application becomes available on port **5000**.


---

# Linux Access Model

The local development environment follows basic Linux security practices.

Current configuration:

- Regular user account (`vboxuser`) is used for development.
- Administrative operations require `sudo`.
- Jenkins runs under its own service account.
- Jenkins has membership in the Docker group in order to execute Docker commands during CI builds.
- SSH authentication is used for Git operations.

Additional hardening (dedicated deployment user, SSH restrictions, firewall configuration and production access control) will be implemented after the AWS infrastructure is provisioned.


## Future Deployment

Future project phases will deploy the application to AWS infrastructure using Terraform and Ansible, followed by Kubernetes and Helm.
---

# Ansible Automation

The AWS EC2 server is configured automatically using Ansible.

## Automation Tasks

- Update the operating system package index
- Install Docker Engine
- Install Docker Compose
- Install Git
- Install Python 3 and pip
- Enable and start the Docker service
- Create a dedicated deployment user (`taskflow`)
- Add the deployment user to the Docker group
- Configure SSH public key authentication
- Disable direct root SSH login
- Disable SSH password authentication
- Clone the TaskFlow repository
- Deploy the application using Docker Compose
- Verify the application health endpoint

## Validation

The playbook was executed successfully.

A second execution completed with:

- changed = 0
- failed = 0

This confirms that the automation is idempotent.





---

# Kubernetes Deployment

TaskFlow is deployed to Kubernetes using separate manifests for the application and PostgreSQL.

The Kubernetes deployment includes:

- Dedicated `taskflow` namespace
- ConfigMap and Secret
- PersistentVolumeClaim for PostgreSQL
- PostgreSQL Deployment and ClusterIP Service
- TaskFlow Deployment with two replicas
- Readiness and Liveness probes
- Resource requests and limits
- Non-root security context
- Rolling update strategy
- Rollback validation
- PostgreSQL persistence validation
- NGINX Ingress

The application is available locally through:

```text
http://taskflow.local





---

# Helm Deployment

After validating the raw Kubernetes manifests, the deployment was converted into a reusable Helm chart.

The Helm chart includes:

- Configurable values
- PostgreSQL deployment
- TaskFlow deployment
- Services
- Ingress
- Persistent storage
- ConfigMap
- Secret
- Upgrade support
- Rollback support

The chart was validated using:

- helm lint
- helm template
- helm install
- helm upgrade
- helm rollback

The application remained available after both upgrade and rollback operations.
