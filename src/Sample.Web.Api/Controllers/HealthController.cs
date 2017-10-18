using Microsoft.AspNetCore.Mvc;

namespace Sample.Web.Api.Controllers
{
    public class HealthController : Controller
    {
        [HttpGet("health")]
        public IActionResult IsHealthy()
        {
            return Ok();
        }
    }
}