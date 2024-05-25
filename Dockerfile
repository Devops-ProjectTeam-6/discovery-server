ARG BUILD_HOME=/discovery-server
FROM gradle:jdk17 as build-image

ARG BUILD_HOME
ENV APP_HOME=$BUILD_HOME
WORKDIR $APP_HOME

COPY --chown=gradle:gradle build.gradle settings.gradle $APP_HOME/
COPY --chown=gradle:gradle src $APP_HOME/src

RUN gradle --no-daemon build

FROM openjdk:17-jdk-alpine3.14

ARG BUILD_HOME
ENV APP_HOME=$BUILD_HOME
COPY --from=build-image $APP_HOME/build/libs/discovery-server-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8761

ENTRYPOINT ["java", "-jar", "app.jar"]
