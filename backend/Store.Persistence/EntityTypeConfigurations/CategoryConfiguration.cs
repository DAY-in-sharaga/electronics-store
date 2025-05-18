using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Store.Domain;

namespace Store.Persistence.EntityTypeConfigurations
{
    internal class CategoryConfiguration : IEntityTypeConfiguration<Category>
    {
        public void Configure(EntityTypeBuilder<Category> builder)
        {
            builder.HasKey(category => category.CategoryId);
            builder.HasIndex(category => category.CategoryId).IsUnique();
            builder.Property(category => category.Name).IsRequired().HasMaxLength(100);
            builder.HasMany(category => category.Products)
                   .WithOne(product => product.Category)
                   .HasForeignKey(product => product.CategoryId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}