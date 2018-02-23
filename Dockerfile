FROM grafana/grafana:4.6.3

MAINTAINER Dean Godfree, <Dean.J.Godfree>

# Copy in configuration files
COPY ldap.toml /usr/share/grafana/conf/ldap_template.toml
COPY grafana.ini /usr/share/grafana/conf/grafana.ini
COPY entrypoint.sh /entrypoint.sh

# Reprotect
USER root

RUN apt-get update && \
	apt-get install -y dos2unix gettext-base && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Environment variables
ENV ADOP_LDAP_ENABLED=true

ENTRYPOINT ["/entrypoint.sh"]
