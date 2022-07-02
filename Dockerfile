FROM openjdk:11-jre-slim

WORKDIR /app

COPY ./build/libs/*.jar ./api-server.jar

CMD java -jar -Dserver.port=${PORT} -Dspring.profiles.active=${PROFILE} ./api-server.jar