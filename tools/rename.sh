#!/bin/bash

declare new_project_name=$1
declare sed_expression="s/Sample/$new_project_name/g"

echo Renaming project from Sample to $new_project_name...


mv src/Sample.Tests src/$new_project_name.Tests
mv src/Sample.Web.Api src/$new_project_name.Web.Api
mv src/Sample.sln src/$new_project_name.sln
mv src/$new_project_name.Tests/Sample.Tests.csproj src/$new_project_name.Tests/$new_project_name.Tests.csproj
mv src/$new_project_name.Web.Api/Sample.Web.Api.csproj src/$new_project_name.Web.Api/$new_project_name.Web.Api.csproj


sed -i .bkp $sed_expression src/Dockerfile
rm src/Dockerfile.bkp

sed -i .bkp $sed_expression .circleci/config.yml
rm .circleci/config.yml.bkp

sed -i .bkp $sed_expression src/$new_project_name.sln
rm src/$new_project_name.sln.bkp

sed -i .bkp $sed_expression src/$new_project_name.Tests/$new_project_name.Tests.csproj
rm src/$new_project_name.Tests/$new_project_name.Tests.csproj.bkp

sed -i .bkp $sed_expression **/*.cs
rm **/*.cs.bkp


echo Renaming finished. To rollback changes, use the commands below:
echo git reset HEAD --hard
echo rm -f -d -r src/$new_project_name.Tests/
echo rm -f -d -r src/$new_project_name.Web.Api/
echo rm src/$new_project_name.sln
