using System.Threading.Tasks;
using System.Threading;
using Microsoft.EntityFrameworkCore;
using Store.Domain;
namespace Store.Application.Interfaces
{
    public interface IStoreDbContext
    {
        Task<int> SaveChangesAsync(CancellationToken cancellationToken);
        DbSet<User> Users { get; set; }
        DbSet<Order> Orders { get; set; }
        DbSet<Product> Products { get; set; }
        DbSet<Category> Categories { get; set; }
    }
}

