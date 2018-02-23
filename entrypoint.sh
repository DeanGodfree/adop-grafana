#!/bin/bash

echo "moving config files in place and tokenising"

mv /etc/grafana/grafana.ini /usr/share/grafana/conf/grafana_original.ini
mv /usr/share/grafana/conf/grafana.ini /etc/grafana/ 

#echo "LDAP_HOST="${LDAP_HOST}
envsubst < /usr/share/grafana/conf/ldap_template.toml > /etc/grafana/adop_ldap.toml

echo "Restart Grafana"
: "${GF_PATHS_CONFIG:=/etc/grafana/grafana.ini}"
: "${GF_PATHS_DATA:=/var/lib/grafana}"
: "${GF_PATHS_LOGS:=/var/log/grafana}"
: "${GF_PATHS_PLUGINS:=/var/lib/grafana/plugins}"
: "${GF_PATHS_PROVISIONING:=/etc/grafana/provisioning}"

chown -R grafana:grafana /etc/grafana/
chown -R grafana:grafana /usr/share/grafana/

service grafana-server restart

echo "Running setup..."
/run.sh
exit 0
