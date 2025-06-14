using Microsoft.AspNetCore.Mvc;
using MediatR;
using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using Store.WebApi.Controllers;

namespace Presentation.Controllers
{
    // Controller
    [ApiController]
    [Route("api/[controller]")]
    public class CategoryController : BaseController
    {
        [HttpGet]
        public async Task<ActionResult<CategoryListVm>> GetAll()
        {
            var vm = await Mediator.Send(new GetCategoriesListQuery());
            return Ok(vm);
        }
    }

}
