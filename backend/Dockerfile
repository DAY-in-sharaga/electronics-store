FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /app

# Копируем .sln и csproj
COPY *.sln .
COPY Store.Application/*.csproj ./Store.Application/
COPY Store.Domain/*.csproj ./Store.Domain/
COPY Store.Persistence/*.csproj ./Store.Persistence/
COPY Presentation/*.csproj ./Presentation/

RUN dotnet restore

# Копируем ВСЕ файлы проекта
COPY . .

# Копируем миграции из проекта Persistence
COPY Store.Persistence/Migrations ./Store.Persistence/Migrations

RUN dotnet publish Presentation/BackendAPI.csproj -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "BackendAPI.dll"]
