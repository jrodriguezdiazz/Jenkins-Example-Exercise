FROM jenkins/jenkins:lts

USER root

RUN apt-get update

RUN curl -sSl https://get.docker.com/ | sh
