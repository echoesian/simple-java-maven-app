# setup working directory
FROM maven AS build
RUN mkdir /app
WORKDIR /app

# maven build
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package

# deploy to tomcat
FROM tomcat
RUN rm -rf /usr/local/tomcat/webapps/
COPY --from=build app/target/simple-app-1.0-SNAPSHOT.jar /usr/local/tomcat/webapps

# expose port
EXPOSE 80
