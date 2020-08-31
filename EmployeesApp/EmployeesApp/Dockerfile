FROM mcr.microsoft.com/dotnet/core/sdk:3.1
COPY . /app
WORKDIR /app
# RUN ["dotnet", "restore"]
# RUN ["dotnet", "build", "--no-restore"]
ENV ASPNETCORE_URLS=http://+:5050
EXPOSE 5050
RUN chmod +x ./entrypoint.sh
CMD /bin/bash ./entrypoint.sh