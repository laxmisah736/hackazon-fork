pipeline {
    agent any

    environment {
        COMPOSE_PROJECT_NAME = "hackazon"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Clone Repo') {
    steps {
        sh 'rm -rf *'
        sh 'git clone https://github.com/laxmisah736/hackazon-fork.git .'
    }
}
        stage('Verify Docker') {
            steps {
                sh 'docker --version'
                sh 'docker compose version'
            }
        }

        stage('Stop Old Containers') {
            steps {
                sh 'docker compose down || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker compose build --no-cache'
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker compose up -d'
            }
        }

        stage('Fix Permissions (Apache)') {
            steps {
                sh '''
                docker exec hackazon_app bash -c "
                chown -R www-data:www-data /var/www/html &&
                chmod -R 755 /var/www/html
                "
                '''
            }
        }

        stage('Verify Container') {
            steps {
                sh 'docker ps'
            }
        }

        stage('Check Files') {
            steps {
                sh '''
                docker exec hackazon_app bash -c "ls /var/www/html"
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment Successful! Access your app at: http://192.168.3.209:5000"
        }
        failure {
            echo "❌ Deployment Failed! Check logs above."
        }
    }
}
