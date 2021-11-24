pipeline {
  agent any
 parameters { 
    string(name: 'action', defaultValue: 'def', description: '')
    string(name: 'pr_state', defaultValue: 'def', description: '')
    string(name: 'merged', defaultValue: 'def', description: '')
    string(name: 'x_github_event', defaultValue: 'def', description: '')
    string(name: 'ref', defaultValue: 'def', description: '')

  }

  triggers {
    GenericTrigger(
     genericVariables: [
      [key: 'pr_state', value: '$.pull_request.state'],
      [key: 'action', value: '$.action'],
      [key: 'ref', value: '$.ref'],
      // [
      // key: 'everything',
      // value: '$',
      // expressionType: 'JSONPath', //Optional, defaults to JSONPath
      // regexpFilter: '', //Optional, defaults to empty string
      // defaultValue: '' //Optional, defaults to empty string
      // ]
     ],
     genericHeaderVariables: [
      [key: 'X-GitHub-Event', regexpFilter: '']
     ],
     causeString: 'Triggered on pull request',
     tokenCredentialId: 'genericWebhookToken',
     printContributedVariables: true,
     //printPostContent: true,

     silentResponse: false,
     regexpFilterText: '$x_github_event',
     regexpFilterExpression: 'push|pull_request'
    )
  }



  stages {
    stage('Some step') {
      echo "Staging"
      //when {equals expected: 'open', actual: "${params.pr_state}" }
      steps {
       
        echo "egine pull request sto '${env.BRANCH_NAME}'"
        // echo "${everything}"
        echo "${params.action}"
        echo "event----"
        echo "${x_github_event}"
        echo "event-----"
        echo "${params.pr_state}"   
      }
    }

    stage("build project"){ //pull request exv mono pros to main apo opoiodhpote branch. ara an exv event pull request apokleietai na einai sto main
     // when { not {branch 'main'} }
      when { allOf { not {branch 'main'} ;
                     equals expected: 'opened', actual: "${params.action}" ;
                     equals expected: 'open', actual: "${params.pr_state}"
                    } 
            }
      steps{
        echo "eimai apo pull request poy egine open"
        echo "${env.WORKSPACE}"    
      }
    }

    stage("test project"){
      steps{
          echo 'testing the project'
      }

    }

    stage('test main'){
      when { branch 'main'}
      steps{
               
        echo 'eimai sto main'
      }
    }
  }
}