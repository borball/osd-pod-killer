
FROM registry.redhat.io/openshift4/ose-cli:v4.12
WORKDIR /

COPY jq-linux-amd64 /usr/bin/jq
COPY . .
RUN chmod +x kill.sh
RUN chmod +x /usr/bin/jq

ENTRYPOINT kill.sh