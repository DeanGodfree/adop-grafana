FROM grafana/grafana:4.6.3

MAINTAINER Dean Godfree, <Dean.J.Godfree>

# Copy in configuration files
ADD ldap.toml /etc/grafana/ldap_template.toml
ADD grafana.ini /etc/grafana/grafana.ini
ADD dashboards/gatling-dashboard.json /etc/grafana/dashboards/gatling-dashboard.json
ADD dashboards/docker_containers.json /etc/grafana/dashboards/docker_containers.json
ADD dashboards/docker_host.json /etc/grafana/dashboards/docker_host.json
ADD dashboards/jenkins-performance-health_test.json /etc/grafana/dashboards/jenkins-performance-health_test.json
ADD dashboards/monitor_services.json /etc/grafana/dashboards/monitor_services.json
ADD dashboards/nginx_container.json /etc/grafana/dashboards/nginx_container.json
ADD datasources/influxdatasource.json  /etc/grafana/datasources/influxdatasource.json
ADD datasources/Prometheus.json  /etc/grafana/datasources/Prometheus.json

RUN apt-get update && \
	apt-get install -y dos2unix gettext-base
	
#Install Filebeat
RUN curl -o /tmp/filebeat_6.2.2_amd64.deb https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.2-amd64.deb && \
    dpkg -i /tmp/filebeat_6.2.2_amd64.deb && \
    apt-get install && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
 #Copying new filebeat config in post install
 COPY resources/filebeat.yml /etc/filebeat/filebeat.yml

ADD run.sh /run.sh
RUN chmod +x /run.sh

# Workaround until Grafana 5 - Cannot import datasource as a file !!!
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/bin/bash"]
CMD ["/docker-entrypoint.sh"]
