FROM dieudonne/docker-spark
MAINTAINER Dieudonne lx <lx.simon@yahoo.com>

ENV ZEPPELIN_VERSION=0.7.3 \
    ZEPPELIN_NOTEBOOK_DIR="/notebook" \
    ZEPPELIN_MEM="-Xmx4096m -XX:MaxPermSize=512m"

# install apache zeppelin
RUN curl -O -L http://apache.cs.utah.edu/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz && \
    tar -xzf zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz -C /opt/distribute && \
    rm -f zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz && \
    cp /opt/distribute/zeppelin-${ZEPPELIN_VERSION}-bin-all/conf/zeppelin-env.sh.template /opt/distribute/zeppelin-${ZEPPELIN_VERSION}-bin-all/conf/zeppelin-env.sh && \
    cp /opt/distribute/zeppelin-${ZEPPELIN_VERSION}-bin-all/conf/zeppelin-site.xml.template /opt/distribute/zeppelin-${ZEPPELIN_VERSION}-bin-all/conf/zeppelin-site.xml

RUN python -m nltk.downloader all -d /opt/nltk_data

VOLUME ["/notebook"]
EXPOSE 8080
CMD ["/opt/distribute/zeppelin-${ZEPPELIN_VERSION}-bin-all/bin/zeppelin.sh"]
