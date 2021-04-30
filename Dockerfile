FROM debian:9

WORKDIR /opt/protractor

RUN apt-get update && \
    apt-get install -y \
    xvfb \
    curl \
    sudo \
    openjdk-8-jre

RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
    apt-get update && \
    apt-get install nodejs -y

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get -y update
RUN apt-get -y install google-chrome-stable

COPY ./package.json .

#ARG USERNAME
#RUN echo $USERNAME
#ARG API_KEY
#RUN echo $API_KEY
#RUN curl -u $USERNAME:$API_KEY https://na.artifactory.swg-devops.com/artifactory/api/npm/gbs-rsbn-npm-local/auth/rsbn > .npmrc
#RUN npm install --quiet

RUN npm install

COPY . .

RUN npm run e2e


