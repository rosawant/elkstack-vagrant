#!/bin/sh

#Configure the IP addresses
IP=("IP1" "IP2" "IP3")

#Configure the hostnames
hostname=("HOSTNAME1" "HOSTNAME2" "HOSTNAME3")

while true
do
   message=""
   flag=0
   for (( i=0; i < ${#IP[@]}; i++ ))
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

      #Configure the E-Mail addresses
      echo $message | mail -s "Pulse - Elasticssearch Server Down" EMailID1 EMailID2
      echo $message
   fi

   #Time duration between the monitoring. 10m represents 10 minutes
   sleep 10m
done