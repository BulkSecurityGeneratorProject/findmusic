FROM hub.c.163.com/wuxukun/maven-aliyun:3-jdk-8
FROM mysql:5.7.20
ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    JHIPSTER_SLEEP=0 \
    JAVA_OPTS="-Dspring.profiles.active=stg"
    
ADD pom.xml /tmp/build/
 
ADD src /tmp/build/src
        #构建应用
RUN cd /tmp/build && mvn clean package -Dmaven.test.skip=true \
        #拷贝编译结果到指定目录
        && mv target/*.war /app.war \
        #清理编译痕迹
        && cd / && rm -rf /tmp/build
VOLUME /tmp
COPY src/main/docker/entrypoint.sh ./
# 复制数据库初始化脚本create_table.sql到/docker-entrypoint-initdb.d文件夹下
COPY sql/create_table.sql /docker-entrypoint-initdb.d

ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 8080
