FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
ARG compiler_version="4.09.0"
LABEL maintainer "Noritaka Horio <holy.shared.design@gmail.com>"
RUN apt -y update && \
  apt -y install sudo m4 curl wget rsync git mercurial darcs unzip bubblewrap pkg-config libgmp-dev && \
  rm -rf /var/lib/apt/lists/
RUN wget -O /var/tmp/opam_install.sh  https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh
RUN chmod 0755 /var/tmp/opam_install.sh
RUN echo "/usr/local/bin" | /var/tmp/opam_install.sh
RUN adduser --disabled-password --gecos "" develop && passwd -l develop
ADD developsudo /etc/sudoers.d/develop
RUN chmod 440 /etc/sudoers.d/develop && \
  chown root:root /etc/sudoers.d/develop && \
  chown -R develop:develop /home/develop
USER develop
ENV HOME /home/develop
WORKDIR /home/develop
RUN opam init -y --disable-sandboxing && opam switch create ${compiler_version}
RUN echo "eval \`opam config env\`" >> ~/.bashrc
RUN mkdir project
