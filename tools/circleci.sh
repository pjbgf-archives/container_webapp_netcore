# Script under MIT License
# Original source from: https://raw.githubusercontent.com/pliyosan/create-tokens-variables-in-circle-ci/master/circleci.sh

#!/bin/bash
set -euo pipefail

# Set all non-sensitive variables here:
declare variables='DEPLOY_CI_RESOURCE_GROUP=ci-container-appservice-euw
DEPLOY_CI_LOCATION=westeurope
DEPLOY_CI_WEBAPP_NAME=ci-container-appservice
DOCKER_REGISTRY_URI=https://pjbgf.azurecr.io
DOCKER_IMAGE_NAME_WITH_REGISTRY=pjbgf.azurecr.io/sample/container-appservice'

# For all sensitive variables below, call command line separately, this will help you not to commit secrets into your repo. :)
#
# sh circleci.sh -t <circleCiToken> -a <githubAccountName> -p <projectName> -v "DEPLOY_CI_SUBSCRIPTION_ID=<YOUR_SUB_ID>"
# sh circleci.sh -t <circleCiToken> -a <githubAccountName> -p <projectName> -v "DOCKER_REGISTRY_SERVER_USERNAME=<CR_USER_NAME>"
# sh circleci.sh -t <circleCiToken> -a <githubAccountName> -p <projectName> -v "DOCKER_REGISTRY_SERVER_PASSWORD=<CR_USER_PASSWORD>"
# sh circleci.sh -t <circleCiToken> -a <githubAccountName> -p <projectName> -v "SERVICE_PRINCIPAL=<SERVICE_PRINCIPAL_APP_ID>"
# sh circleci.sh -t <circleCiToken> -a <githubAccountName> -p <projectName> -v "SERVICE_PRINCIPAL_PASS=<SERVICE_PRINCIPAL_SECRET>"
# sh circleci.sh -t <circleCiToken> -a <githubAccountName> -p <projectName> -v "SERVICE_TENANT=<SERVICE_TENANT>"


usage() { echo "Usage: $0 -t <circleCiToken> -a <githubAccountName> -p <projectName> -v <key1=value1 key2=value2>" 1>&2; exit 1; }

declare circleCiToken=""
declare githubAccountName=""
declare projectName=""

# Initialize parameters specified from command line
while getopts ":t:a:p:v:" arg; do
	case "${arg}" in
		t)
			circleCiToken=${OPTARG}
			;;
		a)
			githubAccountName=${OPTARG}
			;;
		p)
			projectName=${OPTARG}
			;;
		v)
			variables=${OPTARG}
			;;
		esac
done
shift $((OPTIND-1))

#Prompt for parameters if some required parameters are missing
if [[ -z "$circleCiToken" ]]; then
	echo "Circle CI Token:"
	read circleCiToken
	[[ "${circleCiToken:?}" ]]
fi

if [[ -z "$githubAccountName" ]]; then
        echo "Github Account Name:"
        read githubAccountName
        [[ "${githubAccountName:?}" ]]
fi

if [[ -z "$projectName" ]]; then
        echo "Project Name:"
        read projectName
        [[ "${projectName:?}" ]]
fi


posturl="https://circleci.com/api/v1.1/project/github/$githubAccountName/$projectName/envvar?circle-token=$circleCiToken"


echo "Loading environment variables into project $githubAccountName/$projectName:"

for variable in $variables;
do
    
    set -- `echo $variable | tr '=' ' '`
    curl -X POST --header "Content-Type: application/json" -d "{\"name\":\"$1\", \"value\":\"$2\"}" $posturl

done

echo
if [ $?  == 0 ];
 then
	echo "Environment variables loaded successfully."
fi
