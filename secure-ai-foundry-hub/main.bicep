// Parameters
@description('Specifies the name prefix for all the Azure resources.')
@minLength(4)
@maxLength(13)
param prefix string = substring(uniqueString(resourceGroup().id), 0, 4)

@description('Specifies the name suffix for all the Azure resources.')
@minLength(4)
@maxLength(13)
param suffix string = substring(uniqueString(resourceGroup().id), 0, 4)

@description('Specifies the location for all the Azure resources.')
param location string = resourceGroup().location

@description('Specifies the name Azure AI Hub workspace.')
param hubName string = ''

@description('Specifies the friendly name of the Azure AI Hub workspace.')
param hubFriendlyName string = 'Demo AI Hub'

@description('Specifies the description for the Azure AI Hub workspace dispayed in Azure AI Foundry.')
param hubDescription string = 'This is a demo hub for use in Azure AI Foundry.'

@description('Specifies the name for the Azure AI Foundry Hub Project workspace.')
param projectName string = ''

@description('Specifies the friendly name for the Azure AI Foundry Hub Project workspace.')
param projectFriendlyName string = 'AI Foundry Hub Project'

@description('Specifies the public network access for the Azure AI Project workspace.')
@allowed([
  'Disabled'
  'Enabled'
])
param projectPublicNetworkAccess string = 'Disabled'

@description('Specifies the Isolation mode for the managed network of the Azure AI Hub workspace.')
@allowed([
  'AllowInternetOutbound'
  'AllowOnlyApprovedOutbound'
  'Disabled'
])
param hubIsolationMode string = 'AllowInternetOutbound'

@description('Specifies the public network access for the Azure AI Hub workspace.')
@allowed([
  'Disabled'
  'Enabled'
])
param hubPublicNetworkAccess string = 'Disabled'

@description('Specifies the authentication method for the OpenAI Service connection.')
@allowed([
  'ApiKey'
  'AAD'
  'ManagedIdentity'
  'None'
])
param connectionAuthType string = 'AAD'

@description('Determines whether or not to use credentials for the system datastores of the workspace workspaceblobstore and workspacefilestore. The default value is accessKey, in which case, the workspace will create the system datastores with credentials. If set to identity, the workspace will create the system datastores with no credentials.')
@allowed([
  'identity'
  'accessKey'
])
param systemDatastoresAuthMode string = 'identity'

@description('Specifies the name of the existing Azure Log Analytics resource.')
param logAnalyticsName string = ''

@description('Specifies the name of the Azure Log Analytics resource group.')
param logAnalyticsResourceGroupName string = resourceGroup().name

@description('Specifies the name of the Azure Application Insights resource.')
param applicationInsightsName string = ''

@description('Specifies the name of the Azure AI Services resource.')
param aiServicesName string = ''

@description('Specifies the resource model definition representing SKU.')
param aiServicesSku object = {
  name: 'S0'
}

@description('Specifies the identity of the Azure AI Services resource.')
param aiServicesIdentity object = {
  type: 'SystemAssigned'
}

@description('Specifies an optional subdomain name used for token-based authentication.')
param aiServicesCustomSubDomainName string = ''

@description('Specifies whether disable the local authentication via API key.')
param aiServicesDisableLocalAuth bool = true

@description('Specifies whether or not public endpoint access is allowed for this account..')
@allowed([
  'Enabled'
  'Disabled'
])
param aiServicesPublicNetworkAccess string = 'Disabled'

@description('Specifies the OpenAI deployments to create.')
param openAiDeployments array = [
  {
    model: {
      name: 'text-embedding-ada-002'
      version: '2'
    }
    sku: {
      name: 'Standard'
      capacity: 10
    }
  }
  {
    model: {
      name: 'gpt-4o'
      version: '2024-05-13'
    }
    sku: {
      name: 'Standard'
      capacity: 10
    }
  }
]

@description('Specifies the name of the Azure Key Vault resource.')
param keyVaultName string = ''

@description('Specifies whether to allow public network access for Key Vault.')
@allowed([
  'Disabled'
  'Enabled'
])
param keyVaultPublicNetworkAccess string = 'Disabled'

@description('Specifies the default action of allow or deny when no other rules match for the Azure Key Vault resource. Allowed values: Allow or Deny')
@allowed([
  'Allow'
  'Deny'
])
param keyVaultNetworkAclsDefaultAction string = 'Allow'

@description('Specifies whether the Azure Key Vault resource is enabled for deployments.')
param keyVaultEnabledForDeployment bool = true

@description('Specifies whether the Azure Key Vault resource is enabled for disk encryption.')
param keyVaultEnabledForDiskEncryption bool = true

@description('Specifies whether the Azure Key Vault resource is enabled for template deployment.')
param keyVaultEnabledForTemplateDeployment bool = true

