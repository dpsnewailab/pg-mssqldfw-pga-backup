
FROM docker

RUN apk add --no-cache tzdata

WORKDIR /runable

COPY . .
RUN chmod 744 run.sh

#ENTRYPOINT run.sh