{
  "schemaVersion": "2.2",
  "description": "Setup Petclinic Server",
  "mainSteps": [
    {
      "action": "aws:runShellScript",
      "name": "setup",
      "inputs": {
        "runCommand": [
          ${jsonencode(script_content)}
        ]
      }
    }
  ]
}
