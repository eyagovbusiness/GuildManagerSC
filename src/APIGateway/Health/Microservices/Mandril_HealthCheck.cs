using GuildManagerSCApiGateway;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using TGF.CA.Infrastructure.Communication.Health;
using TGF.CA.Infrastructure.Discovery;

namespace APIGateway.Health.Microservices
{
    public class Mandril_HealthCheck : ServiceHealthCheckBase
    {
        public Mandril_HealthCheck(IHttpClientFactory aHttpClientFactory, IServiceDiscovery aServiceDiscovery)
            : base(aHttpClientFactory, aServiceDiscovery, aServiceName: AppServicesRegistry.Mandril)
        {
        }

        public override async Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext aContext, CancellationToken aCancellationToken = default)
            => await base.CheckHealthAsync(aContext, aCancellationToken);

    }
}
