# This approach feels faster then the provided as example on Docker website using multi staged builds.
# https://docs.docker.com/engine/examples/dotnetcore/
# 
# Potentially something to review at a later stage.

dotnet publish src/Sample.Web.Api/Sample.Web.Api.csproj -c Release -f netcoreapp2.0

cp src/Dockerfile src/Sample.Web.Api/bin/Release/netcoreapp2.0/publish/

docker build --rm --no-cache -t pjbgf.azurecr.io/sample/container-appservice src/Sample.Web.Api/bin/Release/netcoreapp2.0/publish/