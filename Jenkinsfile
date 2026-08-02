pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Validate') {
            steps {
                sh 'python3 -m py_compile app/app.py'
            }
        }

        stage('Build') {
            steps {
                sh 'docker compose -p taskflow-ci build'
            }
        }

        stage('Test') {
            steps {
                sh 'docker compose -p taskflow-ci up -d'
                sh 'docker compose -p taskflow-ci exec -T web sh -c "PYTHONPATH=/app pytest -v /tests"'
            }
        }

        stage('Health Check') {
            steps {
                sh './scripts/check-taskflow.sh'
            }
        }
    }

    post {
        always {
            sh 'docker compose -p taskflow-ci down -v || true'
        }
    }
}
