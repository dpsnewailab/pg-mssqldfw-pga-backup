ARG POSTGRES_VERSION

FROM postgres:${POSTGRES_VERSION}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y tzdata locales

RUN locale-gen en_US.UTF-8

# set locale
ENV LANG C.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TZ=Asia/Ho_Chi_Minh

RUN apt-get update && apt-get install -y --no-install-recommends

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf

RUN locale-gen en_US.UTF-8

ARG POSTGRES_VERSION

# initial
RUN apt-get update
RUN apt-get install -y postgresql-server-dev-${POSTGRES_VERSION}
RUN apt-get install -y libsybdb5 freetds-dev freetds-common
RUN apt-get install -y gnupg gcc make
RUN apt-get install -y wget


ARG TDS_FDW_VERSION

# using from github
# https://github.com/tds-fdw/tds_fdw

RUN wget https://github.com/tds-fdw/tds_fdw/archive/v${TDS_FDW_VERSION}.tar.gz

RUN tar -xvzf v${TDS_FDW_VERSION}.tar.gz

RUN cd tds_fdw-${TDS_FDW_VERSION}/ &&  make USE_PGXS=1 && make USE_PGXS=1 install

COPY . .

RUN chmod 744 init_script.sh
RUN chmod 744 backup.sh

RUN mkdir /backup
