// Imports
import {getVirtualNetworkIdFromSubnetId, getVirtualNetworkNameFromSubnetId} from './functions.bicep'

// Parameters
@description('Specifies the resource ID of the subnet where private endpoints will be created.')
param subnetId string

@description('Specifies the resource group where private DNS zones are located.')
param dnsZonesResourceGroupName string

@description('Specifies the resource tags.')
param tags object

@description('Specifies the name of the private endpoint to the blob storage account.')
param blobStorageAccountPrivateEndpointName string

@description('Specifies the name of the private endpoint to the file storage account.')
param fileStorageAccountPrivateEndpointName string

@description('Specifies the resource id of the Azure Storage Account.')
param storageAccountId string

@description('Specifies the name of the private endpoint to the Key Vault.')
param keyVaultPrivateEndpointName string

@description('Specifies the resource id of the Azure Key vault.')
param keyVaultId string

@description('Specifies the resource id of the Azure Hub Workspace.')
param hubWorkspaceId string

@description('Specifies the resource id of the Azure AI Services.')
param aiServicesId string

@description('Specifies the resource id of the Azure AI Search.')
param aiSearchId string

@description('Specifies whether to create a private endpoint for the Azure Container Registry')
param createAcrPrivateEndpoint bool = false

@description('Specifies the name of the private endpoint to the Azure Container Registry.')
param acrPrivateEndpointName string

@description('Specifies the resource id of the Azure Container Registry.')
param acrId string

@description('Specifies the name of the private endpoint to the Azure Hub Workspace.')
param hubWorkspacePrivateEndpointName string

@description('Specifies the name of the private endpoint to the Azure AI Services.')
param aiServicesPrivateEndpointName string

@description('Specifies the name of the private endpoint to the Azure AI Search.')
param aiSearchPrivateEndpointName string

// @description('Specifies the resource ID of the Machine Learning Compute.')
// param mlComputeId string = ''

// @description('Specifies the name of the private endpoint for the Machine Learning Compute.')
// param mlComputePrivateEndpointName string = ''

@description('Specifies the location.')
param location string = resourceGroup().location

// Import the private DNS zones module
module privateDnsZones './privateDnsZonesExisting.bicep' = {
  name: 'privateDnsZones'
  scope: resourceGroup(dnsZonesResourceGroupName)
}

// Private Endpoints
resource blobStorageAccountPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-04-01' = {
  name: blobStorageAccountPrivateEndpointName
  location: location
  tags: tags
  properties: {
    privateLinkServiceConnections: [
      {
        name: blobStorageAccountPrivateEndpointName
        properties: {
          privateLinkServiceId: storageAccountId
          groupIds: [
            'blob'
          ]
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource blobStorageAccountPrivateDnsZoneGroupName 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-04-01' = {
  parent: blobStorageAccountPrivateEndpoint
  name: 'PrivateDnsZoneGroupName'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'dnsConfig'
        properties: {
          privateDnsZoneId: privateDnsZones.outputs.blobDnsZoneId
        }
      }
    ]
  }
}

resource fileStorageAccountPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-04-01' = {
  name: fileStorageAccountPrivateEndpointName
  location: location
  tags: tags
  properties: {
    privateLinkServiceConnections: [
      {
        name: fileStorageAccountPrivateEndpointName
        properties: {
          privateLinkServiceId: storageAccountId
          groupIds: [
            'file'
          ]
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource fileStorageAccountPrivateDnsZoneGroupName 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-04-01' = {
  parent: fileStorageAccountPrivateEndpoint
  name: 'PrivateDnsZoneGroupName'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'dnsConfig'
        properties: {
          privateDnsZoneId: privateDnsZones.outputs.fileDnsZoneId
        }
      }
    ]
  }
}

resource keyVaultPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-04-01' = {
  name: keyVaultPrivateEndpointName
  location: location
  tags: tags
  properties: {
    privateLinkServiceConnections: [
      {
        name: keyVaultPrivateEndpointName
        properties: {
          privateLinkServiceId: keyVaultId
          groupIds: [
            'vault'
          ]
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource keyVaultPrivateDnsZoneGroupName 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-04-01' = {
  parent: keyVaultPrivateEndpoint
  name: 'PrivateDnsZoneGroupName'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'dnsConfig'
        properties: {
          privateDnsZoneId: privateDnsZones.outputs.keyVaultDnsZoneId
        }
      }
    ]
  }
}

