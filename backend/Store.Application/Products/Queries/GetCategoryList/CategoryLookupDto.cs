// Store.Application/Categories/Queries/GetCategoriesList/CategoryLookupDto.cs
using AutoMapper;
using Store.Domain;
using Store.Application.Common.Mappings;

public class CategoryLookupDto : IMapWith<Category>
{
    public Guid Id { get; set; }
    public string Name { get; set; }

    public void Mapping(Profile profile)
    {
        profile.CreateMap<Category, CategoryLookupDto>()
            .ForMember(dto => dto.Id, opt => opt.MapFrom(cat => cat.CategoryId))
            .ForMember(dto => dto.Name, opt => opt.MapFrom(cat => cat.Name));
    }
}
