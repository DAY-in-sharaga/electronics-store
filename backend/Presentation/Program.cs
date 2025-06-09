using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Store.Application;
using Store.Application.Common.Mappings;
using Store.Application.Interfaces;
using Store.Persistence;
using System.Reflection;

namespace Store.WebApi
{
    public class Program
    {
        public static void Main(string[] args)
        {

            var config = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                .AddEnvironmentVariables()
                .Build();

            var builder = WebApplication.CreateBuilder(new WebApplicationOptions
            {
                Args = args,
                ContentRootPath = Directory.GetCurrentDirectory(),
                EnvironmentName = config["ASPNETCORE_ENVIRONMENT"] ?? "Development"
            });

            builder.Configuration.AddConfiguration(config);

            builder.Services.AddAutoMapper(config =>
            {
                config.AddProfile(
                    new AssemblyMappingProfile(Assembly.GetExecutingAssembly()));
                config.AddProfile(
                    new AssemblyMappingProfile(typeof(IStoreDbContext).Assembly));
            });
            builder.Services.AddApplication();
            builder.Services.AddPersistence(builder.Configuration);
            builder.Services.AddControllers();
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll", policy =>
                {
                    policy.AllowAnyHeader();
                    policy.AllowAnyMethod();
                    policy.AllowAnyOrigin();
                });
            });

            var app = builder.Build();
            if (app.Environment.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            app.UseHttpsRedirection();
            app.UseRouting();
            app.UseCors("AllowAll");
            app.MapControllers();

            app.MapGet("/health", () => Results.Ok());

            app.MapGet("/test", () => "API is working!");

            using (var scope = app.Services.CreateScope())
            {
                var services = scope.ServiceProvider;
                try
                {
                    // Добавьте логгирование строки подключения
                    var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
                    Console.WriteLine($"Using connection string: {connectionString}");

                    var context = services.GetRequiredService<StoreDbContext>();
                    if (context.Database.CanConnect())
                    {
                        Console.WriteLine("Database exists, applying migrations...");
                        context.Database.Migrate();
                    }
                    else
                    {
                        Console.WriteLine("Cannot connect to database!");
                    }
                    DbInitializer.Initialize(context);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Migration failed: " + ex.Message);
                    Console.WriteLine(ex.StackTrace);
                    throw;
                }
            }

            app.MapGet("/dbcheck", async (StoreDbContext dbContext) =>
            {
                try
                {
                    var canConnect = await dbContext.Database.CanConnectAsync();
                    return Results.Ok(new { db_available = canConnect });
                }
                catch (Exception ex)
                {
                    return Results.Problem(ex.Message);
                }
            });

            app.Run();
        }
    }
}