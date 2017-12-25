FROM centos:7
MAINTAINER lx,simolx@163.com
ENV TZ Asia/Shanghai
ENV LC_ALL en_US.UTF-8
ENV JAVA_HOME=/opt/jdk1.8.0_151 \
    PATH=/opt/anaconda3/bin:$JAVA_HOME/bin:$PATH \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN /bin/cp -f /usr/share/zoneinfo/$TZ /etc/localtime
RUN yum -y update \
    && yum install -y which openssh openssh-clients openssh-server bzip2 vim sudo \
    && yum clean all \
    && rm -rf /var/cache/yum
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
# install jdk
RUN curl -O -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz \
    && tar -xzf jdk-8u151-linux-x64.tar.gz -C /opt && \
    rm -f jdk-8u151-linux-x64.tar.gz
# install anaconda3
RUN curl -O https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh && \
    bash Anaconda3-5.0.1-Linux-x86_64.sh -b -f -p /opt/anaconda3 && \
    rm -f Anaconda3-5.0.1-Linux-x86_64.sh
# install apache zeppelin
RUN curl -O http://www-us.apache.org/dist/zeppelin/zeppelin-0.7.3/zeppelin-0.7.3-bin-all.tgz && \
    tar -xzf zeppelin-0.7.3-bin-all.tgz -C /opt && \
    rm -f zeppelin-0.7.3-bin-all.tgz && \
    cp /opt/zeppelin-0.7.3-bin-all/conf/zeppelin-env.sh.template /opt/zeppelin-0.7.3-bin-all/conf/zeppelin-env.sh && \
    cp /opt/zeppelin-0.7.3-bin-all/conf/zeppelin-site.xml.template /opt/zeppelin-0.7.3-bin-all/conf/zeppelin-site.xml
RUN conda update -y conda && \
    conda update -y --all && \
    python -m nltk.downloader all -d /opt/nltk_data
VOLUME ["/opt/zeppelin-0.7.3-bin-all/notebook"]
EXPOSE 8080
CMD ["/opt/zeppelin-0.7.3-bin-all/bin/zeppelin.sh"]
