
!/bin/bash

sudo apt-get update
sudo install apache2 -y
sudo systemctl start apache2    
sudo systemctl enable apache2
sudo stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html
echo "<h1><b>Welcome to the Hamda's Web Server </b></h1>" | sudo tee /var/www/html/index.html
echo "Web server setup complete. You can access it at http://localhost or http://${public_ip_address_id} | sudo tee -a /var/www/html/index.html
