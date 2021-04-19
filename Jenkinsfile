pipeline{
    agent any 
    environment { // the env vars are visible for all stages
        DOCKERHUB = credentialsId('af67dbcf-3f85-438f-b2e6-6e19403bac54')
        AWS_CREDENTIALS = credentialsId('aws-credentials')
        RELEASE_NAME = "demo4"
    }
    tool{
        terraform 'terraform-0.14.7'
        jdk 'jdk-11'
        maven 'M3'
    }
    
    parameters{
        choice(
            choices: ['deploy', 'destroy'],
            name: 'ACT'
        )
    }

    stage('Building oms') {
        when{
            expression{ params.ACT == 'deploy'}
        }
        steps{
            git 'https://github.com/VladTvardovskyi/oms2.git'
            dir ('/home/ubuntu/demo'){
                sh "mvn clean package -Dmaven.test.skip=true"
        }
        post{
            success{
                archiveArtifacts 'target/*.war'
            }
        }
    }
}
}
