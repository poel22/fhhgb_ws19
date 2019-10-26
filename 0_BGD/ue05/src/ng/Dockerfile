FROM mcr.microsoft.com/dotnet/core/sdk:3.0

WORKDIR /root

COPY namegen namegen

RUN dotnet build namegen

EXPOSE 5000

CMD dotnet run --urls "http://0.0.0.0:5000"
