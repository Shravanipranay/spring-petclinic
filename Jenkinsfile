pipeline {
    agent { label 'jfrog_1' }
    stages {
        stage('git'){
            steps {
                git branch: 'sonar', url: 'https://github.com/Shravanipranay/spring-petclinic.git'
            }
        }
        stage('build'){
            steps {
                withSonarQubeEnv('sonarqube'){
                    sh '/opt/maven/bin/mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=shravani_myproject -Dsonar.organization=shravani'
                    
                }        
                
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