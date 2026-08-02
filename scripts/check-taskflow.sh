#!/usr/bin/env bash

# Exit immediately if a command fails.
# Treat unset variables as errors.
# Fail pipelines if any command fails.
set -euo pipefail

echo "=== Starting TaskFlow Health Check ==="

# -------------------------------------------------
# Check that the Docker daemon is running.
# -------------------------------------------------
if docker info > /dev/null 2>&1; then
    echo "SUCCESS: Docker daemon is active."
else
    echo "ERROR: Docker daemon is not running." >&2
    exit 1
fi

# -------------------------------------------------
# Check that Docker Compose services are running.
# -------------------------------------------------
RUNNING_SERVICES=$(docker compose ps --status running --services 2>/dev/null || true)

if [ -n "$RUNNING_SERVICES" ]; then
    echo "SUCCESS: Docker Compose services are running."
else
    echo "ERROR: No Docker Compose services are currently running." >&2
    exit 1
fi

# -------------------------------------------------
# Check that the TaskFlow application is healthy.
# -------------------------------------------------
if curl --fail --silent http://localhost:5000/health > /dev/null 2>&1; then
    echo "SUCCESS: TaskFlow health endpoint returned 200 OK."
else
    echo "ERROR: TaskFlow health endpoint check failed." >&2
    exit 1
fi

echo "=== All TaskFlow checks passed successfully! ==="
