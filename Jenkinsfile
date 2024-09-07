pipeline {
    agent {
label 'docker'

}
    tools {
        maven 'maven'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', credentialsId: 'github', url: 'https://github.com/shashi26g/spring-boot-war-example.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Push') {
            steps {
                echo 'This is Push Stage'
            }
        }
        stage('Deploy') {
            steps {
               echo 'This is Deploy Stage'
            }
        }
    }
}
