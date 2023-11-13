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
                sh 'npm cache clean --force && rm -rf node_modules && rm package-lock.json && npm install'
            }
        }

        stage("Tests"){
            steps {
                sh 'npm run test-jenkins'
            }
        }
        stage("Building Image"){
            steps {
                script {
                    dockerImage = docker.build imageName
                }
            }
        }
        stage("Deploy Image"){
            steps {
                script {
                    docker.withRegistry("https://registry.hub.docker.com", 'dockerhub-creds'){
                        dockerImage.push("${env.BUILD_NUMBER}")
                    }
                }
            }
        }
    }
}
