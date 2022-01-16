#!/bin/bash

# Build image
docker build \
    -t 037884848543.dkr.ecr.ap-northeast-2.amazonaws.com/zai-ml-tracker:$1 .

# Get AWS credentials
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 037884848543.dkr.ecr.ap-northeast-2.amazonaws.com

# Push to ECR
docker push 037884848543.dkr.ecr.ap-northeast-2.amazonaws.com/zai-ml-tracker:$1
