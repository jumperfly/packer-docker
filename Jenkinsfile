pipeline {
    agent {
        label 'packer && ansible && virtualbox && vagrant'
    }

    options {
        ansiColor('xterm')
    }

    environment {
        VAGRANT_CLOUD_TOKEN = credentials('vagrant-cloud')
        BASE_BOX_VERSION = "7.6.1"
        DOCKER_MAJOR_MINOR = "18.09"
        DOCKER_PATCH = "6"
    }

    stages {
        stage('Clean') {
            when { 
                expression { return fileExists("output-virtualbox-ovf") }
            }
            steps {
                sh 'rm -rf output-virtualbox-ovf'
            }
        }
        stage ('Download Roles') {
            steps {
                sh 'ansible-galaxy install -r requirements.yml -p roles'
            }
        }
        stage ('Download Base Box') {
            when { 
                expression { return !fileExists("$HOME/.vagrant.d/boxes/jumperfly-VAGRANTSLASH-centos-7/$BASE_BOX_VERSION/virtualbox/box.ovf") }
            }
            steps {
                sh "vagrant box add jumperfly/centos-7 --box-version $BASE_BOX_VERSION"
            }
        }
        stage('Build') {
            steps {
                sh 'packer build packer.json'
            }
        }
    }
}
