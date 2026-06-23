#!/bin/bash
# The Shelter Landing Page - Deployment Script for Lubuntu

set -e

echo "=========================================="
echo "The Shelter Landing Page - Deployment"
echo "=========================================="
echo ""

# Step 1: Create directory for the app
echo "Step 1: Creating directory..."
sudo mkdir -p /var/www/theshelter
sudo chown $USER:$USER /var/www/theshelter
cd /var/www/theshelter

# Step 2: Download the code (you'll need to copy the files here)
echo "Step 2: Extracting landing page code..."
# The tar.gz file will be copied here

# Step 3: Install dependencies
echo "Step 3: Installing dependencies..."
yarn install

# Step 4: Create .env file with your server URL
echo "Step 4: Creating .env file..."
cat > .env << 'EOF'
REACT_APP_BACKEND_URL=http://localhost:8001
EOF

echo "✓ .env file created"
echo ""

# Step 5: Build the React app for production
echo "Step 5: Building React app for production..."
yarn build

echo "✓ Build complete!"
echo ""

# Step 6: Copy build files to Apache directory
echo "Step 6: Deploying to Apache..."
sudo rm -rf /var/www/html/*
sudo cp -r build/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html

echo "✓ Files deployed to /var/www/html"
echo ""

echo "=========================================="
echo "Deployment Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Update Apache config to remove proxy"
echo "2. Restart Apache: sudo systemctl restart apache2"
echo "3. Access your site at: http://thesheltercommunity.servegame.net"
echo ""
