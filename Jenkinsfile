pipeline {
    agent any

    tools {
      maven 'maven_3_3_9'
    }
	
    environment {
           registry = "sptripathii/be-test-image"
           registryCredential = 'dockerhub'
           dockerImage = ''
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
            steps{
	       echo 'Building docker image...'	    
               script {
                  dockerImage = docker.build(registry)
               }
            }      
        } 
        stage('Deploy Image') {
             steps{
	       echo 'Deploying docker image...'     
                script {
                     docker.withRegistry( '', registryCredential ) {
                         dockerImage.push()
               	     }
                }
             }
         }
    }	
  }
