pipeline {
    agent any
    environment {
        PATH = "/opt/apache-maven-3.8.6/bin:$PATH"
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Ajayalla/springboot-k8s-example']]])
                sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t madhublue01/frontendapplication .'
                }
            }
         }
         stage('Push image to Hub'){
             steps{
                 script{
                     withCredentials([string(credentialsId: 'docker-hublogin', variable: 'dockerhublogin')]) {
                     sh 'docker login -u madhublue01 -p ${dockerhublogin}'

}
                     sh 'docker push madhublue01/frontendapplication'

                 }
             }
         }
         stage('Deploy to k8s'){
             steps{
                 script{
                     kubernetesDeploy (configs: 'deploymentservice.yaml',kubeconfigId: 'k8config')
                 }
             }
         }
    }
}
