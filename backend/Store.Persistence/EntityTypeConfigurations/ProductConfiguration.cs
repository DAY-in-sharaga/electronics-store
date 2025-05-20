
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Store.Domain;

namespace Store.Persistence.EntityTypeConfigurations
{
    internal class ProductConfiguration : IEntityTypeConfiguration<Product>
    {
        public void Configure(EntityTypeBuilder<Product> builder)
        {
            builder.HasKey(product => product.ProductId);
            builder.HasIndex(product => product.ProductId).IsUnique();
            builder.Property(product => product.Name).IsRequired().HasMaxLength(150);
            builder.Property(product => product.Description).HasMaxLength(1000);
            builder.Property(product => product.Price).IsRequired().HasColumnType("decimal(18,2)");
            builder.Property(product => product.Stock).IsRequired().HasDefaultValue(0);
            builder.HasMany(product => product.CategoryList)
                   .WithMany(category => category.ProductList);
        }
    }
}
