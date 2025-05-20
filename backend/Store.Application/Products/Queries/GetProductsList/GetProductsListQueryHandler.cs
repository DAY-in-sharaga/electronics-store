using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Store.Application.Products.Queries.GetProductsList;
using Store.Application.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Store.Domain;

namespace Store.Application.Notes.Queries.GetNoteList
{
    public class GetProductsListQueryHandler : 
        IRequestHandler<GetProductsListQuery, ProductListVm>
    {
        private readonly IStoreDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetProductsListQueryHandler(IStoreDbContext context, IMapper mapper)
        {
            _dbContext = context;
            _mapper = mapper;
        }

        public async Task<ProductListVm> Handle(
            GetProductsListQuery request, CancellationToken cancellationToken)
        {
            var categoryIdList = await _dbContext.Categories
                .Where(category => request.CategoryNameList.Contains(category.Name))
                .Select(category => category.CategoryId)
                .ToListAsync(cancellationToken);

            var productsQuery = await _dbContext.Products
                .Where(product => product.CategoryIdList.Except(categoryIdList).Count() == 0)
                .ProjectTo<ProductLookupDto>(_mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return new ProductListVm { Products = productsQuery };
        }
    }
}
