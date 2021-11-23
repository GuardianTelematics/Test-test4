pipeline {
  agent any
 parameters { 
    string(name: 'action', defaultValue: 'def', description: '')
    string(name: 'pr_state', defaultValue: 'def', description: '')
    string(name: 'merged', defaultValue: 'def', description: '')
  }
  triggers {
    GenericTrigger(
     genericVariables: [
      [key: 'pr_state', value: '$.pull_request.state'],
      [key: 'action', value: '$.action'],

      [
      key: 'everything',
      value: '$',
      expressionType: 'JSONPath', //Optional, defaults to JSONPath
      regexpFilter: '', //Optional, defaults to empty string
      defaultValue: '' //Optional, defaults to empty string
     ]
     ],
     causeString: 'Triggered on $pr_opened pull request',
     
     token: 'abc123',
     tokenCredentialId: '',
    //  printContributedVariables: true,
    //  printPostContent: true,

     silentResponse: false,
     regexpFilterText: '$action',
     regexpFilterExpression: 'opened'

    )
  }



  stages {
    stage('Some step') {
      when {equals expected: 'open', actual: "${params.pr_state}" }
      steps {
        echo "egine pull request sto '${env.BRANCH_NAME}'"
        // echo "${everything}"
        echo "${params.action}"
        
            echo "${params.pr_state}"
        echo 'hiiiiiii'
        echo "gitiii"
      }
    }
  }
}