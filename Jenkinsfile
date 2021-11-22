pipeline {
  agent any
  triggers {
    GenericTrigger(
     genericVariables: [
      [key: 'ref', value: '$.ref'],
      [key: 'everything', value: '$.']
     ],
     causeString: 'Triggered on $ref',
     token: 'abc123',
     tokenCredentialId: '',
     printContributedVariables: true,
     printPostContent: true,

     silentResponse: false,
     regexpFilterText: '$ref',
     regexpFilterExpression: 'refs/heads/' + "${env.BRANCH_NAME}"

    )
  }
  stages {
    stage('Some step') {
      steps {
        
        echo "${ref}"
        echo "${everything}"
        echo 'hiiiiiiiii'
        echo "gitiiiii"
      }
    }
  }
}