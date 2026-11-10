pipeline {
    agent any

    environment {
        // Path to Docker CLI on Windows
        PATH = "C:\\Users\\ADMIN\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin;${env.PATH}"
        DOCKER_HUB_USER = 'suryadocker638253'
        IMAGE_NAME = 'suryadocker638253/hello-world-app'
        REGISTRY_CREDS = credentials('docker-hub-credentials')
    }

    stages {
        stage('1. Checkout Code') {
            steps {
                echo '📥 Checking out source code from GitHub...'
                checkout scm
            }
        }

        stage('2. Build Tiny Image') {
            steps {
                echo '🐳 Building lightweight Docker Image...'
                bat 'docker build -t %IMAGE_NAME%:latest -t %IMAGE_NAME%:%BUILD_NUMBER% .'
            }
        }

        stage('3. Push to Docker Hub') {
            steps {
                echo '📦 Pushing tiny layer to Docker Hub...'
                bat 'docker login -u %REGISTRY_CREDS_USR% -p %REGISTRY_CREDS_PSW%'
                bat 'docker push %IMAGE_NAME%:latest'
                bat 'docker push %IMAGE_NAME%:%BUILD_NUMBER%'
            }
        }

        stage('4. Pull from Docker Hub & Run Container') {
            steps {
                echo '📥 Pulling latest verified image from Docker Hub...'
                bat 'docker pull %IMAGE_NAME%:latest'
                echo '🚀 Deploying container on port 8090 from pulled image...'
                bat 'docker rm -f hello-app || exit 0'
                bat 'docker run -d --name hello-app -p 8090:80 %IMAGE_NAME%:latest'
            }
        }

        stage('5. Health Check') {
            steps {
                echo '🩺 Testing live website response...'
                bat 'curl -I http://localhost:8090'
            }
        }
    }

    post {
        success {
            echo '🎉 CONGRATULATIONS! Hello World is live at http://localhost:8090'
        }
        failure {
            echo '❌ Pipeline failed! Please check logs.'
        }
    }
}
