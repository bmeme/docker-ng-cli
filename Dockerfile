ARG NODE_MAJOR_VERSION
FROM node:${NODE_MAJOR_VERSION}-slim

ARG NG_CLI_MAJOR_VERSION
ENV NG_CLI_MAJOR_VERSION ${NG_CLI_MAJOR_VERSION}

RUN set -eux; \
    apt-get update && apt-get install --no-install-recommends -y \
        chromium \
        ca-certificates; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
    \
    mkdir -p /app; \
    chown -R node:node /app ; \
    \
    npm install -g @angular/cli@${NG_CLI_MAJOR_VERSION}; \
    \
    INTERACTIVE=false ng version | grep 'Angular CLI' | awk -F: '{print $2}' | tr -d ' ' >> /home/node/.ng_cli_version; \
    node -v | awk -v char="v" '{gsub(char,""); print}' >> /home/node/.node_version;

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV SCULLY_PUPPETEER_EXECUTABLE_PATH '/usr/bin/chromium'

USER node

WORKDIR /app