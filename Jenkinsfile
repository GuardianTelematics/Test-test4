pipeline {
 agent any

 environment {
        repoData = "${ env.JOB_NAME }".split('/')  
        repoName = "${repoData[0]}".toLowerCase().replace ('-', '_')  
        repoTag = "${repoData[0]}".split('-').first().toLowerCase()
        parrentDir = "${ env.WORKSPACE }".substring(0, "${env.WORKSPACE}".indexOf("${repoData.first().replace (' ', '_')}")) // /var/lib/jenkins/workspace/
    }

 parameters { 
    string(name: 'action', defaultValue: 'default', description: '')
    string(name: 'pr_state', defaultValue: 'default', description: '')
    string(name: 'merged', defaultValue: 'default', description: '') 
    string(name: 'x_github_event', defaultValue: 'default', description: '')
    string(name: 'pr_branch', defaultValue: 'default', description: '') //branch= branch the pr was started from
    string(name: 'baseBranch', defaultValue: 'default', description: '') //baseBranch= branch the pr was merged to
  }

 triggers {
    GenericTrigger(
     genericVariables: [
      [key: 'ref', value: '$.ref'],
      [key: 'action', value: '$.action'],
      [key: 'pr_state', value: '$.pull_request.state'],
      [key: 'merged', value: '$.pull_request.merged'],
      [key: 'pr_branch', value: '$.pull_request.head.ref'],
      [key: 'baseBranch', value: '$.pull_request.base.ref'],
    //  [key: 'user', value: '$.pull_request.user.login'], //user who fired the event, sender is better option. maybe i dont need it
     ],
     genericHeaderVariables: [
      [key: 'X-GitHub-Event', regexpFilter: '']
     ],
     causeString: 'Triggered on pull request',
     tokenCredentialId: 'genericWebhookToken',
     silentResponse: false,
     regexpFilterText: '$pr_branch $action',
     regexpFilterExpression: "${env.BRANCH_NAME} synchronize|${env.BRANCH_NAME} opened"
    )
 }

 stages {

    stage('test'){
      steps{
        echo "to env.ChANGE_BRANCH einai ${env.CHANGE_BRANCH}"
        echo "to env.CHANGE_TARGET einai ${env.CHANGE_TARGET}"
        echo "to git.branch einai ${env.GIT_BRANCH}"
        echo "to env.branch einai ${env.BRANCH_NAME}"
        echo " branch is ${params.pr_branch} " 
        echo " repo data is ${repoData} "
        echo " repo name is ${repoName} "
        echo " repo tag is ${repoTag}"
        echo "parrent dir is ${parrentDir}"
        echo "action is ${params.action}"
        echo "event is ${params.x_github_event}"
        echo "pr_state is ${params.pr_state}"   
        echo "merged is ${params.merged}"   
        echo " job_name is ${ env.JOB_NAME }"
      }
    }

    stage("build && test project"){
          when { allOf { equals expected: "${params.pr_branch}", actual: "${env.BRANCH_NAME}" ; //this condition should be in every stage
                         //equals expected: 'opened', actual: "${params.action}" ;
                         equals expected: 'open', actual: "${params.pr_state}"
                        } 
          }
          steps{
            echo "Building the project after ${x_github_event} in ${params.branch} branch"
            
            script {
             def stderrfile = 'stderr.out'
             try {
             // sh(script:"docker build --target build -t guardian-telematics/${repoName} . 2>${stderrfile}")     
               echo "Building and testing stage was successfull"
             // slackSend(color:'#82f58c', botUser: true, username: 'JenkinsBot', channel: "random", tokenCredentialId: 'slack_token', message: "Building and testing stage for ${params.pr_branch} branch in ${repoName} repository was successfull.")    
             } catch (err) {
               def errmsg = readFile(stderrfile)               
             // slackSend(color:'#c4000a', botUser: true, username: 'JenkinsBot', channel: "random", tokenCredentialId: 'slack_token', message: "Building and testing stage for ${params.pr_branch} branch in ${repoName} repository failed. Error message is: ${errmsg}. Please handle the error(s)")
              error "Building and testing stage failed. The error caught is: ${errmsg}. Please handle the error"
             }
            }



          }
    }
    
    stage ('check if docker registry exists or else create it'){
      
      // when { allOf { equals expected: 'true', actual: "${params.merged}" ;
      //                equals expected: 'main', actual: "${env.BRANCH_NAME}"
      //               }
      // }
      steps{
        
        script{
          def result = sh(script: 'docker container inspect registry > /dev/null && echo "true" || echo "false"', returnStdout: true)                   
          result = result.replaceAll("\n", "");
          echo "result is ------${result}-----"
          if (result == "false"){
          //  sh(script:"docker service create --name registry --publish published=5000,target=5000 \
          //   --restart-condition 'on-failure' \
          //     registry:2") //run docker registry     
           echo "create dcker registry"  
           result = !(result)
           echo "result is ${result}"    
          }
          
        }
      }
      
    }


 }  

}