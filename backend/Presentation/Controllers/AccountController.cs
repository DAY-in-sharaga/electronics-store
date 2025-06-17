using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Store.Application.Interfaces;
using Store.Domain;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

[Route("[controller]/[action]")]
public class AccountController : Controller
{
    private readonly IStoreDbContext _db;

    public AccountController(IStoreDbContext db)
    {
        _db = db;
    }

    [HttpPost]
    public async Task<IActionResult> Register(string name, string email, string password) // Атрибут [FromBody]!
    {
        if (ModelState.IsValid) // Очень важно проверять валидность модели!
        {
            if (_db.Users.Any(u => u.Email == email))
                return BadRequest("User already exists");

            var user = new User
            {
                UserId = Guid.NewGuid(),
                Name = name,
                Email = email,
                PasswordHash = HashPassword(password)
            };

            _db.Users.Add(user);
            await _db.SaveChangesAsync(CancellationToken.None);
            return Ok();
        }

        return BadRequest(ModelState); // Вернуть ошибки валидации
    }

    [HttpPost]
    public async Task<IActionResult> Login(string email, string password)
    {
        var user = _db.Users.FirstOrDefault(u => u.Email == email);
        if (user == null || user.PasswordHash != HashPassword(password))
            return Unauthorized();

        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Name, user.Name),
            new Claim(ClaimTypes.Email, user.Email)
        };
        var claimsIdentity = new ClaimsIdentity(claims, "Cookies");
        await HttpContext.SignInAsync("Cookies", new ClaimsPrincipal(claimsIdentity));
        return Ok();
    }

    [HttpPost]
    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync("Cookies");
        return Ok();
    }

    private string HashPassword(string password)
    {
        using var sha256 = SHA256.Create();
        var bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
        return Convert.ToBase64String(bytes);
    }
}
