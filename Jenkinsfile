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

        stage('Tag Image') {
            steps {
                sh 'docker tag taskflow-ci-web ghcr.io/talbenhamo/taskflow:${BUILD_NUMBER}'
                sh 'docker tag taskflow-ci-web ghcr.io/talbenhamo/taskflow:latest'
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'github-registry',
                        usernameVariable: 'GHCR_USER',
                        passwordVariable: 'GHCR_TOKEN'
                    )
                ]) {
                    sh '''
                        echo "$GHCR_TOKEN" | docker login ghcr.io \
                            -u "$GHCR_USER" --password-stdin

                        docker push ghcr.io/talbenhamo/taskflow:${BUILD_NUMBER}
                        docker push ghcr.io/talbenhamo/taskflow:latest
                    '''
                }
            }
        }
    }

    post {
        always {
            sh 'docker compose -p taskflow-ci down -v || true'
            sh 'docker logout ghcr.io || true'
        }
    }
}
