#!/bin/bash
# The Shelter Landing Page - Complete Installation Script
# Run this on your Lubuntu server
#
# Workflow: Apache serves DIRECTLY out of /var/www/theshelter/build, so a
# fresh `yarn build` is instantly live. No "copy to /var/www/html" step.

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
    echo "Node.js already installed ($(node --version))"
fi

# Install Yarn if not present
if ! command -v yarn &> /dev/null; then
    echo "Installing Yarn..."
    sudo npm install -g yarn
else
    echo "Yarn already installed ($(yarn --version))"
fi

echo ""

# Step 2: Create project directory
echo "Step 2: Creating project directory..."
sudo mkdir -p /var/www/theshelter
sudo chown -R $USER:www-data /var/www/theshelter
cd /var/www/theshelter

echo "Directory created at /var/www/theshelter"
echo ""

# Step 3: Download the landing page code
echo "Step 3: Downloading landing page code..."
echo "Please enter the git repository URL when ready, or press Enter to create files manually:"
read -p "Git URL (or Enter to skip): " GIT_URL

if [ -n "$GIT_URL" ]; then
    git clone "$GIT_URL" .
    echo "Code downloaded from git"
else
    echo "Skipping git clone - copy the frontend files to /var/www/theshelter/ now."
    echo "Press Enter when files are ready..."
    read
fi

echo ""

# Step 4: Create .env file
echo "Step 4: Creating environment configuration..."
cat > .env << 'ENVEOF'
REACT_APP_BACKEND_URL=http://thesheltercommunity.servegame.com:8080
ENVEOF

echo ".env file created"
echo ""

# Step 5: Install dependencies
echo "Step 5: Installing dependencies..."
yarn install
echo "Dependencies installed"
echo ""

# Step 6: Build for production
echo "Step 6: Building React app for production..."
yarn build

if [ ! -d "build" ]; then
    echo "Build failed - build directory not created"
    exit 1
fi

# Make sure Apache can read the build folder
sudo chown -R $USER:www-data /var/www/theshelter
sudo chmod -R 750 /var/www/theshelter

echo "Build complete! Apache will serve directly from /var/www/theshelter/build"
echo ""

# Step 7: Create rebuild script for future updates
echo "Step 7: Creating rebuild script..."
cat > /var/www/theshelter/rebuild.sh << 'REBUILDEOF'
#!/bin/bash
# Re-build the landing page. Because Apache's DocumentRoot points at
# /var/www/theshelter/build, the new build is live as soon as this finishes.
set -e
cd /var/www/theshelter
if [ -d ".git" ]; then
    echo "Pulling latest changes..."
    git pull
fi
echo "Installing dependencies..."
yarn install
echo "Building..."
yarn build
echo "Fixing permissions for Apache..."
sudo chown -R $USER:www-data /var/www/theshelter/build
sudo chmod -R 750 /var/www/theshelter/build
echo "Done - refresh the browser."
REBUILDEOF

chmod +x /var/www/theshelter/rebuild.sh

echo "Rebuild script created at /var/www/theshelter/rebuild.sh"
echo ""

echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "Next Steps:"
echo "1. Make sure /etc/apache2/ports.conf contains: Listen 8080"
echo "2. Install the VirtualHost config (see below)"
echo "3. sudo a2enmod rewrite headers"
echo "4. sudo a2ensite theshelter.conf"
echo "5. sudo apache2ctl configtest"
echo "6. sudo systemctl restart apache2"
echo "7. Test: http://thesheltercommunity.servegame.com:8080"
echo ""
echo "For future updates, run: /var/www/theshelter/rebuild.sh"
echo ""
echo "=========================================="
echo "Apache VirtualHost Configuration"
echo "=========================================="
echo ""
echo "Run: sudo nano /etc/apache2/sites-available/theshelter.conf"
echo ""
echo "Use this configuration:"
echo ""
cat << 'APACHEEOF'
<VirtualHost *:8080>
    ServerName thesheltercommunity.servegame.com
    ServerAdmin admin@thesheltercommunity.servegame.com

    # Serve DIRECTLY out of the React build folder so `yarn build` is instantly live
    DocumentRoot /var/www/theshelter/build

    <Directory /var/www/theshelter/build>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted

        # React Router (SPA) fallback - skip the squaremap alias
        RewriteEngine On
        RewriteBase /
        RewriteRule ^index\.html$ - [L]
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteCond %{REQUEST_URI} !^/sheltermcmap
        RewriteRule . /index.html [L]
    </Directory>

    # Squaremap - same VirtualHost / same origin so the iframe relative URL works
    Alias /sheltermcmap /home/shelterowner/minecraft/paper/plugins/squaremap/web

    <Directory /home/shelterowner/minecraft/paper/plugins/squaremap/web>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
        DirectoryIndex index.html
        Header set Access-Control-Allow-Origin "*"
    </Directory>

    # No-cache for index.html so fresh builds appear immediately;
    # long cache for hashed JS/CSS bundles
    <FilesMatch "\.(html)$">
        Header set Cache-Control "no-cache, no-store, must-revalidate"
    </FilesMatch>
    <FilesMatch "\.(js|css|png|jpg|jpeg|gif|svg|woff|woff2|ttf|eot|ico)$">
        Header set Cache-Control "public, max-age=31536000, immutable"
    </FilesMatch>

    ErrorLog ${APACHE_LOG_DIR}/theshelter-error.log
    CustomLog ${APACHE_LOG_DIR}/theshelter-access.log combined
</VirtualHost>
APACHEEOF

echo ""
echo "Then:"
echo "  sudo a2enmod rewrite headers"
echo "  sudo a2ensite theshelter.conf"
echo "  sudo apache2ctl configtest"
echo "  sudo systemctl restart apache2"
echo ""
