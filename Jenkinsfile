pipeline {
  agent any
  parameters { 
    string(name: 'action', defaultValue: '$.action', description: '')
    string(name: 'state', defaultValue: '$.pull_request.state', description: '')
    string(name: 'merged', defaultValue: '$.merged_at', description: '')
     }
  // triggers {
  //   GenericTrigger(
  //    genericVariables: [
  //     [key: 'pull_request', value: '$.pull_request'],
     
  //    ],
  //    causeString: 'Triggered on $ref',
  //    token: 'abc123',
  //    tokenCredentialId: '',
  //    printContributedVariables: true,
  //    printPostContent: true,

  //    silentResponse: false,
  //     regexpFilterText: '$ref',
  //     regexpFilterExpression: 'refs/heads/' + "${env.BRANCH_NAME}"

  //   )
  // }
  stages {
    stage('Some step') {
      steps {
        // echo "${everything}"
        echo "${params.action}"
          echo "${params.state}"
            echo "${params.merged}"
        echo 'hiiiiiii'
        echo "gitiii"
      }
    }
  }
}