resource acrPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-04-01' = if (createAcrPrivateEndpoint) {
  name: acrPrivateEndpointName
  location: location
  tags: tags
  properties: {
    privateLinkServiceConnections: [
      {
        name: acrPrivateEndpointName
        properties: {
          privateLinkServiceId: acrId
          groupIds: [
            'registry'
          ]
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource acrPrivateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-04-01' = if (createAcrPrivateEndpoint) {
  parent: acrPrivateEndpoint
  name: 'acrPrivateDnsZoneGroup'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'dnsConfig'
        properties: {
          privateDnsZoneId: privateDnsZones.outputs.acrDnsZoneId
        }
      }
    ]
  }
}

resource hubWorkspacePrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-11-01' = {
  name: hubWorkspacePrivateEndpointName
  location: location
  tags: tags
  properties: {
    privateLinkServiceConnections: [
      {
        name: hubWorkspacePrivateEndpointName
        properties: {
          privateLinkServiceId: hubWorkspaceId
          groupIds: [
            'amlworkspace'
          ]
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource hubWorkspacePrivateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-11-01' = {
  parent: hubWorkspacePrivateEndpoint
  name: 'hubWorkspacePrivateDnsZoneGroup'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: replace(privateDnsZones.outputs.mlApiDnsZoneName, '.', '-')
        properties: {
            privateDnsZoneId: privateDnsZones.outputs.mlApiDnsZoneId
        }
      }
      {
        name: replace(privateDnsZones.outputs.mlNotebooksDnsZoneName, '.', '-')
        properties: {
            privateDnsZoneId: privateDnsZones.outputs.mlNotebooksDnsZoneId
        }
      }
    ]
  }
}

resource aiServicesPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-11-01' = {
  name: aiServicesPrivateEndpointName
  location: location
  tags: tags
  properties: {
    privateLinkServiceConnections: [
      {
        name: aiServicesPrivateEndpointName
        properties: {
          privateLinkServiceId: aiServicesId
          groupIds: [
            'account'
          ]
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource aiServicesPrivateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-11-01' = {
  parent: aiServicesPrivateEndpoint
  name: 'default'
  properties:{
    privateDnsZoneConfigs: [
      {
        name: replace(privateDnsZones.outputs.cognitiveServicesDnsZoneName, '.', '-')
        properties:{
          privateDnsZoneId: privateDnsZones.outputs.cognitiveServicesDnsZoneId
        }
      }
      {
        name: replace(privateDnsZones.outputs.openAiDnsZoneName, '.', '-')
        properties:{
          privateDnsZoneId: privateDnsZones.outputs.openAiDnsZoneId
        }
      }
    ]
  }
}

resource aiSearchPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-11-01' = {
  name: aiSearchPrivateEndpointName
  location: location
  tags: tags
  properties: {
    privateLinkServiceConnections: [
      {
        name: aiSearchPrivateEndpointName
        properties: {
          privateLinkServiceId: aiSearchId
          groupIds: [
            'searchService'
          ]
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource aiSearchPrivateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-11-01' = {
  parent: aiSearchPrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: replace(privateDnsZones.outputs.aiSearchDnsZoneName, '.', '-')
        properties: {
          privateDnsZoneId: privateDnsZones.outputs.aiSearchDnsZoneId
        }
      }
    ]
  }
}

// Add a private endpoint for the Machine Learning Compute resource

// resource mlComputePrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-11-01' = {
//   name: mlComputePrivateEndpointName
//   location: location
//   tags: tags
//   properties: {
//     privateLinkServiceConnections: [
//       {
//         name: mlComputePrivateEndpointName
//         properties: {
//           privateLinkServiceId: mlComputeId
//           groupIds: [
//             'amlcompute'
//           ]
//         }
//       }
//     ]
//     subnet: {
//       id: subnetId
//     }
//   }
// }

// resource mlComputePrivateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-11-01' = {
//   parent: mlComputePrivateEndpoint
//   name: 'default'
//   properties: {
//     privateDnsZoneConfigs: [
//       {
//         name: replace(privateDnsZones.outputs.mlApiDnsZoneName, '.', '-')
//         properties: {
//           privateDnsZoneId: privateDnsZones.outputs.mlApiDnsZoneId
//         }
//       }
//     ]
//   }
// }
