# TaskFlow DevOps Platform

## Overview

TaskFlow is a lightweight task and project management platform designed for small teams.

The project started as an internal task management solution for a remote-first company and later evolved into a reusable platform that demonstrates modern DevOps practices.

This repository demonstrates a complete DevOps workflow, including containerization, database integration, automated testing, Continuous Integration (CI), Infrastructure as Code, and cloud-ready deployment.


---

## Features

- Flask web application
- PostgreSQL database
- SQLAlchemy ORM
- Docker containerization
- Docker Compose
- Automated tests with Pytest
- Jenkins CI Pipeline
- Health Check automation
- GitHub Container Registry (GHCR)

---

## Architecture

```text
                Developer
                    │
                    ▼
             GitHub Repository
                    │
                    ▼
              Jenkins CI Pipeline
                    │
      ┌─────────────┴─────────────┐
      ▼                           ▼
 Validate                     Build Image
      │                           │
      ▼                           ▼
 Automated Tests          Docker Compose
                                   │
                     ┌─────────────┴─────────────┐
                     ▼                           ▼
                  Flask                     PostgreSQL
                     │
                     ▼
               Health Check
                     │
                     ▼
        GitHub Container Registry (GHCR)
```

---

## Technology Stack

| Category | Technology |
|----------|------------|
| Language | Python 3.12 |
| Framework | Flask |
| Database | PostgreSQL 16 |
| ORM | SQLAlchemy |
| Containerization | Docker |
| Multi-Container | Docker Compose |
| CI | Jenkins |
| Version Control | Git & GitHub |
| Testing | Pytest |
| Container Registry | GitHub Container Registry (GHCR) |

---

## Project Structure

```text
taskflow-devops-platform/
│
├── app/
├── tests/
├── scripts/
├── docs/
├── Dockerfile
├── compose.yaml
├── Jenkinsfile
└── README.md
```

---

## CI Pipeline

The Jenkins pipeline performs the following stages:

1. Checkout source code
2. Validate Python syntax
3. Build Docker image
4. Start Docker Compose environment
5. Wait for PostgreSQL readiness
6. Run automated tests
7. Execute Health Check
8. Tag Docker image
9. Push image to GitHub Container Registry
10. Clean up the environment

---

## Running the Project

Clone the repository:

```bash
git clone git@github.com:TalBenHamo/taskflow-devops-platform.git
cd taskflow-devops-platform
```

Start the application:

```bash
docker compose up --build -d
```

Verify the application:

```bash
curl http://localhost:5000/health
```

Run automated tests:

```bash
docker compose exec web sh -c "PYTHONPATH=/app pytest -v /tests"
```

---

