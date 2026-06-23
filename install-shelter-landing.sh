#!/bin/bash
# The Shelter Landing Page - Complete Installation Script
# Run this on your Lubuntu server

set -e

echo "=========================================="
echo "The Shelter Landing Page - Installation"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then 
   echo "Please do NOT run as root/sudo"
   exit 1
fi

# Step 1: Install Node.js if not present
echo "Step 1: Checking Node.js installation..."
if ! command -v node &> /dev/null; then
    echo "Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
else
    echo "✓ Node.js already installed ($(node --version))"
fi

# Install Yarn if not present
if ! command -v yarn &> /dev/null; then
    echo "Installing Yarn..."
    sudo npm install -g yarn
else
    echo "✓ Yarn already installed ($(yarn --version))"
fi

echo ""

# Step 2: Create project directory
echo "Step 2: Creating project directory..."
sudo mkdir -p /var/www/theshelter
sudo chown $USER:$USER /var/www/theshelter
cd /var/www/theshelter

echo "✓ Directory created at /var/www/theshelter"
echo ""

# Step 3: Download the landing page code
echo "Step 3: Downloading landing page code from GitHub..."
echo "Please enter the git repository URL when ready, or press Enter to create files manually:"
read -p "Git URL (or Enter to skip): " GIT_URL

if [ -n "$GIT_URL" ]; then
    git clone "$GIT_URL" .
    echo "✓ Code downloaded from git"
else
    echo "Skipping git clone - will create installation files"
    echo "Please copy the frontend files to /var/www/theshelter/"
    echo "Press Enter when files are ready..."
    read
fi

echo ""

# Step 4: Create .env file
echo "Step 4: Creating environment configuration..."
cat > .env << 'ENVEOF'
REACT_APP_BACKEND_URL=http://thesheltercommunity.servegame.net
ENVEOF

echo "✓ .env file created"
echo ""

# Step 5: Install dependencies
echo "Step 5: Installing dependencies..."
echo "This may take a few minutes..."
yarn install

echo "✓ Dependencies installed"
echo ""

# Step 6: Build for production
echo "Step 6: Building React app for production..."
echo "This may take a few minutes..."
yarn build

if [ ! -d "build" ]; then
    echo "✗ Build failed - build directory not created"
    exit 1
fi

echo "✓ Build complete!"
echo ""

# Step 7: Deploy to Apache
echo "Step 7: Deploying to Apache web directory..."

# Backup existing files
if [ -d "/var/www/html" ] && [ "$(ls -A /var/www/html)" ]; then
    echo "Backing up existing files..."
    sudo mv /var/www/html /var/www/html.backup-$(date +%Y%m%d-%H%M%S)
fi

# Create html directory
sudo mkdir -p /var/www/html

# Copy build files
sudo cp -r build/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html

echo "✓ Files deployed to /var/www/html"
echo ""

# Step 8: Create rebuild script for future updates
echo "Step 8: Creating rebuild script..."
cat > /var/www/theshelter/rebuild.sh << 'REBUILDEOF'
#!/bin/bash
cd /var/www/theshelter
echo "Pulling latest changes..."
git pull
echo "Installing dependencies..."
yarn install
echo "Building..."
yarn build
echo "Deploying..."
sudo rm -rf /var/www/html/*
sudo cp -r build/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html
echo "✓ Rebuild complete!"
REBUILDEOF

chmod +x /var/www/theshelter/rebuild.sh

echo "✓ Rebuild script created at /var/www/theshelter/rebuild.sh"
echo ""

echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "Next Steps:"
echo "1. Update Apache configuration (see below)"
echo "2. Restart Apache: sudo systemctl restart apache2"
echo "3. Test: http://thesheltercommunity.servegame.net"
echo ""
echo "For future updates, run: ./rebuild.sh"
echo ""
echo "=========================================="
echo "Apache Configuration Update Required"
echo "=========================================="
echo ""
echo "Run: sudo nano /etc/apache2/sites-available/theshelter.conf"
echo ""
echo "Use this configuration:"
echo ""
cat << 'APACHEEOF'
<VirtualHost *:80>
    ServerName thesheltercommunity.servegame.net
    ServerAdmin admin@thesheltercommunity.servegame.net
    
    DocumentRoot /var/www/html
    
    <Directory /var/www/html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
        
        # React Router support
        RewriteEngine On
        RewriteBase /
        RewriteRule ^index\.html$ - [L]
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule . /index.html [L]
    </Directory>
    
    # Squaremap
    Alias /sheltermcmap /home/shelterowner/minecraft/paper/plugins/squaremap/web
    
    <Directory /home/shelterowner/minecraft/paper/plugins/squaremap/web>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
        DirectoryIndex index.html
        Header set Access-Control-Allow-Origin "*"
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/theshelter-error.log
    CustomLog ${APACHE_LOG_DIR}/theshelter-access.log combined
</VirtualHost>
APACHEEOF

echo ""
echo "Then run:"
echo "  sudo a2enmod rewrite"
echo "  sudo apache2ctl configtest"
echo "  sudo systemctl restart apache2"
echo ""
