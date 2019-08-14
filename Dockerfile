FROM openjdk:8-alpine as build-stage

RUN apk add maven \
    && mvn -v \
    && mkdir /app

COPY . /app/

# build the package
RUN cd /app \
    && mvn install:install-file -Dfile=lib/ojdbc8.jar -DgroupId=com.oracle.jdbc -DartifactId=ojdbc8 -Dversion=18.3 -Dpackaging=jar \
    && mvn clean package

FROM oracle/graalvm-ce:latest

WORKDIR /app

COPY --from=build-stage /app/target/travel-agency-flight-0.0.1-SNAPSHOT.jar /app/

EXPOSE 8001

CMD ["java", "-jar", "travel-agency-flight-0.0.1-SNAPSHOT.jar"]
