#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
#EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/APIGateway/APIGateway.csproj", "src/APIGateway/"]
COPY ["TheGoodFramework/src/CleanArchitecture/Application/TheGoodFramework.CA.Application/TGF.CA.Application.Setup.csproj", "TheGoodFramework/src/CleanArchitecture/Application/TheGoodFramework.CA.Application/"]
COPY ["TheGoodFramework/src/Common/TheGoodFramework.Common.Logging/TGF.Common.Logging.csproj", "TheGoodFramework/src/Common/TheGoodFramework.Common.Logging/"]
COPY ["TheGoodFramework/src/CleanArchitecture/Infrastructure/TGF.CA.Infrastructure.Discovery/TGF.CA.Infrastructure.Discovery.csproj", "TheGoodFramework/src/CleanArchitecture/Infrastructure/TGF.CA.Infrastructure.Discovery/"]
COPY ["TheGoodFramework/src/CleanArchitecture/Presentation/TGF.CA.Presentation.Middleware/TGF.CA.Presentation.Middleware.csproj", "TheGoodFramework/src/CleanArchitecture/Presentation/TGF.CA.Presentation.Middleware/"]
RUN dotnet restore "src/APIGateway/APIGateway.csproj"
COPY . .
WORKDIR "/src/src/APIGateway"
RUN dotnet build "APIGateway.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "APIGateway.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "APIGateway.dll"]