#!/bin/sh

#Configure the IP addresses
IP="192.168.254.12 192.168.254.13"

#Configure the hostnames
HOSTNAMES="master agent"

message=""
flag=0
for i in $IP
do
   echo $i
   response=$(curl ${IP[$i]}:9200/_cluster/health)
   if [[ ! "$response" =~ "green" ]]; then
   flag=1
      if [[ "$response" =~ "red" ]]; 
      then
         message+="Elasticsearch Server ${hostname[$i]}(${IP[$i]}) is down\n"
      elif [[ "$response" =~ "yellow" ]]; then
         message+="Elasticsearch  server ${hostname[$i]}(${IP[$i]}) shards are allocating\n"
      elif [[ "$response" == "" ]]; then
         message+="Elasticsearch process is not running in ${hostname[$i]}(${IP[$i]})\n"
      fi
   fi
done

if [ $flag == 1 ]; then
   echo "Sending Mail"
   echo $message | mail -s "Elasticssearch Server Down" root@localhost.com   
fi

