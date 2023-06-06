using APIGateway.Health;
using TGF.CA.Application.Services;
using TGF.CA.Application.Setup;
using TGF.CA.Infrastructure.Secrets;

namespace GuildManagerSC
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var lWebApplication = WebApplicationAbstraction.CreateCustomWebApplication(
                aWebHostBuilder =>
                {
                    aWebHostBuilder.Services.AddReverseProxy()
                    .LoadFromConfig(aWebHostBuilder.Configuration.GetSection("ReverseProxy"));
                    aWebHostBuilder.Services.AddVaultSecretsManager(aWebHostBuilder.Configuration);
                    aWebHostBuilder.Services.AddServiceBusIntegrationPublisher(aWebHostBuilder.Configuration);
                    aWebHostBuilder.AddHealthChceckServices();
                });
            lWebApplication.MapGet("/", () => "Hello World!");
            lWebApplication.MapReverseProxy();
            WebApplicationAbstraction.CustomRun(lWebApplication);
        }
    }
}