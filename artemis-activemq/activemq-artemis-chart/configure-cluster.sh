#@IgnoreInspection BashAddShebang
set -e #-e  Exit immediately if a command exits with a non-zero status.
echo Copying common configuration
cp /opt/configure-common/template-common.xml /var/lib/artemis/etc-override/broker-10.xml

echo Assigning node as master
cp /opt/configure-master/template-master.xml /var/lib/artemis/etc-override/broker-11.xml

GROUPNAME=$(echo ${HOSTNAME} | sed -re 's/(-slave|-master)//')
echo Setting the group-name for slave to ${GROUPNAME}
xmlstarlet ed -L \  #XMLStarlet is a command line toolkit to query/edit/check/transform, L
-N activemq="urn:activemq" \
-N core="urn:activemq:core" \
-u "/activemq:configuration/core:core/core:ha-policy/core:replication/core:master/core:group-name" \
-v "${GROUPNAME}" /var/lib/artemis/etc-override/broker-11.xml

echo Setting the connector-ref to ${HOSTNAME}
      xmlstarlet ed -L \
        -N activemq="urn:activemq" \
        -N core="urn:activemq:core" \
        -u "/activemq:configuration/core:core/core:cluster-connections/core:cluster-connection[@name='activemq-activemq-artemis']/core:connector-ref" \
        -v "${HOSTNAME}" /var/lib/artemis/etc-override/broker-10.xml