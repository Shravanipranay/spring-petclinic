pipeline {
    agent { label 'jfrog_1' }
    parameters {
        choice(name: 'MAVEN_GOAL', choices: ['package', 'install', 'clean'], description: 'Maven Goal')
    }
    stages {
        stage('vcs') {
            steps {
                git url: 'https://github.com/Shravanipranay/spring-petclinic.git',
                    branch: 'spcdeclarative'
            }
        }
        stage('Artifactory configuration') {
            steps {
                rtServer (
                    id: "ARTIFACTORY_SERVER",
                    url: 'https://shravani032.jfrog.io/artifactory',
                    credentialsId: 'Jfrog_today'
                )

                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "ARTIFACTORY_SERVER",
                    releaseRepo: 'libs-release',
                    snapshotRepo: 'libs-snapshot'
                )

                rtMavenResolver (
                    id: "MAVEN_RESOLVER",
                    serverId: "ARTIFACTORY_SERVER",
                    releaseRepo: 'libs-release',
                    snapshotRepo: 'libs-snapshot'
                )
            }
        }
        stage('package') {
            steps {
                sh "/opt/maven/bin/mvn ${params.MAVEN_GOAL}"
                rtMavenRun (
                    tool: 'MAVEN_DEFAULT',
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "MAVEN_DEPLOYER"

                )
                rtPublishBuildInfo (
                    serverId: "Jfrog_today"
                )
            }
        }      
    
    }        
}

            