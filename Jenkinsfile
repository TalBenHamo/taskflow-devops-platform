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
                sh 'ansible-playbook ansible/deploy.yml --syntax-check'
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
                script {
                    env.GIT_SHORT_SHA = sh(
                        script: 'git rev-parse --short HEAD',
                        returnStdout: true
                    ).trim()
                }

                sh '''
                    docker tag taskflow-ci-web ghcr.io/talbenhamo/taskflow:${BUILD_NUMBER}
                    docker tag taskflow-ci-web ghcr.io/talbenhamo/taskflow:${GIT_SHORT_SHA}
                    docker tag taskflow-ci-web ghcr.io/talbenhamo/taskflow:latest
                '''
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
                        docker push ghcr.io/talbenhamo/taskflow:${GIT_SHORT_SHA}
                        docker push ghcr.io/talbenhamo/taskflow:latest
                    '''
                }
            }
        }

        stage('Deploy to AWS') {
            steps {
                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'taskflow-aws-ssh',
                        keyFileVariable: 'ANSIBLE_PRIVATE_KEY',
                        usernameVariable: 'ANSIBLE_REMOTE_USER'
                    )
                ]) {
                    sh '''
                        cd ansible
                        ansible-playbook deploy.yml \
                            --private-key "$ANSIBLE_PRIVATE_KEY" \
                            -u "$ANSIBLE_REMOTE_USER"
                    '''
                }
            }
        }

        stage('Deployment Health Check') {
            steps {
                sh '''
                    curl --fail \
                        --retry 12 \
                        --retry-delay 5 \
                        http://18.117.242.253:5000/health
                '''
            }
        }
    }

    post {
        always {
            sh 'docker compose -p taskflow-ci down -v || true'
            sh 'docker logout ghcr.io || true'
        }

        success {
            echo 'TaskFlow build, test, publish and deployment completed successfully.'
        }

        failure {
            echo 'TaskFlow pipeline failed. Review the failed stage and console output.'
        }
    }
}
