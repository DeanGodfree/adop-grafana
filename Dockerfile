FROM grafana/grafana:4.6.3

MAINTAINER Dean Godfree, <Dean.J.Godfree>

# Copy in configuration files
COPY resources/ldap.toml /etc/grafana/ldap.toml

# Reprotect
USER root

# Environment variables
ENV ADOP_LDAP_ENABLED=true

ENTRYPOINT ["/entrypoint.sh"]
