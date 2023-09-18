FROM docker.elastic.co/elasticsearch/elasticsearch:8.8.1

# same dirctory with elastic cloud
USER root
ENV ES_PATH_CONF="/app/config"

RUN mkdir -p $ES_PATH_CONF \
    && chown elasticsearch:elasticsearch $ES_PATH_CONF \
    && cp -r /usr/share/elasticsearch/config/* $ES_PATH_CONF

# Don't know why but since 16.2 `ENV discovery.type=single-node` doesn't work
# ENV discovery.type=single-node
RUN echo "discovery.type: single-node" >> $ES_PATH_CONF/elasticsearch.yml

# eskeeperがコンテナ内からアクセスすると落ちるので設定
RUN echo "xpack.security.enabled: false" >> $ES_PATH_CONF/elasticsearch.yml

#
# setup plugin and dictionaries
#
COPY /sudachi/* $ES_PATH_CONF/sudachi/

RUN bin/elasticsearch-plugin install https://github.com/WorksApplications/elasticsearch-sudachi/releases/download/v3.1.0/elasticsearch-8.8.1-analysis-sudachi-3.1.0.zip

# FIXME: to more smart waiting
USER elasticsearch