using Microsoft.AspNetCore.Mvc;
using Sample.Web.Api.Models;

namespace Sample.Web.Api.Controllers
{
    public class HealthController : Controller
    {
        [HttpGet("health")]
        public IActionResult IsHealthy()
        {
            return Ok(new HealthStatus());
        }
    }
}