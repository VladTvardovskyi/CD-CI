pipeline{
    agent any 
    environment { // the env vars are visible for all stages
        DOCKERHUB = credentials('af67dbcf-3f85-438f-b2e6-6e19403bac54')
        AWS_CREDENTIALS = credentials('aws_credentials')
        RELEASE_NAME = "demo4"
    }
    tools{
        terraform 'terraform'
        jdk 'OpenJDK-11'
        maven 'maven'
    }
    
    parameters{
        choice(
            choices: ['deploy', 'destroy'],
            name: 'ACT'
        )
    }
    stages{
        /*stage('Building oms') {
            when{
                expression{ params.ACT == 'deploy'}
            }
            steps{
                git ([url:'https://github.com/VladTvardovskyi/oms2.git', branch: main, credentialsId: 'Git']) 
                dir ('/home/ubuntu/demo'){
                    sh "mvn clean package -Dmaven.test.skip=true"
            }
            post{
                success{
                    archiveArtifacts 'target/*.war'
                }
            }
        }*/
        stage('Terraform init plan') {
            when{
                expression{ params.ACT == 'deploy'}
            }
            steps {
                dir ('project/') {
                    withAWS(credentials: 'aws_credentials', region: 'eu-central-1') {
                        sh "terraform init"
                        sh "terraform plan"
                   }
                }
            }
         stage('Terraform deploying') {
            when {
                expression{ params.ACT == 'deploy'}
                 }
            steps {
                dir ('project/') {
                    withAWS(credentials: 'aws_credentials', region: 'eu-central-1') {
                        sh "terraform apply -auto-approve"
                        sh 'kubectl apply -f manifest/tomcat_oms.yaml'
                        sh 'kubectl apply -f manifest/service.yaml'
                        //omsDeploying()
                        }
                    }
                }
           }
            /*stage('update-kubeconfig') {
                steps {
                    withAWS(credentials: 'aws-credentials') {
                        sh 'aws --region eu-central-1 eks update-kubeconfig --name terraform-eks-demo'
                    }
             }
         }*/
     }
        /*void omsDeploying(){
            sh 'kubectl apply -f manifest/tomcat_oms.yaml'
            sh 'kubectl apply -f manifest/service.yaml'
        }*/
    
        
    } 
}
