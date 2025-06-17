using Store.Domain;

public class Favorite
{
    public Guid FavoriteId { get; set; }
    public Guid UserId { get; set; }
    public Guid ProductId { get; set; }
    public User User { get; set; }
    public Product Product { get; set; }
}
