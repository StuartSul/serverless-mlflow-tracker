# python:3.8.12
ARG BUILD_IMAGE=python@sha256:90e0a08f49f46afa33dc1eed864576f8bea8eac9e33d58a76970211aed85c0d3
FROM ${BUILD_IMAGE} AS BUILD

# Create and set working directory
RUN mkdir /builds
WORKDIR /builds

# Set virtual environment
RUN python -m venv ./env
RUN chmod +x ./env/bin/activate

# Install dependent packages
COPY requirements.txt ./
RUN ./env/bin/pip install -r requirements.txt

# Build deployable package
COPY ./* ./
RUN . ./env/bin/activate && zappa package production -o package.zip
RUN unzip -q package.zip -d package

# Deployment stage
ARG BUILD_IMAGE
FROM ${BUILD_IMAGE}

# Create and set working directory
RUN mkdir /zai_mlflow
WORKDIR /zai_mlflow
ARG TASK_ROOT=/zai_mlflow

# Set user & group
ARG UID=1035
ARG GID=1035
RUN groupadd -g $GID -o zai_mlflow && useradd -m -u $UID -g $GID -o -r zai_mlflow

# Copy build artifacts
COPY --from=BUILD /builds/package/handler.py ${TASK_ROOT}
COPY --from=BUILD /builds/package/wsgi_app.py ${TASK_ROOT}
COPY --from=BUILD /builds/package/zappa_settings.py ${TASK_ROOT}

# Install dependencies
COPY requirements.txt ${TASK_ROOT}
RUN pip install -r requirements.txt

# Install AWS lambda runtime API
RUN pip install awslambdaric

# Set permissions
RUN chown zai_mlflow:zai_mlflow ${TASK_ROOT} -R
USER zai_mlflow

# Set entry command
ENTRYPOINT [ "python", "-m", "awslambdaric" ]
CMD [ "handler.lambda_handler" ]
