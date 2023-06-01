pipeline{
    agent 'any'
    stages{
        stage('VCS'){
            steps{
                git url: 'https://github.com/Shravanipranay/spring-petclinic.git',
                    branch: 'ci-cd'
            }
        }
        stage('build'){
            steps{
                sh './mvnw package'
            }
        }
        stage("junit"){
            steps{
                archiveArtifacts artifacts: '**/target/spring-petclinic-3.0.0-SNAPSHOT.jar',
									onlyIfSuccessful: true
				junit testResults: '**/surefire-reports/TEST-*.xml'
            }
        }
        stage('docker'){
            steps{
                sh 'sudo docker image build -t spc:v1.0.0 .'
                sh 'sudo docker image tag spc:v1.0.0 shravanipranay/spc:latest'
                sh 'sudo docker image push shravanipranay/spc:$latest'
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