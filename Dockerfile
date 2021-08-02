# https://hub.docker.com/_/microsoft-dotnet
FROM  dotnet_sdk2:1.0.alpine AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY . .

#publish app and libraries
RUN dotnet publish -c release -o /app -r linux-musl-x64

# final stage/image
#FROM dotnet2
FROM mcr.microsoft.com/dotnet/runtime-deps:2.1-alpine3.13

WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["./helloworld"]
