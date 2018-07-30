FROM microsoft/dotnet:2.1-sdk AS build

COPY Sample.Web.Api /src

WORKDIR /src

# Publish release version of App
RUN dotnet publish -c Release -o /app -f netcoreapp2.1


FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime

WORKDIR /app

COPY --from=build /app /app

ENTRYPOINT ["dotnet", "Sample.Web.Api.dll"]