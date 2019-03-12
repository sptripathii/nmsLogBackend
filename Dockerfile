FROM maven:3.6.0-jdk-8 as build

WORKDIR /opt/nmslog-manager

COPY . .

RUN mvn compile -DskipTests=true \
	&& mvn package -DskipTests=true


FROM java:openjdk-8-jre

WORKDIR /opt

COPY --from=build /opt/nmslog-manager/target/nmslog-manager.war .

EXPOSE 8080

CMD java -jar syslog-server.jar
