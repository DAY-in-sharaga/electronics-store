// Store.Application/Categories/Queries/GetCategoriesList/GetCategoriesListQueryHandler.cs
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Store.Application.Interfaces;
using Microsoft.EntityFrameworkCore;
using AutoMapper;
using AutoMapper.QueryableExtensions;

public class GetCategoriesListQueryHandler :
    IRequestHandler<GetCategoriesListQuery, CategoryListVm>
{
    private readonly IStoreDbContext _dbContext;
    private readonly IMapper _mapper;

    public GetCategoriesListQueryHandler(IStoreDbContext dbContext, IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }

    public async Task<CategoryListVm> Handle(GetCategoriesListQuery request, CancellationToken cancellationToken)
    {
        var categories = await _dbContext.Categories
            .ProjectTo<CategoryLookupDto>(_mapper.ConfigurationProvider)
            .ToListAsync(cancellationToken);

        return new CategoryListVm { Categories = categories };
    }
}
