FROM openjdk:8-alpine

RUN apk add maven \
    && mvn -v \
    && mkdir -p /app/omc

COPY . /app/

WORKDIR /app

# build the package
RUN mvn install:install-file -Dfile=lib/ojdbc8.jar -DgroupId=com.oracle.jdbc -DartifactId=ojdbc8 -Dversion=18.3 -Dpackaging=jar \
    && mvn clean package

# apm
RUN unzip lib/APM.zip -d ./omc \
    && mv lib/registrationKey.txt ./omc \
    && cd omc \
    && sh ProvisionApmJavaAsAgent.sh -d . -h do-not-use -no-wallet -no-prompt -regkey-file registrationKey.txt \
    && echo "oracle.apmaas.agent.appServer.classifications=OMC_SAMPLE" >> ${APM_PROP_FILE:-"/app/omc/apmagent/config/AgentStartup.properties"} \
    && cd -

ENV APM_PROP_FILE /app/omc/apmagent/config/AgentStartup.properties
ENV JAVA_OPTS ${JAVA_OPTIONS} -javaagent:/app/omc/apmagent/lib/system/ApmAgentInstrumentation.jar

EXPOSE 8001

ENTRYPOINT exec java $JAVA_OPTS -jar target/travel-agency-flight-0.0.1-SNAPSHOT.jar
