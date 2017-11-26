[![CircleCI](https://circleci.com/gh/pjbgf/container_webapp_netcore.svg?style=svg)](https://circleci.com/gh/pjbgf/container_webapp_netcore) 
[![License](http://img.shields.io/:license-mit-blue.svg)](http://pjbgf.mit-license.org)  

## What's in the box?

This is a sample of a walking skeleton .Net Core 2.0 web API, deployed as a docker container on Azure App Service. 

- Language: C#
- Platform: .Net Core 2.0
- Compute: Docker Container running on Azure App Service
- Telemetry: AppInsights
- Container Registry: Azure Container Registry

The infrastructure required is defined as code, using ARM templates. The deployment pipeline is also defined as code using yml with CircleCI.

## CI Pipeline

The setup also includes a CircleCI pipeline with the following steps:

1. Build
    1. Restore 
    1. Build 
    1. Run unit tests
    1. Generate Docker Image
    1. Push Docker Image to Azure Private Registry
2. Provision CI Environment  
    2. Deploy ARM template  
    2. Forces Container-mode on AppService (not fully compatible with ARM at the moment)
3. Smoke Test CI  
    3. Http Request onto health check end-point
4. Delete CI Environment 

  
## Requirements  

- Azure Subscription
- Azure Container Registry
- Service Principal for the Azure Subscription
- Github account (free)
- CircleCI account (free)


## CI Variables

In order for this example to work, your circle CI project will require the following variables:

| Name        | Description | Example |  
| ----------- | ----------- | ----------- |   
| DEPLOY_CI_RESOURCE_GROUP | Name for resource group | ci-myapp-euw |
| DEPLOY_CI_LOCATION | Location to create the resource group | West Europe |
| DEPLOY_CI_SUBSCRIPTION_ID | Azure subscription id | < GUID > |	
| DEPLOY_CI_WEBAPP_NAME | CI name of your web app. | *ci-myapp-euw*.azurewebsites.net |
| DOCKER_REGISTRY_URI | Uri for your Azure Container Registry | https://name-goes-here.azurecr.io |
| DOCKER_IMAGE_NAME_WITH_REGISTRY | Fully qualified image name. | name-goes-here.azurecr.io/foldername/imagename:tag |
| DOCKER_REGISTRY_SERVER_USERNAME | User name to login onto the registry | Generally it is the same name as the registry. |
| DOCKER_REGISTRY_SERVER_PASSWORD | Password to login onto the registry | Be creative. ;) |
| SERVICE_PRINCIPAL | Name of your service principal account | circleci_deployment_account |
| SERVICE_PRINCIPAL_PASS | Password for your service principal account | <Some random, big and complex string.> |
| SERVICE_TENANT | Tenant Id of your azure active directory | < GUID > |

To setup the variables more easily use the script [tools/circleci.sh](tools/circleci.sh).


## Testing it locally  
**Deploying ARM template**
```
./deploy.sh -i SUBSCRIPTION_ID -g ci-container-appservice -n manual -l northeurope
```
**Running the container locally**
```
docker run -d -p 8000:80 YOUR_CR_NAME.azurecr.io/sample/container-appservice
```
Once the command finishes you should be able to access it through the URL: http://localhost:8000/health

## Roadmap

- BDD framework to replace curl smoke test with Gherkin spec and prepare the project for ATDD approach.
- Secret Management for development environments.
- KeyVault for non-dev environments.
- Paired-regions.
- Traffic Manager.