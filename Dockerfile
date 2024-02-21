
FROM registry.ci.openshift.org/ocp/4.12:cli
WORKDIR /

COPY jq-linux-amd64 /usr/bin/jq
COPY . .
RUN chmod +x kill.sh
RUN chmod +x /usr/bin/jq

ENTRYPOINT kill.sh