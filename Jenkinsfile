pipeline {
    agent any
    tools { nodejs "node"}
    environment {
        imageName = "jrodriguezdiazz/jenkins-example-exercise"
        registryCredential = 'jrodriguezdiazz'
        dockerImage = ''
    }
    stages {
        stage("Install Dependencies"){
            steps{
                sh 'npm install'
            }
        }

        stage("Tests"){
            steps {
                sh 'npm run test-jenkins'
            }
        }
        stage("Building Image") {
            steps {
                script {
                    dockerImage = docker.build(imageName)
                    echo "Built Image: ${dockerImage.id}"
                }
            }
        }

        stage("Deploy Image") {
            steps {
                script {
                    def imageTag = "${env.BUILD_NUMBER}"
                    docker.withRegistry("https://registry.hub.docker.com", 'dockerhub-creds') {
                        dockerImage.push(imageTag)
                    }
                    echo "Image deployed: ${imageName}:${imageTag}"
                    echo "URL: https://registry.hub.docker.com/r/${imageName}:${imageTag}"
                }
            }
        }
        stage("Get Container IP") {
            steps {
                script {
                    def containerId = sh(script: "docker ps -q -f ancestor=${imageName}", returnStdout: true).trim()
                    if (containerId) {
                        def containerIp = sh(script: "docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${containerId}", returnStdout: true).trim()
                        echo "Container IP: ${containerIp}"
                    } else {
                        echo "No running containers found for image ${imageName}"
                    }
                }
            }
        }
    }
}
