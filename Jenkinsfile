pipeline {
    agent { label 'jfrog_node1' }
    stages {
        stage('git'){
            steps {
                git branch: 'sonar', url: 'https://github.com/Shravanipranay/spring-petclinic.git'
            }
        }
        stage('build'){
            steps {
                sh 'mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=spc_spc -Dsonar.organization=spc'
                
            }
        }
        stage('artifacts'){
            steps {
                archiveArtifacts artifacts : '**/spring-petclinic-*.jar'
                                 junit '**/*.xml'
            }
        }
    }
}