FROM debian:sid
MAINTAINER Luis Osa <luis.osa.gdc@gmail.com>

RUN apt-get update && apt-get -y upgrade && apt-get install -y sqlite3 wget

ENV PACKAGE=stockoverflow

ENV VERSION 7.1
ENV INSTALLER https://mirror.racket-lang.org/installers/$VERSION/racket-minimal-$VERSION-x86_64-linux.sh

RUN wget --output-document=racket-install.sh $INSTALLER && \
    echo "yes\n1\n" | /bin/bash racket-install.sh && \
    rm racket-install.sh

RUN mkdir /$PACKAGE
WORKDIR /$PACKAGE
COPY ./$PACKAGE/ .
RUN raco pkg install --auto

CMD ["racket", "main.rkt"]