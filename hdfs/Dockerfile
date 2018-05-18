FROM centos:7

ARG HADOOP_VERSION=3.1.0

ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk

RUN yum makecache fast \
    && yum -y install java-1.8.0-openjdk supervisor \
    && yum clean all \
    && rm -rf /var/cache/yum


RUN set -x \
    && curl -fSL "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" | tar -xvz -C /opt/

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

ENV HADOOP_CONF_DIR=/etc/hadoop
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV PATH $HADOOP_HOME/bin/:$PATH

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["/bin/bash"]
