#stage 1 - Build
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN apt-get update && apt-get install -y maven && mvn clean package -DskipTests

#stage2 - Runtime
FROM eclipse-temurin:21-jre AS runtime

WORKDIR /app

COPY --from=build /app/target/firstproject-1.0-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
