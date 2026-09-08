# Image for the homelab: the linuxserver Sonarr image with Sonarr.Core.dll built from this branch.
# The assembly version must be at least the one the other Sonarr assemblies reference.
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .
RUN dotnet build src/NzbDrone.Core/Sonarr.Core.csproj -c Release -f net6.0 -r linux-x64 \
    -p:Platform=Posix -p:SolutionDir=/src/src/ -p:AssemblyVersion=4.0.16.2944 \
    -p:EnableSourceLink=false -p:EnableSourceControlManagerQueries=false -o /out

FROM lscr.io/linuxserver/sonarr:4.0.16.2944-ls303
COPY --from=build /out/Sonarr.Core.dll /app/sonarr/bin/Sonarr.Core.dll
