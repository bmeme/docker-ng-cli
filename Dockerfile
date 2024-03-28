ARG NODE_MAJOR_VERSION
FROM node:${NODE_MAJOR_VERSION}-slim

ARG NG_CLI_MAJOR_VERSION
ENV NG_CLI_MAJOR_VERSION ${NG_CLI_MAJOR_VERSION}

RUN set -eux; \
    apt-get update && apt-get install --no-install-recommends -y \
        chromium \
        ca-certificates; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; 

RUN npm install -g @angular/cli@${NG_CLI_MAJOR_VERSION}

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV SCULLY_PUPPETEER_EXECUTABLE_PATH '/usr/bin/chromium'

USER node

RUN INTERACTIVE=false ng version | grep 'Angular CLI' | awk -F: '{print $2}' | tr -d ' ' >> ${HOME}/.ng_cli_version

WORKDIR /home/node