FROM ubuntu:14.04
MAINTAINER George <7jagjag@gmail.com>

# Install dependencies
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update
RUN apt-get install -y git vim build-essential curl supervisor
RUN service supervisor start

ENV NVM_DIR /usr/local/nvm

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | bash

ENV NODE_VERSION v5.5.0

RUN source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

RUN cp /usr/local/nvm/versions/node/$NODE_VERSION/bin/node /bin/
RUN ln -s /usr/local/nvm/versions/node/$NODE_VERSION/lib/node_modules/npm/bin/npm-cli.js /bin/npm

RUN mkdir /app
COPY app.conf /etc/supervisor/conf.d/app.conf
