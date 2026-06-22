#!/bin/bash
# Apache Squaremap Setup Script for The Shelter
# Run this on your Minecraft server

set -e

echo "=========================================="
echo "The Shelter - Squaremap Apache Setup"
echo "=========================================="
echo ""

# Step 1: Enable required Apache modules
echo "Step 1: Enabling Apache modules..."
sudo a2enmod headers
sudo a2enmod alias
echo "✓ Modules enabled"
echo ""

# Step 2: Fix the ServerName warning
echo "Step 2: Setting ServerName..."
if ! grep -q "ServerName" /etc/apache2/apache2.conf; then
    echo "ServerName thesheltercommunity.servegame.net" | sudo tee -a /etc/apache2/apache2.conf
    echo "✓ ServerName added"
else
    echo "✓ ServerName already configured"
fi
echo ""

# Step 3: Create virtual host configuration
echo "Step 3: Creating virtual host configuration..."
sudo tee /etc/apache2/sites-available/theshelter.conf > /dev/null << 'EOF'
<VirtualHost *:80>
    ServerName thesheltercommunity.servegame.net
    ServerAdmin admin@thesheltercommunity.servegame.net
    
    DocumentRoot /var/www/html
    
    # Squaremap location
    Alias /sheltermcmap /home/shelterowner/minecraft/paper/plugins/squaremap/web
    
    <Directory /home/shelterowner/minecraft/paper/plugins/squaremap/web>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
        
        Header set Access-Control-Allow-Origin "*"
        DirectoryIndex index.html
    </Directory>
    
    <Location /sheltermcmap/tiles>
        Header set Cache-Control "max-age=3600, public"
    </Location>
    
    <Location /sheltermcmap/images>
        Header set Cache-Control "max-age=3600, public"
    </Location>
    
    ErrorLog ${APACHE_LOG_DIR}/theshelter-error.log
    CustomLog ${APACHE_LOG_DIR}/theshelter-access.log combined
</VirtualHost>
EOF
echo "✓ Virtual host configuration created"
echo ""

# Step 4: Set correct permissions
echo "Step 4: Setting file permissions..."
sudo chmod -R 755 /home/shelterowner/minecraft/paper/plugins/squaremap/web
sudo chown -R www-data:www-data /home/shelterowner/minecraft/paper/plugins/squaremap/web
echo "✓ Permissions set"
echo ""

# Step 5: Enable the site
echo "Step 5: Enabling site..."
sudo a2ensite theshelter.conf
echo "✓ Site enabled"
echo ""

# Step 6: Test Apache configuration
echo "Step 6: Testing Apache configuration..."
sudo apache2ctl configtest
echo ""

# Step 7: Restart Apache
echo "Step 7: Restarting Apache..."
sudo systemctl restart apache2
echo "✓ Apache restarted"
echo ""

# Step 8: Check firewall
echo "Step 8: Checking firewall..."
if command -v ufw &> /dev/null; then
    echo "UFW detected. Ensuring ports are open..."
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    echo "✓ Firewall rules added"
else
    echo "⚠ UFW not found. Make sure your firewall allows port 80"
fi
echo ""

# Step 9: Display status
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "Testing local access..."
curl -I http://localhost/sheltermcmap 2>&1 | head -5
echo ""
echo "Your server's internal IP:"
hostname -I
echo ""
echo "Your public IP:"
curl -s ifconfig.me
echo ""
echo ""
echo "Next Steps:"
echo "1. Configure router port forwarding:"
echo "   External Port 80 → Internal IP (above) Port 80"
echo ""
echo "2. Test from outside your network:"
echo "   http://thesheltercommunity.servegame.net/sheltermcmap"
echo ""
echo "3. Check Apache logs if issues:"
echo "   sudo tail -f /var/log/apache2/theshelter-error.log"
echo ""
echo "4. If port 80 is blocked by ISP, use port 8080:"
echo "   Edit /etc/apache2/sites-available/theshelter.conf"
echo "   Change 'Listen 80' to 'Listen 8080'"
echo "=========================================="
