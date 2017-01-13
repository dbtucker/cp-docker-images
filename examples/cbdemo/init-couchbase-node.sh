#!/usr/bin/env bash
#
# Clone of https://github.com/arun-gupta/docker-images/blob/master/couchbase-server/configure-node.sh
# to do simple initialization of a Couchbase Enterprise docker image

# REST port for Couchbase service 
CB_URL=http://localhost:8091

MAX_WAIT=30
curl $CB_URL/pools &> /dev/null
while [ $? -ne 0  -a  ${MAX_WAIT:-0} -gt 0 ] ; do
	sleep 2
	MAX_WAIT=$[MAX_WAIT-2]
	curl $CB_URL/pools &> /dev/null
done

curl -v -X POST $CB_URL/pools/default \
	-d memoryQuota=512 -d indexMemoryQuota=256 -d ftsMemoryQuota=256

curl -v $CB_URL/node/controller/setupServices -d services=kv%2Cn1ql%2Cindex%2Cfts

curl -v $CB_URL/settings/web \
	-d port=8091 -d username=Administrator -d password=password

curl -v -u Administrator:password -X POST $CB_URL/sampleBuckets/install \
	-d '["travel-sample"]'

curl -v -u Administrator:password -X POST $CB_URL/pools/default/buckets \
	-d 'name=tweets' -d 'authType=sasl' -d 'proxyPort=11210' -d 'ramQuotaMB=128' 

