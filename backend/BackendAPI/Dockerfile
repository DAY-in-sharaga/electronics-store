FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /src
COPY ["BackendAPI.csproj", "."]
RUN dotnet restore "BackendAPI.csproj"
COPY . .
RUN dotnet publish "BackendAPI.csproj" -c Release -o /app

# Установка EF Core Tools с явным указанием версии
RUN dotnet tool install --global dotnet-ef --version 9.0.0-preview.*

FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app
COPY --from=build /app .
COPY --from=build /root/.dotnet/tools /root/.dotnet/tools

# Важно для .NET 9 Preview
ENV DOTNET_ROLL_FORWARD=Major
ENV PATH="${PATH}:/root/.dotnet/tools"

# Добавляем healthcheck
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -f http://localhost:8080/health || exit 1

ENTRYPOINT ["sh", "-c", "dotnet ef database update && dotnet BackendAPI.dll"]