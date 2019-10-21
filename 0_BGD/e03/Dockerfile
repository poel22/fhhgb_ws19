FROM openjdk:8

WORKDIR /notes_app

COPY ./build/ . 

RUN ./gradlew build

CMD java -jar build/libs/NotesService-0.1.0.jar
