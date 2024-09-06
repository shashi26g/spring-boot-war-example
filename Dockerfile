# Stage 1: Checkout
FROM ubuntu:latest as checkout
RUN apt-get update && apt-get install -y git
WORKDIR /app
RUN git clone https://github.com/shashi26g/spring-boot-war-example.git

# Stage 2: Build
FROM maven:3.8.4-openjdk-11 as build
WORKDIR /mvn
COPY --from=checkout /app/spring-boot-war-example /mvn
RUN mvn clean install

# Stage 3: Deployment
FROM artisantek/tomcat:1
COPY --from=build /mvn/target/*.war /usr/local/tomcat/webapps/
