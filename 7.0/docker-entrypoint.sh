#!/bin/bash

[[ $DEBUG ]] &&  set -x

# detect ENABLE_APM env
if [ "$ENABLE_APM" == "true" ];then
    COLLECTOR_IP=${COLLECTOR_IP:-127.0.0.1}
    sed -i "2 a. /usr/local/tomcat/bin/pinpoint-agent.sh" /usr/local/tomcat/bin/catalina.sh
    sed -i -r -e "s/(profiler.collector.ip)=.*/\1=${COLLECTOR_IP}/" \
              -e "s/#(profiler.applicationservertype=TOMCAT)/\1/" /usr/local/pinpoint-agent/pinpoint.config
fi


# redis sersion
if [ "$REDIS_SESSION" == "true" ];then
    sed -i 's#</Context>##' /usr/local/tomcat/conf/context.xml

cat >>  /usr/local/tomcat/conf/context.xml << END
<Valve className="com.orangefunction.tomcat.redissessions.RedisSessionHandlerValve" />
<Manager className="com.orangefunction.tomcat.redissessions.RedisSessionManager"
             host="127.0.0.1" 
             port="6379" 
             database="0" 
             maxInactiveInterval="60"  />
</Context>

END

fi

exec $@