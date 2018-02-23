FROM grafana/grafana:4.6.3

MAINTAINER Dean Godfree, <Dean.J.Godfree>

# Copy in configuration files
ADD ldap.toml /etc/grafana/ldap_template.toml
ADD grafana.ini /etc/grafana/grafana.ini

RUN apt-get update && \
	apt-get install -y dos2unix gettext-base && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

ADD run.sh /run.sh

# Workaround until Grafana 5 - Cannot import datasource as a file !!!
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/bin/bash"]
CMD ["/docker-entrypoint.sh"]
