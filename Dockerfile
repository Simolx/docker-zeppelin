FROM dieudonne/docker-spark
MAINTAINER Dieudonne lx <lx.simon@yahoo.com>

ENV ZEPPELIN_VERSION=0.8.0 \
    ZEPPELIN_NOTEBOOK_DIR="/notebook" \
    ZEPPELIN_MEM="-Xmx4096m -XX:MaxPermSize=512m"

# install apache zeppelin
RUN curl -L http://apache.cs.utah.edu/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz |tar -xzf - -C /opt/distribute && \
    cp /opt/distribute/zeppelin-${ZEPPELIN_VERSION}-bin-all/conf/zeppelin-env.sh.template /opt/distribute/zeppelin-${ZEPPELIN_VERSION}-bin-all/conf/zeppelin-env.sh && \
    cp /opt/distribute/zeppelin-${ZEPPELIN_VERSION}-bin-all/conf/zeppelin-site.xml.template /opt/distribute/zeppelin-${ZEPPELIN_VERSION}-bin-all/conf/zeppelin-site.xml

RUN conda install -y pandas matplotlib seaborn plotly bokeh dask \
    && conda clean --all -y

VOLUME ["/notebook"]
EXPOSE 8080
CMD ["/opt/distribute/zeppelin-0.8.0-bin-all/bin/zeppelin.sh"]
