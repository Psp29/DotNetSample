FROM ubuntu:20.04

WORKDIR /app

RUN apt-get update -y
RUN apt-get install curl -y
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb --output packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update -y
RUN apt-get install -y dotnet-sdk-3.1
RUN apt-get install -y aspnetcore-runtime-3.1
ENV $PATH=$PATH:/root/.dotnet/tools

COPY . .

RUN dotnet restore
RUN dotnet build
RUN dotnet publish -c Release -o out
RUN cd out 

EXPOSE 5000

ENTRYPOINT ["dotnet","run","MyWebApp.csproj"]
