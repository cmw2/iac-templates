// @description('Specifies the name of the Azure Machine Learning Compute resource.')
// param name string

// @description('Specifies the location of the Azure Machine Learning Compute resource.')
// param location string

// @description('Specifies the size of the Azure Machine Learning Compute cluster.')
// param vmSize string

// @description('Specifies the minimum number of nodes for the compute cluster.')
// param minNodes int

// @description('Specifies the maximum number of nodes for the compute cluster.')
// param maxNodes int

// @description('Specifies the resource tags.')
// param tags object

// resource mlCompute 'Microsoft.MachineLearningServices/workspaces/computes@2023-04-01' = {
//   name: name
//   location: location
//   tags: tags
//   properties: {
//     computeType: 'AmlCompute'
//     vmSize: vmSize
//     scaleSettings: {
//       minNodeCount: minNodes
//       maxNodeCount: maxNodes
//     }
//   }
// }

// output id string = mlCompute.id
