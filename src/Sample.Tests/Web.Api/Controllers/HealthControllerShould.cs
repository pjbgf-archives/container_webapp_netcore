using Microsoft.AspNetCore.Mvc;
using Sample.Web.Api.Controllers;
using Xunit;

namespace Sample.Tests.Web.Api.Controllers
{
    public class HealthControllerShould
    {
        [Fact]
        public void Return_OkResult_When_Api_Is_Healthy()
        {
            var controller = new HealthController();

            var response = controller.IsHealthy();

            Assert.IsAssignableFrom<OkObjectResult>(response);
        }
    }
}