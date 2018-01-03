FROM dieudonne/docker-spark
MAINTAINER Dieudonne lx <lx.simon@yahoo.com>

ENV ZEPPELIN_NOTEBOOK_DIR="/notebook" \
    ZEPPELIN_MEM="-Xmx4096m -XX:MaxPermSize=512m"

# install apache zeppelin
RUN curl -O http://www-us.apache.org/dist/zeppelin/zeppelin-0.7.3/zeppelin-0.7.3-bin-all.tgz && \
    tar -xzf zeppelin-0.7.3-bin-all.tgz -C /opt/distribute && \
    rm -f zeppelin-0.7.3-bin-all.tgz && \
    cp /opt/distribute/zeppelin-0.7.3-bin-all/conf/zeppelin-env.sh.template /opt/distribute/zeppelin-0.7.3-bin-all/conf/zeppelin-env.sh && \
    cp /opt/distribute/zeppelin-0.7.3-bin-all/conf/zeppelin-site.xml.template /opt/distribute/zeppelin-0.7.3-bin-all/conf/zeppelin-site.xml

RUN python -m nltk.downloader all -d /opt/nltk_data

VOLUME ["/notebook", "/opt/distribute/zeppelin-0.7.3-bin-all/zeppelin-web-0.7.3.war"]
EXPOSE 8080
CMD ["/opt/zeppelin-0.7.3-bin-all/bin/zeppelin.sh"]
