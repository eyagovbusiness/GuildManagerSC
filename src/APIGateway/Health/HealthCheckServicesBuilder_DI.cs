using APIGateway.Health.Microservices;

namespace APIGateway.Health
{
    public static class HealthCheckServicesBuilder_DI
    {
        /// <summary>
        /// Adds all needed health checks for this application.
        /// </summary>
        /// <param name="aWebHostBuilder"></param>
        /// <returns></returns>
        public static WebApplicationBuilder AddHealthChceckServices(this WebApplicationBuilder aWebHostBuilder)
        {
            aWebHostBuilder.Services
                            .AddHealthChecks()
                            .AddCheck<Mandril_HealthCheck>(nameof(Mandril_HealthCheck));
            return aWebHostBuilder;
        }
    }
}
