import os

from mlflow.server import app
from mlflow.server.handlers import initialize_backend_stores

if 'MLFLOW_SERVER_FILE_STORE' not in os.environ or \
   'MLFLOW_SERVER_ARTIFACT_ROOT' not in os.environ:
  raise Exception('MLFlow environment variables are not specified.')

os.environ['_MLFLOW_SERVER_FILE_STORE'] = os.environ['MLFLOW_SERVER_FILE_STORE']
os.environ['_MLFLOW_SERVER_ARTIFACT_ROOT'] = os.environ['MLFLOW_SERVER_ARTIFACT_ROOT']
backend_store_uri = os.environ['_MLFLOW_SERVER_FILE_STORE']
default_artifact_root = os.environ['_MLFLOW_SERVER_ARTIFACT_ROOT']

initialize_backend_stores(backend_store_uri, default_artifact_root)
