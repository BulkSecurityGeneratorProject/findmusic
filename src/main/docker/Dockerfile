FROM openjdk:8-jre-alpine
FROM hub.c.163.com/wuxukun/maven-aliyun:3-jdk-8
FROM mysql:5.7.20

ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    JHIPSTER_SLEEP=0 \
    JAVA_OPTS="-Dspring.profiles.active=stg" \
    DOCKER_HOST="http://192.168.160.189:2375"

# Add a jhipster user to run our application so that it doesn't need to run as root
RUN adduser -D -s /bin/sh jhipster
WORKDIR /home/jhipster

RUN mvn clean package -Dmaven.skip.test=true \
        #拷贝编译结果到指定目录
        && mv target/*.war /app.war
ADD *.war app.war

cd ./src/main/docker
ADD entrypoint.sh entrypoint.sh
RUN chmod 755 entrypoint.sh && chown jhipster:jhipster entrypoint.sh
USER jhipster


ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 8080

