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
