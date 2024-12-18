pipeline {
    agent any
    environment {
        PATH = "${env.PATH}:/opt/homebrew/bin/:/usr/local/bin/"
       
    }
    parameters{
    choice(name: 'ENVIRONMENT', choices: ['dev', 'prod', 'uat'], description: 'Environment to deploy')
    choice(name: 'ACTION', choices: ['destroy', 'apply'], description: 'Approval Action')
    }
    
    stages {
        
        stage("Clean Workspace"){
            steps{
                cleanWs()
            }
        }
        
        stage("Checkout") {
            steps {
                git branch: 'main', url: 'git@github.com:Himalaya7087/Terraform.git', credentialsId:'github-ssh'
            }
        }
        
        stage('Terraform-Init') {
            steps{
                sh "terraform init --backend-config=environment/${params.ENVIRONMENT}/backend.tfvars"
            }
        }
        stage('Terraform-Plan') {
            steps{
                sh "terraform plan --var-file=environment/${params.ENVIRONMENT}/dev.tfvars"
            }
        }
        
          stage('Approval') {
            steps {
                script {
                    // Pause the pipeline and wait for user approval
                    input message: "Proceed with ${params.ACTION} action?"  
                    // parameters: [choice(name: 'ACTION', choices: ['Abort', 'Apply'], description: 'Approval Action')]
                  
                }
            }
        }
        
        stage('Terraform-apply') {
            steps{
                sh "terraform ${params.ACTION} --auto-approve --var-file=environment/${params.ENVIRONMENT}/dev.tfvars"
            }
        }
    }
      // post {
      //     success{
      //         echo "Success!"
      //         mail to:'himalayasingh.hs@gmail.com',
      //         subject: "Success: ${env.JOB_NAME} - Build #${env.BUILD_NUMBER}",
      //         body: "job '${env.JOB_NAME}' (${env.BUILD_URL}) succeeded. "
      //     }
      // }    
}

