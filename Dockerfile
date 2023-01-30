FROM  ubuntu:latest
# Install dependencies
RUN apt-get update
ENV KEYCLOAK_VERSION 20.0.3
ENV JDBC_POSTGRES_VERSION 42.2.5
ENV JDBC_MYSQL_VERSION 8.0.22
ENV JDBC_MARIADB_VERSION 2.5.4
ENV JDBC_MSSQL_VERSION 8.2.2.jre11
ENV LAUNCH_JBOSS_IN_BACKGROUND 1
ENV PROXY_ADDRESS_FORWARDING false
ENV JBOSS_HOME /opt/jboss/keycloak
ENV LANG en_US.UTF-8
ARG KEYCLOAK_DIST=https://github.com/keycloak/keycloak/releases/download/20.0.3/keycloak-20.0.3.tar.gz
USER root
RUN microdnf update -y && microdnf install -y glibc-langpack-en gzip hostname java-11-openjdk-headless openssl tar which && microdnf clean all
ADD tools /opt/jboss/tools
RUN /opt/jboss/tools/build-keycloak.sh
USER 1000
EXPOSE 8080
EXPOSE 8443
ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]
CMD ["-b", "0.0.0.0"]
