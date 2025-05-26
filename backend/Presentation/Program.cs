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
            var builder = WebApplication.CreateBuilder(args);

            // ��������� ����������� ��� ������ �����������
            builder.Logging.ClearProviders();
            builder.Logging.AddConsole();

            // �������� ������������
            var configuration = builder.Configuration;

            // ��������� AutoMapper
            builder.Services.AddAutoMapper(config =>
            {
                config.AddProfile(
                    new AssemblyMappingProfile(Assembly.GetExecutingAssembly()));
                config.AddProfile(
                    new AssemblyMappingProfile(typeof(IStoreDbContext).Assembly));
            });

            // ����������� ������������
            builder.Services.AddApplication();
            builder.Services.AddPersistence(builder.Configuration);
            builder.Services.AddControllers();

            // ��������� CORS
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll", policy =>
                {
                    policy.AllowAnyHeader();
                    policy.AllowAnyMethod();
                    policy.AllowAnyOrigin();
                });
            });

            // ��������� ��������� �� � ��������� �����������
            var connectionString = configuration.GetConnectionString("DefaultConnection")
                ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");

            builder.Services.AddDbContext<StoreDbContext>(options =>
            {
                options.UseNpgsql(connectionString,
                    npgsqlOptions => npgsqlOptions.EnableRetryOnFailure(5, TimeSpan.FromSeconds(10), null));
                options.LogTo(Console.WriteLine, LogLevel.Information);
            });

            var app = builder.Build();

            // ��������� middleware
            if (app.Environment.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                // � production ����� ���� ����� ��� ������������� PostgreSQL
                Console.WriteLine("Waiting for database to be ready...");
                Thread.Sleep(10000);
            }

            app.UseHttpsRedirection();
            app.UseRouting();
            app.UseCors("AllowAll");
            app.MapControllers();

            // �������� � ������������� ��
            using (var scope = app.Services.CreateScope())
            {
                var services = scope.ServiceProvider;
                var logger = services.GetRequiredService<ILogger<Program>>();

                try
                {
                    var context = services.GetRequiredService<StoreDbContext>();

                    logger.LogInformation("Attempting database migration...");

                    // �������� ��������� �������� � ���������� ���������
                    var retryCount = 0;
                    while (retryCount < 5)
                    {
                        try
                        {
                            context.Database.Migrate();
                            DbInitializer.Initialize(context);
                            logger.LogInformation("Database migration succeeded");
                            break;
                        }
                        catch (Npgsql.NpgsqlException ex) when (retryCount < 4)
                        {
                            retryCount++;
                            logger.LogWarning($"Migration attempt {retryCount}/5 failed: {ex.Message}");
                            Thread.Sleep(5000 * retryCount);
                        }
                    }
                }
                catch (Exception ex)
                {
                    logger.LogError(ex, "An error occurred while migrating or initializing the database");
                    throw;
                }
            }
            app.Run();
        }
    }
}
