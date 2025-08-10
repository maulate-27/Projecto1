#! /bin/bash

javac -d bin -cp "lib/*" $(find src/main/java -name "*.java")
