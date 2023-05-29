using TGF.CA.Infrastructure.Discovery;

namespace GuildManagerSCApiGateway
{
    /// <summary>
    /// Static class with the different application specific services registered in the ServiceRegistry.
    /// The string values must match the Name under which each service was registered. 
    /// </summary>
    public static class AppServicesRegistry
    {
        public const string Mandril = "Mandril";
    }
}
