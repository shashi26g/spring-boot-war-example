pipeline {
    agent {
label 'docker'

}

    environment {
        DOCKER_IMAGE_NAME = 'my-docker-image'
        ECR_REPOSITORY_URL = '905418166826.dkr.ecr.ap-south-1.amazonaws.com/shashi26g/ecrdevops'
        ECR_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout source code
                git 'https://github.com/shashi26g/spring-boot-war-example.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t ${DOCKER_IMAGE_NAME} .'
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    // Log in to ECR before pushing the image to avoid expired token issue
                    sh '''
                    aws ecr get-login-password --region ${ECR_REGION} | docker login --username AWS --password-stdin ${ECR_REPOSITORY_URL}
                    docker tag ${DOCKER_IMAGE_NAME} ${ECR_REPOSITORY_URL}/${DOCKER_IMAGE_NAME}:latest
                    docker push ${ECR_REPOSITORY_URL}/${DOCKER_IMAGE_NAME}:latest
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the Docker image to your Docker server
                    sh '''
                    docker pull ${ECR_REPOSITORY_URL}/${DOCKER_IMAGE_NAME}:latest
                    docker stop my-container || true
                    docker rm my-container || true
                    docker run -d --name my-container ${ECR_REPOSITORY_URL}/${DOCKER_IMAGE_NAME}:latest
                    '''
                }
            }
        }
    }
    
    post {
        failure {
            echo 'Pipeline failed'
        }
        success {
            echo 'Pipeline succeeded'
        }
    }
}
