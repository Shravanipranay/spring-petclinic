pipeline {
    agent { label 'UBUNTU_NODE1' }
    stages {
        stage('git'){
            steps {
                git branch: 'scripted', url: 'https://github.com/Shravanipranay/spring-petclinic.git'
            }
        }
        stage('build'){
            steps {
                sh './gradlew build'
            }
        }
        stage('artifacts'){
            steps {
                archiveArtifacts artifacts : '**/spring-petclinic-3.0.0-SNAPSHOT.jar'
                                 junit '**/*.xml'
            }
        }
    }
}