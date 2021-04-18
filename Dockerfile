FROM maven:3-openjdk-8
WORKDIR /OMS
RUN git clone https://github.com/VladTvardovskyi/oms2.git /OMS
RUN mvn clean 
RUN mvn package

FROM tomcat:9.0.43-jdk8
COPY --from=0 /OMS/target/OMS.war /usr/local/tomcat/webapps/
EXPOSE 8081 3000 8080
#EXPOSE 8080 
