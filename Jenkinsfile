pipeline {
    agent any
    environment {
        registry = "030902/flaskapp1"
        registryCredential = 'dockerhub_id'
        dockerImage = ''
    }
    stages {
        stage("Pull Repository") {
            steps {
                git branch: 'main', url: 'https://github.com/koushikpr/CI-CD-Pipeline-for-Flask-App-Using-Git-and-Jenkins'
            }
        }
        stage("Build the DockerImage") {
            steps {
                script {
                    dockerImage = docker.build registry 
                }
            }
        }
        stage("Start the Container") {
            steps {
                sh 'docker-compose up -d'
            }
        }
        stage("Push the Container") {
            steps {
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com' , registryCredential) {
                        dockerImage.push("latest")
                    }
                }
            }
        }
       
        
    }
}
