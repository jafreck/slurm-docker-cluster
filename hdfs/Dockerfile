FROM centos:7

ARG HADOOP_VERSION=3.1.0

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre

RUN yum makecache fast \
    && yum -y install java-1.8.0-openjdk \
    && yum clean all \
    && rm -rf /var/cache/yum


RUN set -x \
    && curl -fSL "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" | tar -xvz -C /opt/

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}}

ENV PATH $HADOOP_PREFIX/bin/:$PATH

CMD ["/bin/bash"]