@description('Specifies whether the soft delete is enabled for this Azure Key Vault resource.')
param keyVaultEnableSoftDelete bool = true

@description('Specifies whether purge protection is enabled for this Azure Key Vault resource.')
param keyVaultEnablePurgeProtection bool = false

@description('Specifies whether enable the RBAC authorization for the Azure Key Vault resource.')
param keyVaultEnableRbacAuthorization bool = true

@description('Specifies the soft delete retention in days.')
param keyVaultSoftDeleteRetentionInDays int = 7

@description('Specifies the name of the Azure Container Registry resource.')
param acrName string = ''

@description('Enable admin user that have push / pull permission to the registry.')
param acrAdminUserEnabled bool = false

@description('Whether to allow public network access. Defaults to Enabled.')
@allowed([
  'Disabled'
  'Enabled'
])
param acrPublicNetworkAccess string = 'Disabled'

@description('Tier of your Azure Container Registry.')
@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param acrSku string = 'Premium'

@description('Specifies whether or not registry-wide pull is enabled from unauthenticated clients.')
param acrAnonymousPullEnabled bool = false

@description('Specifies whether or not a single data endpoint is enabled per region for serving data.')
param acrDataEndpointEnabled bool = false

@description('Specifies the network rule set for the container registry.')
param acrNetworkRuleSet object = {
  defaultAction: 'Deny'
}

@description('Specifies whether to allow trusted Azure services to access a network restricted registry.')
@allowed([
  'AzureServices'
  'None'
])
param acrNetworkRuleBypassOptions string = 'AzureServices'

@description('Specifies whether or not zone redundancy is enabled for this container registry.')
@allowed([
  'Disabled'
  'Enabled'
])
param acrZoneRedundancy string = 'Disabled'

@description('Specifies the name of the Azure Azure Storage Account resource resource.')
param storageAccountName string = ''

@description('Specifies whether to allow public network access for the storage account.')
@allowed([
  'Disabled'
  'Enabled'
])
param storageAccountPublicNetworkAccess string = 'Disabled'

@description('Specifies the access tier of the Azure Storage Account resource. The default value is Hot.')
param storageAccountAccessTier string = 'Hot'

@description('Specifies whether the Azure Storage Account resource allows public access to blobs. The default value is false.')
param storageAccountAllowBlobPublicAccess bool = false

@description('Specifies whether the Azure Storage Account resource allows shared key access. The default value is true.')
param storageAccountAllowSharedKeyAccess bool = false

@description('Specifies whether the Azure Storage Account resource allows cross-tenant replication. The default value is false.')
param storageAccountAllowCrossTenantReplication bool = false

@description('Specifies the minimum TLS version to be permitted on requests to the Azure Storage Account resource. The default value is TLS1_2.')
param storageAccountMinimumTlsVersion string = 'TLS1_2'

@description('The default action of allow or deny when no other rules match. Allowed values: Allow or Deny')
@allowed([
  'Allow'
  'Deny'
])
param storageAccountANetworkAclsDefaultAction string = 'Allow'

@description('Specifies whether the Azure Storage Account resource should only support HTTPS traffic.')
param storageAccountSupportsHttpsTrafficOnly bool = true

@description('Specifies the name of the existing virtual network to use for the private endpoints.')
param peVirtualNetworkName string = ''

@description('Specifies the name of the resource group hosting the existing virtual network.')
param peVirtualNetworkResourceGroupName string = resourceGroup().name

@description('Specifies the name of the subnet which contains the private endpoints.')
param peSubnetName string = 'services'

@description('Specifies the resource group where private DNS zones are created.')
param dnsZonesResourceGroupName string

@description('Specifies the name of the private endpoint to the blob storage account.')
param blobStorageAccountPrivateEndpointName string = ''

@description('Specifies the name of the private endpoint to the file storage account.')
param fileStorageAccountPrivateEndpointName string = ''

@description('Specifies the name of the private endpoint to the Key Vault.')
param keyVaultPrivateEndpointName string = ''

@description('Specifies the name of the private endpoint to the Azure Container Registry.')
param acrPrivateEndpointName string = ''

@description('Specifies the name of the private endpoint to the Azure Hub Workspace.')
param hubWorkspacePrivateEndpointName string = ''

@description('Specifies the name of the private endpoint to the Azure AI Services.')
param aiServicesPrivateEndpointName string = ''

@description('Specifies the name of the private endpoint to the Azure AI Search.')
param aiSearchPrivateEndpointName string = ''

@description('Specifies the name of the Azure AI Search resource.')
param aiSearchName string = ''

@description('Specifies whether to disable local authentication for Azure AI Search.')
param aiSearchDisableLocalAuth bool = true

@description('Specifies whether to allow public network access for Azure AI Search.')
@allowed([
  'Disabled'
  'Enabled'
])
param aiSearchPublicNetworkAccess string = 'Disabled'

