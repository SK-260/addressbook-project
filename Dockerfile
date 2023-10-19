FROM tomcat:8

#RUN rm -rf /usr/local/tomcat/webapps/*
COPY ./target/addressbook.war /usr/local/tomcat/webapps/

COPY jmx_prometheus_javaagent-0.19.0.jar /data/
COPY jmx-exporter-config.yml /data/
ENV CATALINA_OPTS="-javaagent:/data/jmx_prometheus_javaagent-0.19.0.jar=8088:/data/jmx-exporter-config.yml"


EXPOSE 8080
EXPOSE 8088

CMD [ "catalina.sh", "run"]
