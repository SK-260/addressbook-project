FROM tomcat

RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/addressbook.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD [ "catalina.sh", "run" ]