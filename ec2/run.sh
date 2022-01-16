#!/bin/bash

# Get AWS credentials
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 037884848543.dkr.ecr.ap-northeast-2.amazonaws.com

# Pull image
docker pull 037884848543.dkr.ecr.ap-northeast-2.amazonaws.com/zai-ml-tracker:$1

# Run server
docker run -d --rm \
    -p 5000:5000 \
    -e MLFLOW_SERVER_FILE_STORE=$2 \
    -e MLFLOW_SERVER_ARTIFACT_ROOT=$3 \
    037884848543.dkr.ecr.ap-northeast-2.amazonaws.com/zai-ml-tracker:$1
