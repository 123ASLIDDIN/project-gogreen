pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
        stage('Git init') {
            steps {
                git credentialsId: 'git-jenkins', url: 'https://github.com/GoGreenProjectT3/Team3.git'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init -no-color'
            }
        }
        stage('Terraform plan') {
            steps {
                sh 'terraform plan -destroy -no-color'
            }
        }
        stage('Terraform Destroy') {
            input {
                message "Do you want to destroy deployment?"
            }
            steps {
                sh 'terraform destroy --auto-approve -no-color'
            }
        }
    }
}


// pipeline {
//     agent any
//     tools {
//         terraform 'terraform'
//     }
//     stages {
//         stage('Terraform Apply') {
//             when {
//                 expression {
//                     return params.action == 'apply'
//                 }
//             }
//             steps {
//                 git 'https://github.com/GoGreenProjectT3/Team3.git'

//                 sh 'terraform init -no-color'

//                 echo "terraform action from paratmetr is --> ${action}"

//                 sh "${action}"
//             }
//         }
//         stage('Terraform Destroy') {
//             when {
//                 expression {
//                     return params.action == 'destroy'
//                 }
//             }
//             steps {
//                 echo "terraform action from paratmetr is --> ${action}"
//                 sh "${action}"
//             }
//         }
//     }
// }
