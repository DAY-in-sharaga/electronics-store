using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Store.Application.Interfaces;
using Store.Domain;
using System.Security.Claims;

[Route("[controller]/[action]")]
[ApiController]
[Authorize]
public class FavoriteController : ControllerBase
{
    private readonly IStoreDbContext _db;

    public FavoriteController(IStoreDbContext db)
    {
        _db = db;
    }

    // Добавить в избранное
    [HttpPost]
    public async Task<IActionResult> Add([FromBody] AddFavoriteDto dto)
    {
        var userEmail = User.FindFirstValue(ClaimTypes.Email);
        var user = _db.Users.FirstOrDefault(u => u.Email == userEmail);
        if (user == null)
            return Unauthorized();

        if (string.IsNullOrWhiteSpace(dto.ProductName))
            return BadRequest("ProductName is required");

        var product = _db.Products.FirstOrDefault(p => p.Name == dto.ProductName);
        if (product == null)
            return NotFound("Product with this name not found");

        if (_db.Favorites.Any(f => f.UserId == user.UserId && f.ProductId == product.ProductId))
            return BadRequest("Product already in favorites");

        var favorite = new Favorite
        {
            FavoriteId = Guid.NewGuid(),
            UserId = user.UserId,
            ProductId = product.ProductId
        };

        _db.Favorites.Add(favorite);
        await _db.SaveChangesAsync(CancellationToken.None);

        return Ok();
    }


    // Получить все избранные товары пользователя
    [HttpGet]
    public IActionResult List()
    {
        var userEmail = User.FindFirstValue(ClaimTypes.Email);
        var user = _db.Users.FirstOrDefault(u => u.Email == userEmail);
        if (user == null)
            return Unauthorized();

        var favorites = _db.Favorites
            .Where(f => f.UserId == user.UserId)
            .Select(f => f.Product)
            .ToList();

        return Ok(favorites);
    }

    // Удалить товар из избранного
    [HttpDelete("{productName}")]
    public async Task<IActionResult> Remove(string productName)
    {
        var userEmail = User.FindFirstValue(ClaimTypes.Email);
        var user = _db.Users.FirstOrDefault(u => u.Email == userEmail);
        if (user == null)
            return Unauthorized();

        if (string.IsNullOrWhiteSpace(productName))
            return BadRequest("ProductName is required");

        var product = _db.Products.FirstOrDefault(p => p.Name == productName);
        if (product == null)
            return NotFound("Product with this name not found");

        var favorite = _db.Favorites.FirstOrDefault(f => f.UserId == user.UserId && f.ProductId == product.ProductId);
        if (favorite == null)
            return NotFound("Product is not in favorites");

        _db.Favorites.Remove(favorite);
        await _db.SaveChangesAsync(CancellationToken.None);

        return Ok();
    }

}
