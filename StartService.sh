#!/bin/bash
PATH=$PATH:/usr/bin
export PATH

cd .;DIRLIBS=`ls ./jars/*.jar`
echo $DIRLIBS
for i in ${DIRLIBS}
do
  if [ -z "$IPGCLIENT2_CLASSPATH" ] ; then
    IPGCLIENT2_CLASSPATH=$i
  else
   IPGCLIENT2_CLASSPATH="$i":$IPGCLIENT2_CLASSPATH
  fi
done

clear
echo java -cp "$IPGCLIENT2_CLASSPATH" com.interblocks.ipay.client2.PHPService $*

java -cp "$IPGCLIENT2_CLASSPATH" com.interblocks.ipay.client2.PHPService $*
