pipeline {
    agent { label 'jfrog_1' }
    stages {
        stage('vcs') {
            steps{
            
                git branch: 'gradle',
                    url: 'https://github.com/Shravanipranay/spring-petclinic.git'
                }
        }

        stage('build') {
                steps {
                sh './gradlew build'
                }
            }
        stage('artifactory'){
            steps{
                archiveArtifacts artifacts: '**/spring-petclinic-3.0.0-SNAPSHOT.jar'
                                 onlyIfSuccessful: 'yes'
            }
        }
          
     }
     }