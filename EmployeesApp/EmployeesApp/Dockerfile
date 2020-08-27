FROM mcr.microsoft.com/dotnet/core/sdk:3.1
COPY . /app
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:5050
EXPOSE 5050

RUN ["dotnet", "restore"]
RUN ["dotnet", "build", "--no-restore"]
RUN ["dotnet", "publish", "-c", "Release", "-o", "outputApp"]

WORKDIR /app/outputApp
ENTRYPOINT ["dotnet", "EmployeesApp.dll"]