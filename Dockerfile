FROM maven:3.6.0-jdk-8 as build

WORKDIR /opt/nmslog-manager

COPY . .

RUN mvn compile -DskipTests=true \
	&& mvn package -DskipTests=true


FROM tomcat:latest

WORKDIR /opt

RUN apt-get -y update

COPY --from=build /opt/nmslog-manager/target/nmslog-manager.war /usr/local/tomcat/webapps/

EXPOSE 8080

