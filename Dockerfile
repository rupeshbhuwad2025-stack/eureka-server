# Maven build container 

FROM maven:3.9.16-eclipse-temurin-21 AS maven_build

COPY pom.xml /tmp/

COPY src /tmp/src/

WORKDIR /tmp/

RUN mvn package

#pull base image

FROM eclipse-temurin:21

#maintainer 
MAINTAINER rupeshbhuwad2025@gmail.com
#expose port 8861
EXPOSE 8861

#default command
CMD java -jar /target/eureka-server-0.0.1-SNAPSHOT.jar

#copy eureka-server to docker image from builder image

COPY --from=maven_build /tmp/target/eureka-server-0.0.1-SNAPSHOT.jar /target/eureka-server-0.0.1-SNAPSHOT.jar