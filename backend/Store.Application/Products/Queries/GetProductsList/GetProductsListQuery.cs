using MediatR;
using Store.Application.Products.Queries.GetProductsList;

namespace Store.Application.Notes.Queries.GetNoteList
{
    public class GetProductsListQuery : IRequest<ProductListVm>
    {
        public List<string> CategoryNameList {get; set; }
    }
}

