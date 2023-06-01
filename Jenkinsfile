pipeline{
    agent 'any'
    stages{
        stage('VCS'){
            steps{
                 git url: 'https://github.com/Shravanipranay/spring-petclinic.git'
                     branch: 'ci-cd'
            }
        }
        stage('build'){
            steps{
                sh './mvn package'
            }
        }
        stage("junit"){
            steps{
                archiveArtifacts artifacts: '**/target/spring-petclinic-3.0.0-SNAPSHOT.jar'
                junit '**/*.xml'
            }
        }
        stage('docker'){
            steps{
                sh 'docker image build -t spc:v1.0.0 .'
                sh 'docker image tag spc:v1.0.0 shravanipranay/spc:$BUILD_NUMBER'
                sh 'docker image push shravanipranay/spc:$BUILD_NUMBER'
            }
        }
        stage('deployment'){
            steps{
                sh 'kubectl edit set image shravanipranay/spc:finalimage=shravanipranay/spc:$BUILD_NUMBER'
                sh 'kubectl apply -f manifest.yaml'
                sh 'kubectl get all'
            }
        }
    }
}