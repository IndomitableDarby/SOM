FROM ubuntu:18.04

RUN apt-get update && apt-get install -y curl apt-transport-https lsb-release gnupg2
RUN curl -s https://packages.som.com/key/GPG-KEY-SOM | apt-key add - && \
    echo "deb https://packages.som.com/3.x/apt/ stable main" | tee /etc/apt/sources.list.d/som.list && \
    apt-get update && apt-get install som-agent=3.13.2-1 -y
