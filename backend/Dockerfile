# Используем официальный .NET SDK для сборки
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build

WORKDIR /app

# Копируем .sln и все csproj
COPY *.sln ./
COPY Store.Application/*.csproj ./Store.Application/
COPY Store.Domain/*.csproj ./Store.Domain/
COPY Store.Persistence/*.csproj ./Store.Persistence/
COPY Presentation/*.csproj ./Presentation/

# Восстанавливаем зависимости
RUN dotnet restore

# Копируем весь остальной код
COPY . .

# Публикуем приложение
RUN dotnet publish Presentation/BackendAPI.csproj -c Release -o out

# Используем runtime образ для запуска
FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Запускаем
ENTRYPOINT ["dotnet", "BackendAPI.dll"]