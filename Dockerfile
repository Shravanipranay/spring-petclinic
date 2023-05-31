FROM alpine/git AS vcs
RUN cd / && git clone https://github.com/spring-projects/spring-petclinic.git && \
    pwd && ls /spring-petclinic

FROM maven:3-amazoncorretto-17 AS builder
COPY --from=vcs /spring-petclinic /spring-petclinic
RUN ls /spring-petclinic 
RUN cd /spring-petclinic && mvn package

FROM amazoncorretto:17-alpine-jdk
WORKDIR /spc
COPY --from=builder /spring-petclinic/target/spring-petclinic-*.jar /spc/spring-petclinic
EXPOSE 8080
CMD ["java" , "-jar" , "springpetclinic-*.jar"]


