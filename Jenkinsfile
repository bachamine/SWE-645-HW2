pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'bachamine/gmu-survey' 
        KUBECONFIG_CREDENTIAL_ID = 'kubeconfig-id'                    
        DOCKER_CREDENTIAL_ID = 'docker-pass'                  
        K8S_NAMESPACE = 'default'                                  
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/bachamine/SWE-645-HW2'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(env.DOCKER_IMAGE)
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', env.DOCKER_CREDENTIAL_ID) {
                        docker.image(env.DOCKER_IMAGE).push('latest')
                    }
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: env.KUBECONFIG_CREDENTIAL_ID]) {
                        sh '''
                            kubectl set image deployment/hw2-cluster-deployment hw2-cluster-deployment=${DOCKER_IMAGE}:latest -n ${K8S_NAMESPACE}
                            kubectl rollout status deployment/hw2-cluster-deployment -n ${K8S_NAMESPACE}
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
