pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '905418166826'
        AWS_REGION = 'ap-south-1'
        IMAGE_REPO_NAME = 'shashi26g/ecrdevops'
        IMAGE_TAG = '1'
        ECR_REPO_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {

        stage('Checkout') {
            steps {
                // Checkout the new GitHub repository
                git branch: 'main', url: 'https://github.com/shashi26g/spring-boot-war-example.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${ECR_REPO_URI}:${IMAGE_TAG} ."
                }
            }
        }

        stage('ECR Login') {
            steps {
                script {
                    // ECR login using AWS CLI
                    sh '''
                        aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URI}
                    '''
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    // Push Docker image to ECR
                    sh "docker push ${ECR_REPO_URI}:${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Stop and remove any existing container with the same name
                    sh "docker stop ecrdevops || true && docker rm ecrdevops || true"

                    // Run new container
                    sh "docker run -itd --name ecrdevops -p 8080:8080 ${ECR_REPO_URI}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        always {
            script {
                // Cleanup unused Docker images
                sh "docker system prune -f"
            }
        }
    }
}
