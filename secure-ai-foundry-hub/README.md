# IaC Templates

## Introduction
This project is a collection of Infrastructure as Code (IaC) templates for creating a secure AI Foundry Hub.  This Hub will use private networking and managed identities and avoid public networkng and key management where possible.

## Disclaimer
**This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment. THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED 'AS IS' WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.**

## Resources
This template will create
- Azure AI Foundry Hub
- Azure AI Services
- Azure AI Search
- Azure Container Registry
- Azure Key Vault
- Azure Storage Account
- Azure Application Insights
- Private Endpoints
- Role Assignments

The template assumes the existince of:
- Virtual Network
- Private DNS Zones
- Log Analytics Workspace

## Deploy
First you need to create a bicep parameters file.
- If you have the Bicep extension, you can right click main and choose Generate Parametes File.

Then deploy the main.bicep file.
- Again, with the Bicep extension you can right click and then follow the prompts to supply your subscription and resource group and select the parameters file.

## Ackowledgements
This project was inspired by [Azure Quick Start Templates](https://github.com/Azure/azure-quickstart-templates), specifically [Deploy Secure Azure AI Foundry with a managed virtual network](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-networking-aoao). We have adapted a portion of their work to build upon and extend it for our specific use case. Special thanks to the contributors of the original repository for their valuable work.