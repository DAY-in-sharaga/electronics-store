// Store.Domain/Cart.cs
using Store.Domain;

public class Cart
{
    public Guid CartId { get; set; }
    public Guid UserId { get; set; }
    public List<CartItem> Items { get; set; } = new();
}

// Store.Domain/CartItem.cs
public class CartItem
{
    public Guid CartItemId { get; set; }
    public Guid ProductId { get; set; }
    public int Quantity { get; set; }
    public Guid CartId { get; set; }
    public Cart Cart { get; set; }
    public Product Product { get; set; }
}
