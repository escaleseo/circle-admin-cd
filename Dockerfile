FROM google/cloud-sdk:alpine

COPY deploy.sh .
RUN chmod +x deploy.sh
