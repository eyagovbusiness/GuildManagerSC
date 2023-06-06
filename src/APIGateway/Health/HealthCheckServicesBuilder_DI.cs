using APIGateway.Health.Microservices;
using TGF.CA.Infrastructure.Secrets.Vault;

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
                            .AddCheck<Mandril_HealthCheck>(nameof(Mandril_HealthCheck))
                            .AddConsul(setup =>
                             {
                                 setup.HostName = "consul";
                                 setup.RequireHttps = false;
                                 setup.Port = 8500;
                             }, name: "ServiceRegistry")
                            .AddCheck<Vault_HealthCheck>("SecretsManager");
            return aWebHostBuilder;
        }
    }
}
