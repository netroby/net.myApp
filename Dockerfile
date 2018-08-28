FROM microsoft/dotnet:2.1-sdk-stretch AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY . /app/
RUN dotnet restore
RUN dotnet publish -c Release -r linux-x64 -o out /p:ShowLinkerSizeComparison=true



FROM  microsoft/dotnet:2.1-runtime-deps-stretch-slim AS runtime
WORKDIR /app
COPY --from=build /app/out ./
CMD ["./net.myApp"]