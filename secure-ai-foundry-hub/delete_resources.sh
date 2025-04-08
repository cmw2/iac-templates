#!/bin/bash

# Ensure the script exits on errors
set -e

# Disable Git Bash path conversion
export MSYS_NO_PATHCONV=1

# Check if the resource group is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <resource-group-name>"
  exit 1
fi

RESOURCE_GROUP=$1

# Warning message
echo "WARNING: This script will delete the following types of resources in the resource group '$RESOURCE_GROUP':"
echo "  - AI Foundry Projects"
echo "  - AI Foundry Hubs"
echo "  - Azure AI Services"
echo "  - Azure Container Registries"
echo "  - Azure Key Vaults"
echo "  - Azure Storage Accounts"
echo "  - Azure Application Insights"
echo "  - Action Groups"
echo "  - Smart Detector Alert Rules"
echo "  - Azure Search Services"
echo "  - Private Endpoints"
echo ""
echo "This script will delete ALL resources of these types in the specified resource group, not just those created by the Bicep file."
read -p "Are you sure you want to proceed? (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Aborting script."
  exit 0
fi

# Function to delete resources by type and kind
delete_resources_by_type_and_kind() {
  local resource_type=$1
  local resource_kind=$2
  echo "Fetching resources of type: $resource_type and kind: $resource_kind"

  # Fetch the resource list, filtering by kind only if it is provided
  if [ -n "$resource_kind" ]; then
    echo "Filtering by kind: $resource_kind"
    mapfile -t resources < <(az resource list --resource-group "$RESOURCE_GROUP" --resource-type "$resource_type" --query "[?kind=='$resource_kind'].{name:name, id:id}" -o tsv)
  else
    mapfile -t resources < <(az resource list --resource-group "$RESOURCE_GROUP" --resource-type "$resource_type" --query "[].{name:name, id:id}" -o tsv)
  fi

  # Check if any resources were found
  if [ ${#resources[@]} -eq 0 ]; then
    echo "No resources found for type: $resource_type and kind: $resource_kind"
    return
  fi

  # Iterate over the resources and delete them
  for resource in "${resources[@]}"; do
    resource_name=$(echo "$resource" | cut -f1)
    resource_id=$(echo "$resource" | cut -f2)
    echo "Deleting resource: Name=$resource_name, ID=$resource_id"
    az resource delete --ids "$resource_id"
  done
}

# Delete AI Foundry Projects first
delete_resources_by_type_and_kind "Microsoft.MachineLearningServices/workspaces" "Project"

# Delete AI Foundry Hubs next
delete_resources_by_type_and_kind "Microsoft.MachineLearningServices/workspaces" "Hub"

# Delete other resources in the specified order
delete_resources_by_type_and_kind "Microsoft.CognitiveServices/accounts" ""                  # Azure AI Services
delete_resources_by_type_and_kind "Microsoft.ContainerRegistry/registries" ""                # Azure Container Registry
delete_resources_by_type_and_kind "Microsoft.KeyVault/vaults" ""                             # Azure Key Vault
delete_resources_by_type_and_kind "Microsoft.Storage/storageAccounts" ""                     # Azure Storage
delete_resources_by_type_and_kind "Microsoft.Insights/components" ""                         # Azure Application Insights
delete_resources_by_type_and_kind "Microsoft.Insights/actionGroups" ""                       # Action Group
delete_resources_by_type_and_kind "Microsoft.AlertsManagement/smartDetectorAlertRules" ""    # Smart Detector Alert Rule
delete_resources_by_type_and_kind "Microsoft.Search/searchServices" ""                       # Azure Search
delete_resources_by_type_and_kind "Microsoft.Network/privateEndpoints" ""                    # Private Endpoint

echo "All specified resources in resource group '$RESOURCE_GROUP' have been processed."