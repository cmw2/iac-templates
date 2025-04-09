@description('Specifies the resource ID of the virtual network to link the private DNS zones.')
param virtualNetworkId string

@description('Specifies the resource tags.')
param tags object

// Private DNS Zones
resource acrPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.${toLower(environment().name) == 'azureusgovernment' ? 'azurecr.us' : 'azurecr.io'}'
  location: 'global'
  tags: tags
}

resource blobPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.blob.${environment().suffixes.storage}'
  location: 'global'
  tags: tags
}

resource filePrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.file.${environment().suffixes.storage}'
  location: 'global'
  tags: tags
}

resource keyVaultPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.${toLower(environment().name) == 'azureusgovernment' ? 'vaultcore.usgovcloudapi.net' : 'vaultcore.azure.net'}'
  location: 'global'
  tags: tags
}

resource mlApiPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.api.${toLower(environment().name) == 'azureusgovernment' ? 'ml.azure.us' : 'azureml.ms'}'
  location: 'global'
  tags: tags
}

resource mlNotebooksPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.notebooks.${toLower(environment().name) == 'azureusgovernment' ? 'usgovcloudapi.net' : 'azure.net'}'
  location: 'global'
  tags: tags
}

resource cognitiveServicesPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.cognitiveservices.${toLower(environment().name) == 'azureusgovernment' ? 'azure.us' : 'azure.com'}'
  location: 'global'
  tags: tags
}

resource openAiPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.openai.${toLower(environment().name) == 'azureusgovernment' ? 'azure.us' : 'azure.com'}'
  location: 'global'
  tags: tags
}

// Virtual Network Links
resource acrPrivateDnsZoneVirtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: acrPrivateDnsZone
  name: 'link_to_vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

resource blobPrivateDnsZoneVirtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: blobPrivateDnsZone
  name: 'link_to_vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

resource filePrivateDnsZoneVirtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: filePrivateDnsZone
  name: 'link_to_vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

resource keyVaultPrivateDnsZoneVirtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: keyVaultPrivateDnsZone
  name: 'link_to_vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

resource mlApiPrivateDnsZoneVirtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: mlApiPrivateDnsZone
  name: 'link_to_vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

resource mlNotebooksPrivateDnsZoneVirtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: mlNotebooksPrivateDnsZone
  name: 'link_to_vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

resource cognitiveServicesPrivateDnsZoneVirtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: cognitiveServicesPrivateDnsZone
  name: 'link_to_vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

resource openAiPrivateDnsZoneVirtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: openAiPrivateDnsZone
  name: 'link_to_vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

// Add the DNS zone for Azure AI Search
resource aiSearchPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.search.${toLower(environment().name) == 'azureusgovernment' ? 'azure.us' : 'windows.net'}'
  location: 'global'
  tags: tags
}

// Add the virtual network link for Azure AI Search
resource aiSearchPrivateDnsZoneVirtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: aiSearchPrivateDnsZone
  name: 'link_to_vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
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
