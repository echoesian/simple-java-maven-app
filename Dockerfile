FROM maven
RUN mkdir /app
WORKDIR /app

COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package

FROM tomcat
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar /usr/local/tomcat/webapps
EXPOSE 8080
