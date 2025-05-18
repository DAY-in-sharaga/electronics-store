using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Store.Domain;

namespace Store.Persistence.EntityTypeConfigurations
{
    internal class OrderConfiguration : IEntityTypeConfiguration<Order>
    {
        public void Configure(EntityTypeBuilder<Order> builder)
        {
            builder.HasKey(order => order.OrderId);
            builder.HasIndex(order => order.OrderId).IsUnique();
            builder.Property(order => order.CreationDate).IsRequired();
            builder.Property(order => order.Status).IsRequired().HasMaxLength(50);
            builder.Property(order => order.TotalAmount).IsRequired().HasColumnType("decimal(18,2)");
            builder.Property(order => order.ShippingAddres).IsRequired().HasMaxLength(250);
        }
    }
}