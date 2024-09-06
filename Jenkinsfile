pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'  // This allows Docker commands to interact with the Docker daemon
        }
    }

    environment {
        ECR_REPO = '905418166826.dkr.ecr.ap-south-1.amazonaws.com/shashi26g/ecrdevops'
        GITHUB_REPO = 'https://github.com/shashi26g/spring-boot-war-example.git'
        DOCKER_IMAGE_NAME = 'Dockerfile'
        AWS_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: "${GITHUB_REPO}", branch: 'main'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Login to ECR
                    sh 'aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO}'
                    
                    // Build Docker image
                    sh 'docker build -t ${DOCKER_IMAGE_NAME} .'
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    // Tag Docker image
                    sh 'docker tag ${DOCKER_IMAGE_NAME}:latest ${ECR_REPO}:${BUILD_ID}'
                    
                    // Push Docker image to ECR
                    sh 'docker push ${ECR_REPO}:${BUILD_ID}'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the Docker image to the Docker server
                    // Assuming you have a Docker server and it's set up to pull from ECR
                    sh 'docker run -d --name ${DOCKER_IMAGE_NAME} ${ECR_REPO}:${BUILD_ID}'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
