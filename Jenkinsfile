pipeline{
    agent any
    tools {
        jdk "JDK 11"
        maven "MAVEN3"
    }
    stages{
        stage ("Clear workspace"){
            steps {
                deleteDir()
            }
        }
        stage("clone repo"){
            steps{
                git branch: 'main', credentialsId: 'githublogin', url: 'git@github.com:SK-260/addressbook-project.git'
            }
        }
        stage("Code Compile"){
            steps{
                sh 'mvn compile'
            }
        }
        stage("Code Review") {
            steps {
                sh ' mvn pmd:pmd'
                recordIssues(tools: [pmdParser(pattern: '**/pmd.xml')])
            }
            
        }
        stage("Unit Testing"){
            steps {
                sh "mvn test"
                junit 'target/surefire-reports/*.xml'
            }
        }
        stage("Code Coverage"){
            steps{
                withEnv(["JAVA_HOME=${tool 'JDK 8'}"]) {
                    sh 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
                    cobertura coberturaReportFile: '**/target/site/cobertura/coverage.xml'
                }
                
            }
        }
        stage("Sonar Analysis") {
            environment {
                scannerHome = tool 'sonarscanner'
            }
            steps{                               
                withSonarQubeEnv(credentialsId: 'sonartoken', installationName: 'sonarserver'){
                    sh ''' ${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=addressbook \
                    -Dsonar.projectName=addressbook \
                    -Dsonar.projectVersion=1.0 \
                    -Dsonar.source=src/ \
                    -Dsonar.java.binaries=target/classes/,target/test-classes/ \
                    -Dsonar.java.pmd.reportPaths=target/ \
                    '''
                }
            }
        }
    }
}
