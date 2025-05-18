using MediatR;
using Store.Application.Products.Queries.GetProductsList;

namespace Store.Application.Notes.Queries.GetNoteList
{
    public class GetProductsListQuery : IRequest<ProductListVm>
    {
        public string CategoryName { get; set; }
    }
}

