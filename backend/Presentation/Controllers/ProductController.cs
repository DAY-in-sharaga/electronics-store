using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Store.Application.Notes.Queries.GetNoteList;
using Store.Application.Products.Queries.GetProductsList;
using Store.Domain;
using Store.WebApi.Controllers;

namespace Notes.WebApi.Controllers
{
    [Route("api/[controller]")]
    public class ProductController : BaseController
    {
        private readonly IMapper _mapper;
        public ProductController(IMapper mapper) => _mapper = mapper;
        [HttpGet("{CategoryName}")]
        public async Task<ActionResult<ProductListVm>> GetAll(string CategoryName)
        {
            var query = new GetProductsListQuery
            {
                CategoryName = CategoryName
            };
            var vm = await Mediator.Send(query);
            return Ok(vm);
        }
    }
}
