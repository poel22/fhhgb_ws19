FROM ubuntu:latest

RUN apt-get update 

RUN apt-get install -y g++

WORKDIR /root

COPY main.cpp .

RUN g++ main.cpp

CMD ./a.out
