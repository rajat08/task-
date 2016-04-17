#!/bin/sh

#we need to startup the server and the topbeat service
#rajat/Downloads/elasticsearch-2.3.1/bin/./elasticsearch 

#/etc/init.d/topbeat start
#local host running on port 9200,index is topbeat-*

#list out the information related to each process and store in file prc.txt
curl -XPOST 'localhost:9200/topbeat-*/_search?pretty' -d'
{
"query":{"match":{"type":"process"}}
}
'>prc.txt

#list out the information related to cpu(usage and memory etc) and store in file sys.txt
curl -XPOST 'localhost:9200/topbeat-*/_search?pretty' -d'
{
"query":{"match":{"type":"system"}}
}
'>sys.txt

#List out the information related to filesystem statistic
curl -XPOST 'localhost:9200/topbeat-*/_search?pretty' -d'
{
"query":{"match":{"type":"filesystem"}}
}
'>file.txt




