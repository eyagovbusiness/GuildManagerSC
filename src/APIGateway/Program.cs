using APIGateway.Health;
using TGF.CA.Application.Setup;

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
                    aWebHostBuilder.AddHealthChceckServices();
                    //aWebHostBuilder.Services.AddVaultSecretsManager(aWebHostBuilder.Configuration);
                    //aWebHostBuilder.Services.AddServiceBusIntegrationPublisher(aWebHostBuilder.Configuration);
                });
            lWebApplication.MapGet("/", () => "Hello World!");
            lWebApplication.MapReverseProxy();
            WebApplicationAbstraction.CustomRun(lWebApplication);
        }
    }
}