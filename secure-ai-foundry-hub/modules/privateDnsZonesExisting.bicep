// Reference existing private DNS zones
resource acrPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: 'privatelink.${toLower(environment().name) == 'azureusgovernment' ? 'azurecr.us' : 'azurecr.io'}'
}

resource blobPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: 'privatelink.blob.${environment().suffixes.storage}'
}

resource filePrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: 'privatelink.file.${environment().suffixes.storage}'
}

resource keyVaultPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: 'privatelink.${toLower(environment().name) == 'azureusgovernment' ? 'vaultcore.usgovcloudapi.net' : 'vaultcore.azure.net'}'
}

resource mlApiPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: 'privatelink.api.${toLower(environment().name) == 'azureusgovernment' ? 'ml.azure.us' : 'azureml.ms'}'
}

resource mlNotebooksPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: 'privatelink.notebooks.${toLower(environment().name) == 'azureusgovernment' ? 'usgovcloudapi.net' : 'azureml.net'}'
}

resource cognitiveServicesPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: 'privatelink.cognitiveservices.${toLower(environment().name) == 'azureusgovernment' ? 'azure.us' : 'azure.com'}'
}

resource openAiPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: 'privatelink.openai.${toLower(environment().name) == 'azureusgovernment' ? 'azure.us' : 'azure.com'}'
}

resource aiSearchPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: 'privatelink.search.${toLower(environment().name) == 'azureusgovernment' ? 'azure.us' : 'windows.net'}'
}

// Outputs
output acrDnsZoneId string = acrPrivateDnsZone.id
output blobDnsZoneId string = blobPrivateDnsZone.id
output fileDnsZoneId string = filePrivateDnsZone.id
output keyVaultDnsZoneId string = keyVaultPrivateDnsZone.id
output mlApiDnsZoneId string = mlApiPrivateDnsZone.id
output mlApiDnsZoneName string = mlApiPrivateDnsZone.name
output mlNotebooksDnsZoneId string = mlNotebooksPrivateDnsZone.id
output mlNotebooksDnsZoneName string = mlNotebooksPrivateDnsZone.name
output cognitiveServicesDnsZoneId string = cognitiveServicesPrivateDnsZone.id
output cognitiveServicesDnsZoneName string = cognitiveServicesPrivateDnsZone.name
output openAiDnsZoneId string = openAiPrivateDnsZone.id
output openAiDnsZoneName string = openAiPrivateDnsZone.name
output aiSearchDnsZoneId string = aiSearchPrivateDnsZone.id
output aiSearchDnsZoneName string = aiSearchPrivateDnsZone.name
