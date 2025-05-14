using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Store.Domain
{
    public class Order
    {
        public Guid OrderId { get; set; }
        public Guid UserId { get; set; }
        public DateTime CreationDate { get; set; }
        public string Status {  get; set; }
        public List<Product> Products { get; set; }
        public decimal TotalAmount { get; set; }
        public string ShippingAddres { get; set; }
    }
}
