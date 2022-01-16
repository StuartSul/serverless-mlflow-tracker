# Docker image for serving to EC2, instead of serverless architectures

ARG BUILD_IMAGE=python:3.8.12
FROM ${BUILD_IMAGE}

# Create and set working directory
RUN mkdir /zai_mlflow
WORKDIR /zai_mlflow
ARG TASK_ROOT=/zai_mlflow

# Set user & group
ARG UID=1035
ARG GID=1035
RUN groupadd -g $GID -o zai_mlflow && useradd -m -u $UID -g $GID -o -r zai_mlflow

# Install MLFlow and PostgreSQL client
RUN pip install mlflow==1.22.*
RUN pip install psycopg2==2.9.*
RUN pip install boto3==1.20.*

# Copy entrypoint
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

# Set permissions
RUN chown zai_mlflow:zai_mlflow ${TASK_ROOT} -R
USER zai_mlflow

# Set port
EXPOSE 5000

# Set entry command
ENTRYPOINT [ "bash", "entrypoint.sh" ].
