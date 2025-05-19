using BackendAPI.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// ��������� �������� �� (����� ������ ���������)
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

// ��������� ��������� ������������
builder.Services.AddControllers();

// ��������� OpenAPI/Swagger (��������� ���� ������� ����������)
builder.Services.AddOpenApi();

var app = builder.Build();

// ������������ middleware
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi(); // ��������� ���� ������� ����������
}

app.UseHttpsRedirection();

// ������� ������������ (����������� ��������!)
app.MapControllers();

// ������� ��� ��������������� ������ ������ � WeatherForecast
// (�������� ������ ���� ��� ����� ���� �������� ��������)
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

// ����� ������� ���� record, ���� �� �� �����
// record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
// {
//     public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
// }