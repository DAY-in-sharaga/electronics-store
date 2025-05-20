FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /src
COPY ["BackendAPI.csproj", "."]
RUN dotnet restore "BackendAPI.csproj"
COPY . .
RUN dotnet publish "BackendAPI.csproj" -c Release -o /app

RUN dotnet tool install --global dotnet-ef

FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app
COPY --from=build /app .
COPY --from=build /root/.dotnet/tools /root/.dotnet/tools

ENV PATH="${PATH}:/root/.dotnet/tools"

ENTRYPOINT ["sh", "-c", "dotnet ef database update && dotnet BackendAPI.dll"]