@description('Specifies the resource tags for all the resoources.')
param tags object = {}

@description('Specifies the object id of a Microsoft Entra ID user. In general, this the object id of the system administrator who deploys the Azure resources.')
param userObjectId string = ''

// Existing resources
resource workspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' existing = {
  name: logAnalyticsName
  scope: resourceGroup(logAnalyticsResourceGroupName)
}

// Resources
module applicationInsights 'modules/applicationInsights.bicep' = {
  name: 'applicationInsights'
  params: {
    // properties
    name: empty(applicationInsightsName) ? toLower('${prefix}-app-insights-${suffix}') : applicationInsightsName
    location: location
    tags: tags
    workspaceId: workspace.id
  }
}

module keyVault 'modules/keyVault.bicep' = {
  name: 'keyVault'
  params: {
    // properties
    name: empty(keyVaultName) ? ('${prefix}-key-vault-${suffix}') : keyVaultName
    location: location
    tags: tags
    publicNetworkAccess: keyVaultPublicNetworkAccess
    networkAclsDefaultAction: keyVaultNetworkAclsDefaultAction
    enabledForDeployment: keyVaultEnabledForDeployment
    enabledForDiskEncryption: keyVaultEnabledForDiskEncryption
    enabledForTemplateDeployment: keyVaultEnabledForTemplateDeployment
    enablePurgeProtection: keyVaultEnablePurgeProtection
    enableRbacAuthorization: keyVaultEnableRbacAuthorization
    enableSoftDelete: keyVaultEnableSoftDelete
    softDeleteRetentionInDays: keyVaultSoftDeleteRetentionInDays
    workspaceId: workspace.id

    // role assignments
    userObjectId: userObjectId
  }
}

module containerRegistry 'modules/containerRegistry.bicep' = {
  name: 'containerRegistry'
  params: {
    // properties
    name: empty(acrName) ? toLower('${prefix}acr${suffix}') : acrName
    location: location
    tags: tags
    sku: acrSku
    adminUserEnabled: acrAdminUserEnabled
    anonymousPullEnabled: acrAnonymousPullEnabled
    dataEndpointEnabled: acrDataEndpointEnabled
    networkRuleBypassOptions: acrNetworkRuleBypassOptions
    networkRuleSet: acrNetworkRuleSet
    publicNetworkAccess: acrPublicNetworkAccess
    zoneRedundancy: acrZoneRedundancy
    workspaceId: workspace.id
  }
}

module storageAccount 'modules/storageAccount.bicep' = {
  name: 'storageAccount'
  params: {
    // properties
    name: empty(storageAccountName) ? toLower('${prefix}datastore${suffix}') : storageAccountName
    location: location
    tags: tags
    publicNetworkAccess: storageAccountPublicNetworkAccess
    accessTier: storageAccountAccessTier
    allowBlobPublicAccess: storageAccountAllowBlobPublicAccess
    allowSharedKeyAccess: storageAccountAllowSharedKeyAccess
    allowCrossTenantReplication: storageAccountAllowCrossTenantReplication
    minimumTlsVersion: storageAccountMinimumTlsVersion
    networkAclsDefaultAction: storageAccountANetworkAclsDefaultAction
    supportsHttpsTrafficOnly: storageAccountSupportsHttpsTrafficOnly
    workspaceId: workspace.id

    // role assignments
    userObjectId: userObjectId
    aiServicesPrincipalId: aiServices.outputs.principalId
  }
}

module aiServices 'modules/aiServices.bicep' = {
  name: 'aiServices'
  params: {
    // properties
    name: empty(aiServicesName) ? toLower('${prefix}-ai-services-${suffix}') : aiServicesName
    location: location
    tags: tags
    sku: aiServicesSku
    identity: aiServicesIdentity
    customSubDomainName: aiServicesCustomSubDomainName
    disableLocalAuth: aiServicesDisableLocalAuth
    publicNetworkAccess: aiServicesPublicNetworkAccess
    deployments: openAiDeployments
    workspaceId: workspace.id

    // role assignments
    userObjectId: userObjectId
  }
}

// Add AI Search module
module aiSearch 'br/public:avm/res/search/search-service:0.9.2' = {
  name: 'aiSearchDeployment'
  params: {
    name: empty(aiSearchName) ? toLower('${prefix}-ai-search-${suffix}') : aiSearchName
    location: location
    disableLocalAuth: aiSearchDisableLocalAuth
    publicNetworkAccess: aiSearchPublicNetworkAccess
    managedIdentities: {
      systemAssigned: true
    }
    roleAssignments: [
      {
        principalId: userObjectId
        roleDefinitionIdOrName: 'Search Service Contributor'
      }
      {
        principalId: userObjectId
        roleDefinitionIdOrName: 'Search Index Data Contributor'
      }
      {
        principalId: aiServices.outputs.principalId
        roleDefinitionIdOrName: 'Search Service Contributor'
      }
      {
        principalId: aiServices.outputs.principalId
        roleDefinitionIdOrName: 'Search Index Data Contributor'
      }
      {
        principalId: hub.outputs.principalId
        roleDefinitionIdOrName: 'Search Service Contributor'
      }
      {
        principalId: hub.outputs.principalId
        roleDefinitionIdOrName: 'Search Index Data Contributor'
      }
    ]
    tags: tags
  }
}

