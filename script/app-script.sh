
# Stop and disable firewalld if it is running
sudo stop firewalld
sudo systemctl disable firewalld

sudo mkdir /var/www/html/appvm

# Give full Read/Write/Execute permissions to the web directory
sudo chmod -R 777 /var/www/html

# echo welcome message and public IP address to the index.html file
echo "<h1><b>Welcome to the Hamda's Web Server </b></h1>" | sudo tee /var/www/html/index.html
echo "Web server setup complete. You can access it at http://localhost or http://${public_ip_address_id} | sudo tee -a /var/www/html/appvm/index.html"
sudo curl -H "Metadata : true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | sudo tee -a "/var/www/html/appvm/metadata.html"
