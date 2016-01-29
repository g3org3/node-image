FROM ubuntu:14.04
MAINTAINER George <7jagjag@gmail.com>

# Install dependencies
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update
RUN apt-get install -y git vim build-essential curl supervisor
RUN service supervisor start

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 4.2.1

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

RUN mkdir /app
COPY app.conf /etc/supervisor/conf.d/app.conf
