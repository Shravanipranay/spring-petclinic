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
                archiveArtifacts artifacts: '**/spring-petclinic-*.jar'
          }
        }
        post('sending mail'){
           success{
                mail subject: 'Jenkins Build of ${JOB_NAME} with build id ${Build_ID} is success'
                     body: 'Use this url ${BUILD_URL} for more info'
                     from: 'devops@gmail.com'
                     to: 'qtdevops@gmail.com'
           }
          failure{
            mail subject: 'Jenkins Build of ${JOB_NAME} with build id ${Build_ID} is failure'
                     body: 'Use this url ${BUILD_URL} for more info'
                     from: 'devops@gmail.com'
                     to: 'qtdevops@gmail.com'

          }
        }
     }
     }