pipeline {
    agent any
    stages {
        stage("Pull Repository") {
            steps {
                git branch: 'main', url: 'https://github.com/koushikpr/CI-CD-Pipeline-for-Flask-App-Using-Git-and-Jenkins'
            }
        }
        stage("Build the DockerImage") {
            steps {
                bat 'docker build . -t 030902/flaskaaa'
            }
        }
        stage("Start the Container") {
            steps {
                bat 'docker compose up -d'
            }
        }
        stage("Push Container to DockerHub") {
            steps {
                bat 'docker push 030902/flaskaaa'
            }
        }
        stage("Add Kubernetes files") {
            steps {
                bat 'kubectl apply -f Kubernetes/.'
            }
        }
        stage("Check all Container Status") {
            steps {
                bat 'kubectl get all'
            }
        }
    }
}
