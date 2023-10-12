pipeline{
    agent any
    tools {
        jdk "JDK 8"
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
                sh 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
                cobertura coberturaReportFile: '**/target/site/cobertura/coverage.xml'
                
                
            }
        }
        stage("Sonar Analysis") {
            steps{
                withSonarQubeEnv(credentialsId: 'sonartoken', installationName: 'sonarserver'){
                    sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
                }
            }
        }
    }
}