def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]

pipeline {

    agent any
    tools {
        maven "MAVEN3.9.8"
        jdk "JDK17"
    }

    environment {
        gitBranch = "springboot-ci"
        githubRepoUrl = "git@github.com:LynaSovann/github-actions-ci.git"
        githubCredential = "gittoken"
        registryCredential = 'ecr:us-east-1:awscreds'
        appRegistry = "716920920468.dkr.ecr.us-east-1.amazonaws.com/springimage"
        springBootRegistry = "https://716920920468.dkr.ecr.us-east-1.amazonaws.com"
        cluster = "springcicd"
        service = "springcicdappsvc"
    }

    stages {

        stage("Fetch code") {
            steps {
                git branch: "${gitBranch}", 
                url: "${githubRepoUrl}", 
                credentialsId: "${githubCredential}"
            }
        }

        stage('Build'){
            steps{
                sh 'ls -al'
               sh 'mvn install -DskipTests'
            }

            post {
               success {
                  echo 'Now Archiving it...'
                  archiveArtifacts artifacts: '**/target/*.jar'
               }
            }
        }

        stage('UNIT TEST') {
            steps{
                sh 'mvn test'
            }
        }

        stage('Checkstyle Analysis') {
            steps{
                sh 'mvn checkstyle:checkstyle'
            }
        }



        stage("Sonar Code Analysis") {
            environment {
                scannerHome = tool 'sonar6.2'
            }
            steps {
              withSonarQubeEnv('sonarqubeserver') {
                sh '''
                    mvn sonar:sonar \
                    -Dsonar.projectKey=springboot \
                    -Dsonar.projectName=springboot \
                    -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml
                   '''
              }
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 30, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }


        stage('Build App Image') {
          steps {
            script {
                dockerImage = docker.build( appRegistry + ":$BUILD_NUMBER", ".")
            }
          }
        }

        
        stage('Trivy Image Scan') {
            steps {
                sh '''
                trivy image \
                --scanners vuln \
                --format table \
                --output trivy-report.txt \
                ${appRegistry}:${BUILD_NUMBER}
                '''
            }

            post {
                always {
                    archiveArtifacts artifacts: 'trivy-report.txt'
                }
            }

        }

        stage('Upload App Image') {
          steps{
            script {
              docker.withRegistry( springBootRegistry, registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
              }
            }
          }
        }

        stage('Remove Container Images'){
            steps{
                sh 'docker rmi -f $(docker images -a -q)'
            }
        }

        stage('Deploy to ecs') {
          steps {
                withAWS(credentials: 'awscreds', region: 'us-east-1') {
                    sh "aws ecs update-service --cluster ${cluster} --service ${service} --force-new-deployment"
                }
            }
        }

    }

    post {
        always {
            echo 'Slack Notifications.'
            slackSend channel: '#devopscicd',
                color: COLOR_MAP[currentBuild.currentResult],
                message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }

}