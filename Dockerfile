FROM maven:3.6.0-jdk-8 as build

WORKDIR /opt/syslog-server

COPY . .

RUN mvn compile -DskipTests=true \
	&& mvn package -DskipTests=true


FROM java:openjdk-8-jre

WORKDIR /opt

COPY --from=build /opt/syslog-server/target/syslog-server.war .

EXPOSE 8080

CMD java -jar syslog-server.jar
