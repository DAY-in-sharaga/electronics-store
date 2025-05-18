using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Store.Application.Products.Queries.GetProductsList;
using Store.Application.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using AutoMapper;
using AutoMapper.QueryableExtensions;

namespace Store.Application.Notes.Queries.GetNoteList
{
    public class GetProductsListQueryHandler : IRequestHandler<GetProductsListQuery, ProductListVm>
    {
        private readonly IStoreDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetProductsListQueryHandler(IStoreDbContext context, IMapper mapper)
        {
            _dbContext = context;
            _mapper = mapper;
        }

        public async Task<ProductListVm> Handle(GetProductsListQuery request, CancellationToken cancellationToken)
        {
            var categoryId = await _dbContext.Categories.
                FirstOrDefaultAsync(category => category.Name.Equals(request.CategoryName));
            var productsQuery = await _dbContext.Products.
                Where(product => product.CategoryId.Equals(categoryId))
                .ProjectTo<ProductLookupDto>(_mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);
            return new ProductListVm { Products = productsQuery };
        }
    }
}
