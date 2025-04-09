@description('List of role assignments to create.')
param roleAssignments array

// Iterate over the role assignments and create them
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for role in roleAssignments: {
  name: guid(resourceGroup().id, role.principalId, role.roleDefinitionId)
  scope: resourceGroup()
  properties: {
    principalId: role.principalId
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', role.roleDefinitionId)
  }
}]
