FROM tomcat:9-jdk11-corretto

COPY target/addressbook.war /usr/local/tomcat/webapps

EXPOSE 8080

CMD [ "catalina.sh", "run" ]