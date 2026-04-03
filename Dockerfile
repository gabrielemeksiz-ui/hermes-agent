FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libffi-dev && \
    rm -rf /var/lib/apt/lists/*

COPY . /opt/hermes
WORKDIR /opt/hermes

RUN pip install -e ".[messaging,cron,mcp,honcho]" --no-cache-dir

RUN mkdir -p /app && printf '#!/bin/bash\nexec hermes --gateway' > /app/start.sh && chmod +x /app/start.sh

RUN chmod +x /opt/hermes/docker/entrypoint.sh

ENV HERMES_HOME=/opt/data
ENTRYPOINT [ "/opt/hermes/docker/entrypoint.sh" ]
