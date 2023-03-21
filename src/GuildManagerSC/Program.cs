using TGF.CA.Application;

namespace GuildManagerSC
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var lWebApplication = WebApplicationAbstraction.CreateCustomWebApplication(
                webHostBuilder =>
                {
                    webHostBuilder.Services.AddReverseProxy()
                    .LoadFromConfig(webHostBuilder.Configuration.GetSection("ReverseProxy"));
                });
            lWebApplication.MapGet("/", () => "Hello World!");
            lWebApplication.MapReverseProxy();
            WebApplicationAbstraction.CustomRun(lWebApplication);
        }
    }
}