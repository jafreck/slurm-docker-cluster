#!/bin/bash
set -e

# MASTER_IP=$(echo -e $(hostname -I) | tr -d '[:space]')

# Create a directory for the hadoop file system
mkdir -p /batch/hadoop
echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://'$MASTER_IP':8020</value>
    </property>
</configuration>' > $HADOOP_HOME/etc/hadoop/core-site.xml

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
    </configuration>' > $HADOOP_HOME/etc/hadoop/hdfs-site.xml


if [ $IS_MASTER -eq "1" ]; then
    echo 'starting namenode and datanode'
    hdfs namenode -format
    $HADOOP_HOME/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode
    $HADOOP_HOME/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start datanode
else
    echo 'starting datanode - namenode at ' $MASTER_IP ':8020'
    $HADOOP_HOME/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start datanode
fi

exec "$@"
