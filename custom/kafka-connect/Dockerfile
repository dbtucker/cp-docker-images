
FROM confluentinc/cp-kafka-connect:3.1.1

MAINTAINER partner-support@confluent.io

RUN echo "===> Installing extra O/S components ..." \
    && apt-get -qq update \
	&& apt-get install -y \
		unzip 

RUN echo "===> Installing Replicator ..." \
     && apt-get install -y \
        confluent-kafka-connect-replicator=${CONFLUENT_VERSION}-${CONFLUENT_DEB_VERSION} 

ENV DM_RELEASE_REPO https://github.com/datamountaineer/stream-reactor/releases/download
ENV DM_STREAM_PACKAGE stream-reactor
ENV DM_STREAM_RELEASE_TAG  0.2.2
ENV DM_STREAM_VERSION 0.2
ENV DM_STREAM_CP_VERSION 3.0.0
ENV DM_STREAM_TARFILE ${DM_STREAM_PACKAGE}-${DM_STREAM_VERSION}-${DM_STREAM_CP_VERSION}-all.tar.gz
ENV DM_STREAM_CONNECTORS cassandra hbase redis
ENV DM_CONNECT_DIR kafka-connect-datamountaineer
ENV DM_LOCAL_TARGET include/connectors/${DM_STREAM_PACKAGE}-${DM_STREAM_VERSION}-${DM_STREAM_CP_VERSION}

#		To download and install
# RUN mkdir /usr/share/java/${DM_CONNECT_DIR} \
#	&& curl -k -SL "${DM_RELEASE_REPO}/v${DM_STREAM_RELEASE_TAG}/${DM_STREAM_TARFILE}" \
#    		| tar -xzf - -C /usr/share/java/ \
#	&& for c in ${DM_STREAM_CONNECTORS} ; do mv /usr/share/java/${DM_STREAM_PACKAGE}-*/libs/kafka-connect-${c}-* /usr/share/java/${DM_CONNECT_DIR}; done  \
#	&& rm -rf /usr/share/java/stream-reactor-release-*

#		To retrieve from local download (no loop possible)
# RUN mkdir /usr/share/java/${DM_CONNECT_DIR} 
# COPY ${DM_LOCAL_TARGET}/libs/kafka-connect-cassandra-* /usr/share/java/${DM_CONNECT_DIR}
# COPY ${DM_LOCAL_TARGET}/libs/kafka-connect-hbase-* /usr/share/java/${DM_CONNECT_DIR}
# COPY ${DM_LOCAL_TARGET}/libs/kafka-connect-redis-* /usr/share/java/${DM_CONNECT_DIR}


# ENV DYNAMODB_BUILD_TARGET ../../../../connectors/kafka-connect-dynamodb/target
ENV DYNAMODB_BUILD_TARGET include
ENV DYNAMODB_PACKAGE ${DYNAMODB_BUILD_TARGET}/kafka-connect-dynamodb-0.3.0-SNAPSHOT-package

COPY $DYNAMODB_PACKAGE/share/java/kafka-connect-dynamodb  /usr/share/java/kafka-connect-dynamodb
COPY $DYNAMODB_PACKAGE/share/doc/kafka-connect-dynamodb  /usr/share/doc/kafka-connect-dynamodb

# ENV SIMULATOR_BUILD_TARGET ../../../../jcustenborder/kafka-connect-simulator/target
ENV SIMULATOR_BUILD_TARGET include
ENV SIMULATOR_PACKAGE ${SIMULATOR_BUILD_TARGET}/kafka-connect-simulator-1.1-SNAPSHOT-package

COPY $SIMULATOR_PACKAGE/etc/kafka-connect-simulator  /etc/kafka-connect-simulator
COPY $SIMULATOR_PACKAGE/share/java/kafka-connect-simulator  /usr/share/java/kafka-connect-simulator
COPY $SIMULATOR_PACKAGE/share/doc/kafka-connect-simulator  /usr/share/doc/kafka-connect-simulator

# ENV COUCHBASE_BUILD_TARGET ../../../../connectors/kafka-connect-couchbase/target
ENV COUCHBASE_BUILD_TARGET include
ENV COUCHBASE_PACKAGE ${COUCHBASE_BUILD_TARGET}/kafka-connect-couchbase-3.1.0-package

COPY $COUCHBASE_PACKAGE/share/java/kafka-connect-couchbase  /usr/share/java/kafka-connect-couchbase
# COPY $COUCHBASE_PACKAGE/share/doc/kafka-connect-couchbase  /usr/share/doc/kafka-connect-couchbase

# ENV TWITTER_BUILD_TARGET ../../../../connectors/kafka-connect-couchbase/target
ENV TWITTER_BUILD_TARGET include
ENV TWITTER_PACKAGE ${TWITTER_BUILD_TARGET}/kafka-connect-twitter-1.2-SNAPSHOT-package

COPY $TWITTER_PACKAGE/share/java/kafka-connect-twitter  /usr/share/java/kafka-connect-twitter
COPY $TWITTER_PACKAGE/share/doc/kafka-connect-twitter  /usr/share/doc/kafka-connect-twitter

RUN echo "===> Cleaning up ..."  \
     && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/*


CMD ["/etc/confluent/docker/run"]

