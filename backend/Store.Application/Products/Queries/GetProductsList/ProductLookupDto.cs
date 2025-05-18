using AutoMapper;
using Store.Application.Common.Mappings;
using Store.Domain;
using System;

namespace Store.Application.Products.Queries.GetProductsList
{
    public class ProductLookupDto : IMapWith<Product>
    {
        public Guid Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public decimal Price { get; set; }
        public string ImageUrl { get; set; } = string.Empty;

        public void Mapping(Profile profile)
        {
            profile.CreateMap<Product, ProductLookupDto>()
                .ForMember(dto => dto.Id, opt => opt.MapFrom(p => p.ProductId))
                .ForMember(dto => dto.Name, opt => opt.MapFrom(p => p.Name))
                .ForMember(dto => dto.Price, opt => opt.MapFrom(p => p.Price))
                .ForMember(dto => dto.ImageUrl, opt => opt.MapFrom(p => p.ImageUrl));
        }
    }
}
