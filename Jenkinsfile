pipeline {
    agent any

    tools {
      maven 'maven_3_3_9'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building backend code...'
                sh 'mvn -f pom.xml -Dmaven.test.failure.ignore=true clean compile'
            }
            }

        stage('Test') {
            steps {
                echo 'Testing backend code..'
                sh 'mvn -f pom.xml -Dmaven.test.failure.ignore=true test'
            }
        }
        stage('Package') {
            steps {
                echo 'Packaging backend code...'
                sh 'mvn -f pom.xml -DskipTests package'
                archiveArtifacts artifacts: '**/target/*.war', fingerprint: true
            }
        }
	      stage('Building image') {
            echo 'Building docker image...'
            steps{
               script {
                  dockerImage = docker.build(registry, "./backend/")
               }
            }      
        } 
        stage('Deploy Image') {
            echo 'Deploying docker image...'
             steps{
                script {
                     docker.withRegistry( '', registryCredential ) {
                         dockerImage.push()
               	     }
                }
             }
         }
    }	
  }
