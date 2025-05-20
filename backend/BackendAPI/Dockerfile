FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /src
COPY . .
RUN dotnet restore && dotnet publish -c Release -o /app

RUN dotnet tool install --global dotnet-ef --version 9.0.0-preview.7.24508.1

FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview
WORKDIR /app
COPY --from=build /app .
COPY --from=build /root/.dotnet/tools /root/.dotnet/tools

ENV PATH="/root/.dotnet/tools:${PATH}"
ENV ASPNETCORE_URLS="http://+:8080"
ENV DOTNET_ROLL_FORWARD=Major

ENTRYPOINT ["sh", "-c", "dotnet ef database update && dotnet BackendAPI.dll"]