#!/bin/bash
set -e

echo "- Starting all HDFS processes under supervisord"
/usr/bin/supervisord --configuration /etc/supervisord.conf

# MASTER_IP=$(echo -e $(hostname -I) | tr -d '[:space]')

# Create a directory for the hadoop file system
mkdir -p /batch/hadoop
echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://hdfs-namenode:8020</value>
    </property>
</configuration>' > /etc/hadoop/core-site.xml

echo '<?xml version="1.0" encoding="UTF-8"?>
    <?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
    <configuration>
        <property>
            <name>dfs.namenode.datanode.registration.ip-hostname-check</name>
            <value>false</value>
        </property>
        <property>
            <name>dfs.datanode.data.dir</name>
            <value>file:///batch/hadoop</value>
        </property>
    </configuration>' > /etc/hadoop/hdfs-site.xml

$@

tail -F /dev/null
