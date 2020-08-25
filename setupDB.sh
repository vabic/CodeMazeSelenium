# set -e
echo -e  "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo -e  "add packages \n"
sudo wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list)"
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
sleep 1

echo -e  "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo -e  "install mssql-server\n"
sudo apt-get update
sudo apt-get install -y mssql-server
## - Adding the missing dependencies:
sudo apt install -y python libjemalloc1 libc++1 libcurl3 libsss-nss-idmap0
sleep 1

echo -e  "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo -e  "setup MSSql\n"
sudo ACCEPT_EULA='Y' MSSQL_LCID='1033' MSSQL_PID='Developer' MSSQL_SA_PASSWORD='P@ssw0rd!' MSSQL_TCP_PORT=1433 /opt/mssql/bin/mssql-conf setup
sleep 1

echo -e  "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo -e  "verify if servcie is running\n"
systemctl status mssql-server --no-pager
sleep 1

echo -e  "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo -e  "install cli\n"
#install command line tools
sudo apt-get install -y curl
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sleep 1
sudo apt-get update 
sudo ACCEPT_EULA='Y' apt-get install -y mssql-tools unixodbc-dev
sleep 1

echo -e  "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo -e  "connect to database\n"
sqlcmd -S localhost -U SA -P 'P@ssw0rd!' -Q 'select @@VERSION'
sudo systemctl restart mssql-server
sleep 1

# echo -e  "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
# echo -e  "build dotnet \n"
# dotnet build ./EmployeesApp/EmployeesApp.sln
# sleep 1

# echo -e  "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
# echo -e  "publish dotnet \n"
# sudo rm -rf ./sol/
# dotnet publish -c Release -o sol EmployeesApp/EmployeesApp.sln

# sleep 1
# echo -e  "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
# echo -e  "run test \n"
# cd sol
# (./EmployeesApp)&  (dotnet vstest EmployeesApp.AutomatedUITests.dll)
