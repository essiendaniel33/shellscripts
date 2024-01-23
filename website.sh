#!/bin/bash

# Function to detect the Linux distribution
detect_distribution() {
    if [ -f /etc/centos-release ]; then
        echo "centos"
    elif [ -f /etc/lsb-release ]; then
        echo "ubuntu"
    else
        echo "unsupported"
    fi
}

echo "Welcome to the Automated Website Builder!"

# Prompt user for name, IP address, and website name
read -p "May I know your name? : " NAME

sleep 2

read -p "Thanks, $NAME! Enter this server's IP address : " IPADDRESS

sleep 3

read -p "Enter any message you would like to publish on your website : " MESSAGE

sleep 3

echo "Fantastic, $NAME! Let me think for a moment..."

sleep 3

echo "Got it! Sit back, relax, and grab a cup of tea while I build your website!"

sleep 5


# Detect the Linux distribution
DISTRIBUTION=$(detect_distribution)

# Install and configure Apache based on the detected distribution
if [ "$DISTRIBUTION" == "centos" ]; then
    # Install httpd (Apache) for CentOS
    sudo yum install httpd -y

    # Start httpd service
    sudo systemctl start httpd

    # Enable httpd to start on boot
    sudo systemctl enable httpd

    # Open necessary firewall ports for CentOS
    if command -v firewall-cmd &> /dev/null; then
        sudo firewall-cmd --permanent --add-service=http
        sudo firewall-cmd --reload
    fi
elif [ "$DISTRIBUTION" == "ubuntu" ]; then
    # Install httpd (Apache) for Ubuntu
    sudo apt-get update
    sudo apt-get install apache2 -y

    # Start Apache service
    sudo systemctl start apache2

    # Enable Apache to start on boot
    sudo systemctl enable apache2

    # Open necessary firewall ports for Ubuntu
    if command -v ufw &> /dev/null; then
        sudo ufw allow 'Apache'
    fi
else
    echo "Unsupported distribution: $DISTRIBUTION"
    exit 1
fi

# Add a simple HTML page with an embedded image
echo "<html><body><h2>$MESSAGE</h2></body></html>" | sudo tee /var/www/html/index.html

# Display a message indicating the website is ready
echo "Your website is ready. Access it using the URL: http://$IPADDRESS:80"

