pipeline {
  agent any
  parameters { string(name: 'payload', defaultValue: 'default_value_for_payload', description: '') }
  // triggers {
  //   GenericTrigger(
  //    genericVariables: [
  //     [key: 'ref', value: '$.ref'],
     
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
        echo "${params.payload}"
        
        echo 'hiiiiiiiii'
        echo "gitiii"
      }
    }
  }
}