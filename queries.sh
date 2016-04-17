#!/bin/sh
#get all the running processes

curl -XPOST 'localhost:9200/topbeat-*/_search?pretty' -d'
{
"query":{
"bool":{
"must":[
{ "match":{"type":"process"}},
{ "match":{ "proc.state":"running"}}]}}}'


#sort running processes by memory they use

curl -XPOST 'localhost:9200/topbeat-*/_search?pretty' -d'
{
"query":{"match":{"proc.state":"running"}},
"sort":{"proc.mem.size":{"order":"desc"}}
}'


#average swap memory in use 

curl -XPOST 'localhost:9200/topbeat-*/_search?pretty' -d'
{
"size":0,
"aggs":{
"average_balance":{
"avg":{"field":"swap.used"}}}
}'

#filesystem grouped by device names and aggregated over average files 

curl -XPOST 'localhost:9200/topbeat-*/_search?pretty' -d'
{
"size":0,
"aggs":{
"group_by_state":{
"terms":{
"field":"fs.device_name"},
"aggs":{ "averge_total":{"avg":{"field":"fs.total"}}}}}}}'




