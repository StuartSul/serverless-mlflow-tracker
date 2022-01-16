#!/bin/bash

set -e

if [[ -z "${MLFLOW_SERVER_FILE_STORE}" ]]; then
  echo "MLFlow environment variable MLFLOW_SERVER_FILE_STORE is not set."
  exit 1
fi

if [[ -z "${MLFLOW_SERVER_ARTIFACT_ROOT}" ]]; then
  echo "MLFlow environment variable MLFLOW_SERVER_ARTIFACT_ROOT is not set."
  exit 1
fi

mlflow server \
  --backend-store-uri $MLFLOW_SERVER_FILE_STORE \
  --default-artifact-root $MLFLOW_SERVER_ARTIFACT_ROOT \
  --host 0.0.0.0
  --port 5000
  --workers 4
