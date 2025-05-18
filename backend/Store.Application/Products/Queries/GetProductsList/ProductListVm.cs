using System.Collections.Generic;

namespace Store.Application.Products.Queries.GetProductsList
{
    public class ProductListVm
    {
        public IList<ProductLookupDto> Products { get; set; } = new List<ProductLookupDto>();
    }
}
