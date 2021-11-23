pipeline {
  agent any
 parameters { 
    string(name: 'action', defaultValue: 'def', description: '')
    string(name: 'state', defaultValue: 'def', description: '')
    string(name: 'merged', defaultValue: 'def', description: '')
  }
  triggers {
    GenericTrigger(
     genericVariables: [
        
        [ key: "action",
          value: "$.action",
          expressionType: "JSONPath",
          regexpFilter: ""
        ]    
        [ key: "state",
          value: "$.pull_request.state",
          expressionType: "JSONPath",
          regexpFilter: ""
        ] 
        [ key: "action",
          value: "$.merged_at",
          expressionType: "JSONPath",
          regexpFilter: ""
        ]
     ], 
     token: 'abc123',
     tokenCredentialId: '',
     printContributedVariables: true,
     printPostContent: true, 
     silentResponse: false,
    //  regexpFilterText: '$action',
    //  regexpFilterExpression: 'opened'

     
    )
  }
 



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