pipeline{
    agent any
    tools {
        jdk "JDK 8"
        maven "MAVEN3"
    }
    stages{
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
            }
            
        }
        stage("Unit Testing"){
            steps {
                sh "mvn test"
            }
        }
        stage("Code Coverage"){
            steps{
                sh 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
            }
        }
    }
}