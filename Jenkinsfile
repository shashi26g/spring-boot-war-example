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
                    // Log in to ECR
                    sh 'aws ecr get-login-password --region ${ECR_REGION} | docker login --username AWS --password-stdin ${ECR_REPOSITORY_URL}'
                    
                    // Tag the Docker image
                    sh 'docker tag ${DOCKER_IMAGE_NAME} ${ECR_REPOSITORY_URL}/${DOCKER_IMAGE_NAME}:latest'

                    // Push the Docker image to ECR
                    sh 'docker push ${ECR_REPOSITORY_URL}/${DOCKER_IMAGE_NAME}:latest'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the Docker image to your Docker server
                    // This is a basic example and might need adjustments based on your Docker server setup
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
            // Actions to perform on failure
            echo 'Pipeline failed'
        }
        success {
            // Actions to perform on success
            echo 'Pipeline succeeded'
        }
    }
}
