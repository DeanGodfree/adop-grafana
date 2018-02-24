FROM grafana/grafana:4.6.3

MAINTAINER Dean Godfree, <Dean.J.Godfree>

# Copy in configuration files
ADD ldap.toml /etc/grafana/ldap_template.toml
ADD grafana.ini /etc/grafana/grafana.ini
ADD dashboards/gatling-dashboard.json /var/lib/grafana/dashboards/gatling-dashboard.json
ADD dashboards/docker_containers.json /var/lib/grafana/dashboards/docker_containers.json
ADD dashboards/docker_host.json /var/lib/grafana/dashboards/docker_host.json
ADD dashboards/jenkins-performance-health.json /var/lib/grafana/dashboards/jenkins-performance-health.json
ADD dashboards/monitor_services.json /var/lib/grafana/dashboards/monitor_services.json
ADD dashboards/nginx_container.json /var/lib/grafana/dashboards/nginx_container.json
ADD datasources/influxdatasource.json  /etc/grafana/datasources/influxdatasource.json
ADD datasources/Prometheus.json  /etc/grafana/datasources/Prometheus.json

RUN apt-get update && \
	apt-get install -y dos2unix gettext-base && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

ADD run.sh /run.sh

# Workaround until Grafana 5 - Cannot import datasource as a file !!!
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/bin/bash"]
CMD ["/docker-entrypoint.sh"]
