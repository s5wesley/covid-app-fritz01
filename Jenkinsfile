pipeline {
    agent any

    environment {
        APP_NAME = 'covid-app'
        DOCKER_IMAGE = 'bulawesley/covid:v1.0'
        DOCKER_REGISTRY = 'bulawesley'
        DOCKER_CONTAINER_NAME = 'covid-app-container'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the code from the source repository
                    checkout scm
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER}.2.0 .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to the Docker registry
                    sh 'docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER}.2.0 ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${BUILD_NUMBER}.2.0'
                    sh 'docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${BUILD_NUMBER}.2.0'
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Remove the old container if it exists
                    sh """
                    if [ \$(docker ps -q -f name=${DOCKER_CONTAINER_NAME}) ]; then
                        docker stop ${DOCKER_CONTAINER_NAME}
                        docker rm ${DOCKER_CONTAINER_NAME}
                    fi
                    """

                    // Run the new container
                    sh """
                    docker run -d --name ${DOCKER_CONTAINER_NAME} -p 80:80 ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${BUILD_NUMBER}.2.0
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment succeeded!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
