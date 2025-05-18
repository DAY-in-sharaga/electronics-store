using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Store.Domain;

namespace Store.Persistence.EntityTypeConfigurations
{
    internal class UserConfiguration : IEntityTypeConfiguration<User>
    {
        public void Configure(EntityTypeBuilder<User> builder)
        {
            builder.HasKey(user => user.UserId);
            builder.HasIndex(user => user.UserId).IsUnique();
            builder.Property(user => user.Name).IsRequired().HasMaxLength(100);
            builder.Property(user => user.Email).IsRequired().HasMaxLength(150);
            builder.Property(user => user.PasswordHash).IsRequired().HasMaxLength(256);

            builder.HasMany(user => user.Orders)
                   .WithOne()
                   .HasForeignKey(order => order.UserId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