// Construct the resource ID of the existing virtual network
var peVirtualNetworkId = resourceId(peVirtualNetworkResourceGroupName, 'Microsoft.Network/virtualNetworks', peVirtualNetworkName)

// Reference the subnet ID of the existing virtual network
var peSubnetId = '${peVirtualNetworkId}/subnets/${peSubnetName}'

module privateEndpoints './modules/privateEndpoints.bicep' = {
  name: 'privateEndpoints'
  scope: resourceGroup(peVirtualNetworkResourceGroupName)
  params: {
    dnsZonesResourceGroupName: dnsZonesResourceGroupName
    subnetId: peSubnetId
    blobStorageAccountPrivateEndpointName: empty(blobStorageAccountPrivateEndpointName) ? toLower('${prefix}-blob-storage-pe-${suffix}') : blobStorageAccountPrivateEndpointName
    fileStorageAccountPrivateEndpointName: empty(fileStorageAccountPrivateEndpointName) ? toLower('${prefix}-file-storage-pe-${suffix}') : fileStorageAccountPrivateEndpointName
    keyVaultPrivateEndpointName: empty(keyVaultPrivateEndpointName) ? toLower('${prefix}-key-vault-pe-${suffix}') : keyVaultPrivateEndpointName
    acrPrivateEndpointName: empty(acrPrivateEndpointName) ? toLower('${prefix}-container-registry-pe-${suffix}') : acrPrivateEndpointName
    storageAccountId: storageAccount.outputs.id
    keyVaultId: keyVault.outputs.id
    acrId: containerRegistry.outputs.id
    createAcrPrivateEndpoint: containerRegistry.outputs.sku == 'Premium'
    hubWorkspacePrivateEndpointName: empty(hubWorkspacePrivateEndpointName) ? toLower('${prefix}-hub-workspace-pe-${suffix}') : hubWorkspacePrivateEndpointName
    hubWorkspaceId: hub.outputs.id
    aiServicesPrivateEndpointName: empty(aiServicesPrivateEndpointName) ? toLower('${prefix}-ai-services-pe-${suffix}') : aiServicesPrivateEndpointName
    aiServicesId: aiServices.outputs.id
    aiSearchId: aiSearch.outputs.resourceId
    aiSearchPrivateEndpointName: empty(aiSearchPrivateEndpointName) ? toLower('${prefix}-ai-search-pe-${suffix}') : aiSearchPrivateEndpointName
    location: location
    tags: tags
  }
}

// Update the hub module to include the AI Search connection
module hub 'modules/hub.bicep' = {
  name: 'hub'
  params: {
    // workspace organization
    name: empty(hubName) ? toLower('${prefix}-hub-${suffix}') : hubName
    friendlyName: hubFriendlyName
    description_: hubDescription
    location: location
    tags: tags

    // dependent resources
    aiServicesName: aiServices.outputs.name
    applicationInsightsId: applicationInsights.outputs.id
    containerRegistryId: containerRegistry.outputs.id
    keyVaultId: keyVault.outputs.id
    storageAccountId: storageAccount.outputs.id
    connectionAuthType: connectionAuthType
    systemDatastoresAuthMode: systemDatastoresAuthMode

    // workspace configuration
    publicNetworkAccess: hubPublicNetworkAccess
    isolationMode: hubIsolationMode
    workspaceId: workspace.id

    // role assignments
    userObjectId: userObjectId
  }
}

module project 'modules/project.bicep' = {
  name: 'project'
  params: {
    // workspace organization
    name: empty(projectName) ? toLower('${prefix}-project-${suffix}') : projectName
    friendlyName: projectFriendlyName
    location: location
    tags: tags

    // workspace configuration
    publicNetworkAccess: projectPublicNetworkAccess
    hubId: hub.outputs.id
    workspaceId: workspace.id

    // role assignments
    userObjectId: userObjectId
    aiServicesPrincipalId: aiServices.outputs.principalId
  }
}

output deploymentInfo object = {
  subscriptionId: subscription().subscriptionId
  resourceGroupName: resourceGroup().name
  location: location
  storageAccountName: storageAccount.outputs.name
  aiServicesName: aiServices.outputs.name
  aiServicesEndpoint: aiServices.outputs.endpoint
  hubName: hub.outputs.name
  projectName: project.outputs.name
}
