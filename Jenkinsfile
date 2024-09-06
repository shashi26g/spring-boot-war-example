pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/shashi26g/spring-boot-war-example.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    // Use a Docker container to build the image
                    docker.image('docker:latest').inside {
                        sh "docker build -t 905418166826.dkr.ecr.ap-south-1.amazonaws.com/shashi26g/ecrdevops:1 ."
                    }
                }
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    // Use a Docker container to push the image
                    docker.image('docker:latest').inside {
                        sh "docker push 905418166826.dkr.ecr.ap-south-1.amazonaws.com/shashi26g/ecrdevops:1"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh "docker run -itd -p 8080:8080 905418166826.dkr.ecr.ap-south-1.amazonaws.com/shashi26g/ecrdevops:1"
                }
            }
        }
    }
}
