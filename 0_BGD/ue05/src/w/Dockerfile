FROM node:latest

WORKDIR /root

COPY web web

WORKDIR web

RUN npm i

EXPOSE 3000

CMD node app.js
