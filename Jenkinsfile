pipeline {
    agent any
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            } }
        stage('Clone Repo') {
            steps {
                git 'https://github.com/laxmisah736/hackazon-fork.git'
            }}
        stage('Stop Old Containers') {
            steps {
                sh 'docker-compose down || true'
            }}
        stage('Build Docker Image') {
            steps {
                sh 'docker-compose build'
            }}
        stage('Run Container') {
            steps {
                sh 'docker-compose up -d'
            }}
        stage('Verify') {
            steps {
                sh 'docker ps'
            }}   }
}
