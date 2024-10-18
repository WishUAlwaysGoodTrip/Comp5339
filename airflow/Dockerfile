# Use the official Apache Airflow slim image
FROM python:3.10-slim-buster
LABEL maintainer="elliot"

# Switch to root user to install packages
RUN apt-get update && \
    apt-get install -y postgresql-client wget pkg-config

# Never prompt the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# Airflow
ARG AIRFLOW_VERSION=2.9.3
ARG AIRFLOW_USER_HOME=/usr/local/airflow
ARG DBT_PROFILES=/usr/local/airflow/.dbt
ARG AIRFLOW_DEPS=""
ARG PYTHON_DEPS="wtforms==3.1.2"
ENV AIRFLOW_HOME=${AIRFLOW_USER_HOME}
ENV DBT_PROFILES_DIR=${DBT_PROFILES}

# Define en_US locale settings
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

# Install additional dependencies and Python packages
RUN set -ex \
    && buildDeps=' \
        freetds-dev \
        libkrb5-dev \
        libsasl2-dev \
        libssl-dev \
        libffi-dev \
        libpq-dev \
        git \
    ' \
    && apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq --no-install-recommends \
        $buildDeps \
        freetds-bin \
        build-essential \
        default-libmysqlclient-dev \
        apt-utils \
        curl \
        rsync \
        netcat \
        locales \
    && sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && pip install -U pip setuptools wheel \
    && pip install pytz pyOpenSSL ndg-httpsclient pyasn1 \
    && pip install apache-airflow[crypto,celery,postgres,hive,jdbc,mysql,ssh,redis${AIRFLOW_DEPS:+,}${AIRFLOW_DEPS}]==${AIRFLOW_VERSION} \
    && if [ -n "${PYTHON_DEPS}" ]; then pip install ${PYTHON_DEPS}; fi \
    && pip install xmltodict==0.13.0 dbt-postgres==1.8.2 dbt-core==1.8.2 psycopg2-binary==2.9.9 \
    && apt-get purge --auto-remove -yqq $buildDeps \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

# Copy additional configuration files and scripts
COPY airflow/script/entrypoint.sh /entrypoint.sh
COPY airflow/config/airflow.cfg /usr/local/airflow/airflow.cfg

# Define airflow user and group
RUN groupadd -r airflow && useradd -r -g airflow airflow

# Ensure correct permissions for airflow user
RUN chown -R airflow:airflow ${AIRFLOW_USER_HOME}

# Expose necessary ports
EXPOSE 8080 5555 8793

USER ROOT
COPY airflow/profiles.yml /usr/local/airflow/.dbt/profiles.yml
COPY airflow/check.sh /usr/local/airflow/check.sh
COPY airflow/dbt-utils-main /usr/local/airflow/dbt-utils-main

# Switch back to airflow user
USER airflow
WORKDIR ${AIRFLOW_USER_HOME}
ENTRYPOINT ["/entrypoint.sh"]
RUN  bash /usr/local/airflow/check.sh
CMD ["webserver"]
