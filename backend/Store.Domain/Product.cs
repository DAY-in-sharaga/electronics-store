using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Store.Domain
{
    public class Product
    {
        public Guid ProductId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public Dictionary<string, string> Characteristics { get; set; }
        public Guid CategoryId { get; set; }
        public Category Category { get; set; }
        public string ImageUrl { get; set; }
        public decimal Price { get; set; }
    }
}
