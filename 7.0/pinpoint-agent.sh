CATALINA_OPTS="$CATALINA_OPTS -javaagent:$PINPOINT_AGENT_PATH/pinpoint-bootstrap-${PINPOINT_AGETN_VERSION}.jar"
CATALINA_OPTS="$CATALINA_OPTS -Dpinpoint.agentId=${SERVICE_ID:-$AGENT_ID}"
CATALINA_OPTS="$CATALINA_OPTS -Dpinpoint.applicationName=${APP_NAME:-$SERVICE_NAME}"