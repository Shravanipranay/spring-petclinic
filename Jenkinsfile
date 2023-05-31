pipeline{
    agent 'any'
    stages{
        stage('VCS'){
            steps{
                 git url:
                 branch: main
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
                sh 'docker image tag spc:v1.0.0 shravanipranay/spc:latest'
                sh 'docker image push shravanipranay/spc:latest'
            }
        }
        stage('deployment'){
            steps{
                sh 'kubectl apply -f spc-manifest.yaml'
                sh 'kubectl get all'
            }
        }
    }
}