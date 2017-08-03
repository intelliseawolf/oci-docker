FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Noritaka Horio <holy.shared.design@gmail.com>
RUN apt-get -y update && \
  apt-get -y install sudo m4 opam libssl-dev pkg-config && \
  rm -rf /var/lib/apt/lists/*
RUN adduser --disabled-password --gecos "" develop && passwd -l develop
ADD developsudo /etc/sudoers.d/develop
RUN chmod 440 /etc/sudoers.d/develop && \
  chown root:root /etc/sudoers.d/develop && \
  chown -R develop:develop /home/develop
USER develop
ENV HOME /home/develop
WORKDIR /home/develop
RUN opam init -y && opam switch 4.05.0 && opam install -y camlp4
RUN echo "eval \`opam config env\`" >> ~/.bashrc
RUN mkdir project
