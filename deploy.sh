#! /bin/sh
export WORKSPACE=$1
export PROJECT_NAME=$2
export TAG=$3
export VERSION=$(date "+%Y-%m-%dT%H:%M:%S")-${CIRCLE_SHA1}

# Setup Google Cloud SDK authentication
echo ${GOOGLE_AUTH} > ${HOME}/gcp-key.json
gcloud auth activate-service-account --key-file ${HOME}/gcp-key.json
gcloud --quiet config set project escale-os

# Copy distribution
set -exu
mv ${WORKSPACE} ${VERSION}
gsutil cp -r ${VERSION} gs://escale-admin-ui/${PROJECT_NAME}/

# Upload version reference
echo ${VERSION} > ${TAG}
gsutil cp ${TAG} gs://escale-admin-ui/${PROJECT_NAME}/
