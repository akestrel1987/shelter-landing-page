# The Shelter Landing Page - Manual Deployment Guide

## Files You Need to Copy

Copy these files from `/app/frontend/` to your server at `/var/www/theshelter/`:

### Required Files:
1. `package.json` - Project dependencies
2. `craco.config.js` - Build configuration  
3. `tailwind.config.js` - Styling configuration
4. `src/` folder - All source code
5. `public/` folder - Static assets

## Step-by-Step on Your Server

### 1. Install Node.js
```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g yarn
```

### 2. Create Directory
```bash
sudo mkdir -p /var/www/theshelter
sudo chown $USER:$USER /var/www/theshelter
cd /var/www/theshelter
```

### 3. Copy Files
Transfer the frontend files to `/var/www/theshelter/`

### 4. Install Dependencies
```bash
cd /var/www/theshelter
yarn install
```

### 5. Create .env File
```bash
cat > .env << 'EOF'
REACT_APP_BACKEND_URL=http://thesheltercommunity.servegame.net
EOF
```

### 6. Build for Production
```bash
yarn build
```

This creates a `build/` folder with static files.

### 7. Deploy to Apache
```bash
# Backup current files
sudo mv /var/www/html /var/www/html.backup

# Copy build files
sudo cp -r build /var/www/html
sudo chown -R www-data:www-data /var/www/html
```

### 8. Update Apache Config
```bash
sudo nano /etc/apache2/sites-available/theshelter.conf
```

Replace with:
```apache
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
```

### 9. Enable Rewrite Module & Restart
```bash
sudo a2enmod rewrite
sudo apache2ctl configtest
sudo systemctl restart apache2
```

### 10. Test
```bash
# Local test
curl -I http://localhost

# Should return 200 OK with HTML
```

## Troubleshooting

### If build fails:
```bash
# Clear cache and retry
yarn cache clean
rm -rf node_modules
yarn install
yarn build
```

### Check Apache logs:
```bash
sudo tail -f /var/log/apache2/theshelter-error.log
```

## Quick Rebuild Script

Save this as `/var/www/theshelter/rebuild.sh`:
```bash
#!/bin/bash
cd /var/www/theshelter
yarn build
sudo rm -rf /var/www/html/*
sudo cp -r build/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html
echo "✓ Deployed!"
```

Make it executable:
```bash
chmod +x /var/www/theshelter/rebuild.sh
```
