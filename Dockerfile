FROM node:12

ENV WHICHNET=test


RUN apt-get update && apt-get -y install procps

WORKDIR /app

###

COPY package.json /app
COPY package-lock.json /app

RUN npm install --loglevel verbose 
RUN npm install -g mocha nodemon

### Add application files

COPY . /app


RUN npm run build-client


RUN apt-get install -y curl jq
RUN node -r esm util/approval.js

CMD ["sh", "-c", "bash /app/get_secret"]

EXPOSE 3000

CMD ["sh", "-c", "npm run start:${WHICHNET}"]
