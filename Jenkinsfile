pipeline {
    agent any
    tools { nodejs "node"}
    environment {
        imageName = "techwithgio/react-app"
        registryCredential = 'techwithgio'
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
