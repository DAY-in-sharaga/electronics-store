FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /src
COPY ["BackendAPI.csproj", "."]
RUN dotnet restore "BackendAPI.csproj"
COPY . .
RUN dotnet publish "BackendAPI.csproj" -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview
WORKDIR /app
COPY --from=build /app .
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "BackendAPI.dll"]