using BackendAPI.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Добавляем контекст БД (самое важное изменение)
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

// Добавляем поддержку контроллеров
builder.Services.AddControllers();

// Добавляем OpenAPI/Swagger (оставляем вашу текущую реализацию)
builder.Services.AddOpenApi();

var app = builder.Build();

// Конфигурация middleware
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi(); // Оставляем вашу текущую реализацию
}

app.UseHttpsRedirection();

// Маппинг контроллеров (обязательно добавьте!)
app.MapControllers();

// Удалите или закомментируйте старый пример с WeatherForecast
// (оставьте только если вам нужен этот тестовый эндпоинт)
/*
app.MapGet("/weatherforecast", () =>
{
    var forecast = Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast
        (
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
})
.WithName("GetWeatherForecast");
*/

app.Run();

// Можно удалить этот record, если он не нужен
// record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
// {
//     public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
// }