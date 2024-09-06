pipeline {
    agent {
label 'docker'

}
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/shashi26g/spring-boot-war-example.git'
            }
        }
        stage('Build') {
                    image 'docker:latest'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
            }
            steps {
                script {
                    sh "docker build -t 905418166826.dkr.ecr.ap-south-1.amazonaws.com/shashi26g/ecrdevops:1 ."
                }
            }
        }
        stage('Push to ECR') { 
                    image 'docker:latest'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
            steps {
                script {
                    sh "docker push 905418166826.dkr.ecr.ap-south-1.amazonaws.com/shashi26g/ecrdevops:1"
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
