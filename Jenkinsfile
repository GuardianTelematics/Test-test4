pipeline {
    agent any

    environment {
        repoData = "${ env.JOB_NAME }".split('/')
        repoName = "${repoData[1]}"
        repoNameTag = "${repoName}".split('-').first()
        parrentDir = "${ env.WORKSPACE }".substring(0, "${env.WORKSPACE}".indexOf("${repoData.first()}"))
    }

    stages{
  
            // olh auth h diadikasia ginetai trigger apo pull request
            // auto pou egv thelv na elegjv einai mono an eimai se branch ebdiaferontos(dhl to staging gia arxh)
            //an thelv na elegjw kai gia pull request xrhsimopoiw to env.CHANGE_ID
        
        stage('check if docker Registry exists') { 
            when allof { branch 'Staging' , env.CHANGE_ID != null} //den einai svstos tropos mallon h sygkrish me null, nato valv se if?
            steps{               
                docker_registry_status_code = sh(script: 'curl -I -k -s localhost:5000/ | head -n 1 | cut -d ' ' -f 2', returnStdout: true) //without def in order to be accesible outside the stage                                    
            }  //diaforetika mporei na mpei mesa sto epomeno stage to status_code
        }

        stage("create docker Registry if doesn't exist"){
            when { 
                equals expected: '200', actual: docker_registry_status_code
            }   
            steps{
                dir("${parrentDir}") { // eimai mesa sto workspace
                    sh(script:"mkdir -p auth/${repoNameTag}/htpasswd")

                    withCredentials([usernamePassword(credentialsId: 'docker_registry_cred', passwordVariable: 'pass', usernameVariable: 'user')]) { // na valv ws credential ID 'docker_registry_cred'
                        // the code here can access $pass and $user
                        sh(script:"docker run --rm --entrypoint htpasswd registry:2.7.0 -nbB $user $pass > ./auth/${repoNameTag}/htpasswd") //Generate a password file
                    }                    
                    sh(script:"chmod 444 auth/${repoNameTag}/htpasswd")
                    sh(script:"docker secret create htpasswd ./auth/${repoNameTag}/htpasswd")
                    sh(script:"docker service create --name registry --publish published=5000,target=5000 \
                                --secret htpasswd \
                                ----restart-condition "on-failure" \
                                --env "REGISTRY_AUTH=htpasswd" \
                                --env "REGISTRY_AUTH_HTPASSWD_REALM=Local Registry" \
                                --env "REGISTRY_AUTH_HTPASSWD_PATH=/run/secrets/htpasswd" \
                                --env "REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/var/lib/registry" \
                                registry:2")
                   
                }   
            }        
            post{
                failure{
                    echo 'unable to create docker Registry' //sendSlack?           
                } 
            }
        }

        stage('build and push to docker registry'){                         
            when { expression { return fileExists ('dockerfile') } }                          
            steps{
                def repo =  (repoNameTag.toLowerCase()).replace ('-', '_')
                sh(script:"docker build . -t guardian-telematics/${repo}") //build image
                sh(script:"docker tag guardian-telematics/${repo} localhost:5000/guardian-telematics/${repo}") //create the tag 
                sh(script:"docker push localhost:5000/guardian-telematics/${repo}") //push to docker registry
            }                 
            post{
                success { //channel "builds"?
                echo "send slack for success"
                   // slackSend(color:'#82f58c', botUser: true, username: 'name_of_the_bot', channel: "channel_name", tokenCredentialId: 'slack_token', message: " ") // na valv ws credential ID 'slack-token'
                }
                failure {
                    echo "send slack for failure"
                   // slackSend(color:'#c4000a', botUser: true, username: 'name_of_the_bot', channel: "channel_name", tokenCredentialId: 'slack_token', message: " ")
                    
                }
            }
        }

        // stage('run docker compose'){
        //     when { expression { return fileExists ('docker-compose.yml') } }  
        //     steps{
        //         def tag = repoNameTag.toLowerCase()
        //         sh(script:"docker stack deploy --with-registry-auth -c docker-compose.yml ${tag}") 
        //     }
                
        //     post{ //channel "deploy"?
        //         success {
        //             echo "send slack for success"
        //            // slackSend(color:'#82f58c', botUser: true, username: 'name_of_the_bot', channel: "channel_name", tokenCredentialId: 'slack_token', message: " ")
        //         }
        //         failure {
        //             echo "send slack for failure"
        //             //slackSend(color:'#c4000a', botUser: true, username: 'name_of_the_bot', channel: "channel_name", tokenCredentialId: 'slack_token', message: " ")
        //         }
        //     }
        // } 
    } 



}
