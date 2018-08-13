FROM openjdk:8-jre-alpine
FROM hub.c.163.com/wuxukun/maven-aliyun:3-jdk-8
FROM mysql:5.7.20
ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    JHIPSTER_SLEEP=0 \
    JAVA_OPTS="-Dspring.profiles.active=stg"
    





ENV JAVA_APP_JAR findmusic.war 
ADD target/$JAVA_APP_JAR /deployments

EXPOSE 8080
ENV JAVA_MAX_MEM_RATIO=50
ENV CONTAINER_MAX_MEMORY=314572800

