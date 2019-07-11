pipeline {
agent any 
stages {
stage('git') {
steps {
git 'https://github.com/wakaleo/game-of-life.git'
}
}
stage('build'){
steps {
sh 'mvn package'
}

}

stage('terraform') {
    steps{

 sh "cd /home/terraform_practice/wardeploy/ && terraform init"
 sh "cd /home/terraform_practice/wardeploy/ && terraform apply -auto-approve"

}
}


       
}
}