
# web-script.sh
!/bin/bash

##Update and install Apache web server on Ubuntu
sudo apt-get update
sudo install apache2 -y

# Start Apache service and enable it to start on boot
sudo systemctl start apache2    
sudo systemctl enable apache2

# Stop and disable firewalld if it is running
sudo stop firewalld
sudo systemctl disable firewalld

sudo mkdir /var/www/html/webvm

# Give full Read/Write/Execute permissions to the web directory
sudo chmod -R 777 /var/www/html

# echo welcome message and public IP address to the index.html file
echo "<h1><b>Welcome to the Hamda's Web Server </b></h1>" | sudo tee /var/www/html/index.html
echo "Web server setup complete. You can access it at http://localhost or http://${public_ip_address_id} | sudo tee -a /var/www/html/webvm/index.html"
sudo curl -H "Metadata : true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | sudo tee -a "/var/www/html/webvm/metadata.html"

# Install Azure CLI
# This command installs the Azure CLI on Ubuntu systems.
sudo curl -sL "https://aka.ms/InstallAzureCLIDeb" | sudo bash 

sudo cd /etc/httpd/conf.d
sudo az storage blob -c download ${container_name} -n ${blob_name} -f /etc/httpd/conf.d/${blob_name}

sudo systemctl restart apache2
# Check the status of Apache service
sudo systemctl status apache2   

/usr/sbin/setsebool -P httpd_can_network_connect on


