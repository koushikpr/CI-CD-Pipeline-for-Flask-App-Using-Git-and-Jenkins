#!bin/bash


echo "Cloning Repository"

git clone https://github.com/koushikpr/CI-CD-Pipeline-for-Flask-App-Using-Git-and-Jenkins/

echo "Docker Image Build Build"

docker build . -t 030902/flaskk

echo " Docker composing " 

docker-compose up

