pipeline {
  agent any

 environment {
        repoData = "${ env.JOB_NAME }".split('/')  //[Github Org, Test-test2, main]
        repoName = "${repoData[0]}".toLowerCase().replace ('-', '_')  //test-test2
        repoTag = "${repoData[0]}".split('-').first().toLowerCase() //test 
        parrentDir = "${ env.WORKSPACE }".substring(0, "${env.WORKSPACE}".indexOf("${repoData.first().replace (' ', '_')}")) // /var/lib/jenkins/workspace/
    }

 parameters { 
    string(name: 'action', defaultValue: 'default', description: '')
    string(name: 'pr_state', defaultValue: 'default', description: '')
    string(name: 'merged', defaultValue: 'default', description: '')
    string(name: 'x_github_event', defaultValue: 'default', description: '')
    string(name: 'ref', defaultValue: 'default', description: '')
    string(name: 'merged', defaultValue: 'default', description: '')
  }

  triggers {
    GenericTrigger(
     genericVariables: [
      [key: 'pr_state', value: '$.pull_request.state'],
      [key: 'action', value: '$.action'],
      [key: 'ref', value: '$.pull_request.head.ref'],
      [key: 'user', value: '$.pull_request.user.login'],
      [key: 'merged', value: '$.pull_request.merged'],
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
     //printContributedVariables: true,
     //printPostContent: true,

     silentResponse: false,
     regexpFilterText: '$x_github_event',
     regexpFilterExpression: 'push|pull_request'
    )
  }

  stages {
       
    stage('test'){
     // when { branch "${ref}" }
     when { equals expected: "${params.ref}", actual: "${env.BRANCH_NAME}" }
      steps{
        echo " merged is ${merged} "
        echo "to git.branch einai ---------${env.GIT_BRANCH}---------------"
        echo "to env.branch einai ---------------${env.BRANCH_NAME}--------------------"
        echo " user is ${user} "
        echo " ref is -----------${params.ref}----------- "
        echo " branch is -----------${ref}----------- "
        echo " repo data is ${repoData} "
        echo " repo name is ${repoName} "
        echo " repo tag is ${repoTag}"
        echo "parrent dir is ${parrentDir}"

        echo "${ env.JOB_NAME }"
      }
    }

    stage('Some step') {
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
 
    stage("build & test project"){ //pull request exv mono pros to main apo opoiodhpote branch. ara an exv event pull request apokleietai na einai sto main
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

    stage('deploy project'){
      when { branch 'main'}
      steps{
        // sh(script:"docker build . -t guardian-telematics/${repoName}") //build image
        // sh(script:"docker tag guardian-telematics/${repoName} localhost:5000/guardian-telematics/${repoName}") //create the tag
        // sh(script:"docker push localhost:5000/guardian-telematics/${repoName}") //push to docker registry 
        echo "${env.WORKSPACE}"
        echo 'eimai sto main'
      }
    }
  }
}