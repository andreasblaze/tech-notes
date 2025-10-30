# Concepts

stage('Installing Ansible roles') {
            when {
                expression {
                    return params.STAGES_TO_RUN.contains('Run Ansible')
                }
            }
            environment {
                ANSIBLE_LOCAL_TEMP = "${env.WORKSPACE}/.ansible"
            }
            agent {
                docker {
                    image ansibleDockerImage
                    reuseNode true
                }
            }
            steps {
                withBitbucketSSH(
                    bitbucketAccessKeyVaultPath: bitbucketAccessKeyVaultPath,
                    bitbucketAccessKeyVaultKey: bitbucketAccessKeyVaultKey,
                    vaultEngineVersion: bitbucketVaultEngineVersion,
                    callback: {
                        dir(ansiblerDir) {
                            sh('ansible-galaxy install -p playbooks/roles -r requirements.yml')
                        }
                    }
                )
            }
        }

        stage('Prepare SSH key for Ansible') {
            when {
                expression {
                    return params.STAGES_TO_RUN.contains('Run Ansible')
                }
            }
            steps {
                sh "install -m 600 /home/jenkins/.ssh/id_rsa ${WORKSPACE}/jenkins_id_rsa"
            }
        }

        stage('Execute Ansible Playbook') {
            when {
                expression {
                    return params.STAGES_TO_RUN.contains('Run Ansible')
                }
            }
            agent {
                docker {
                    image ansibleDockerImage
                    reuseNode true
                }
            }
            steps {
                script {
                    dir(ansiblerDir) {
                      sh("""
                        ansible-playbook -i ${ansibleInventoryPath} \
                          --private-key ../jenkins_id_rsa \
                          -u jenkins \
                          -b \
                          playbooks/main.yml \
                          -e 'WORKSPACE=${WORKSPACE}' \
                          -e 'clamav_token=${env.CLAMAV_FLOCK_TOKEN}'
                      """)
                    }
                }
            }
        }