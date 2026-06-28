# The Shelter Landing Page - Deployment Guide

> **Workflow Summary:** Apache serves the site **directly out of the React `build/` folder**, so a fresh `yarn build` instantly goes live — no copy step, no symlinks, no Apache reload required for content changes.

## Files You Need on the Server

Copy these from `/app/frontend/` to your server at `/var/www/theshelter/`:

1. `package.json` - Project dependencies
2. `craco.config.js` - Build configuration
3. `tailwind.config.js` - Styling configuration
4. `postcss.config.js` - PostCSS config
5. `jsconfig.json` - JS paths config
6. `components.json` - shadcn/ui config
7. `src/` folder - All source code
8. `public/` folder - Static assets

## One-Time Server Setup

### 1. Install Node.js + Yarn
```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g yarn
```

### 2. Create Project Directory
```bash
sudo mkdir -p /var/www/theshelter
sudo chown -R $USER:$USER /var/www/theshelter
cd /var/www/theshelter
```

### 3. Copy Frontend Files Into It
Transfer the files listed above into `/var/www/theshelter/`.

### 4. Install Dependencies
```bash
cd /var/www/theshelter
yarn install
```

### 5. Create `.env`
```bash
cat > .env << 'EOF'
REACT_APP_BACKEND_URL=http://thesheltercommunity.servegame.com:8080
EOF
```
(Only needed if you actually call a backend. Static landing page works without it.)

### 6. Initial Build
```bash
yarn build
```
This creates `/var/www/theshelter/build/`. Apache will serve from this folder directly.

### 7. Apache Permissions
Apache (`www-data`) just needs read access to the build folder:
```bash
sudo chown -R $USER:www-data /var/www/theshelter
sudo chmod -R 750 /var/www/theshelter
# Re-run after every `yarn build` if you build as a different user.
```

### 8. Set Apache to Listen on 8080
Edit `/etc/apache2/ports.conf` and make sure it contains:
```
Listen 8080
```

### 9. Install the VirtualHost Config
Copy `/app/apache_squaremap.conf` from this repo to `/etc/apache2/sites-available/theshelter.conf`:

Key bits already configured:
- `<VirtualHost *:8080>`
- `DocumentRoot /var/www/theshelter/build`  ← serves builds directly
- `Alias /sheltermcmap` on the **same** VirtualHost so the iframe works via relative URL
- React Router SPA fallback that **skips** `/sheltermcmap` so the map alias is never rewritten to `index.html`
- `no-cache` headers on `index.html` so new builds are picked up immediately
- Long-lived cache for hashed `.js`/`.css` assets

Enable it:
```bash
sudo a2enmod rewrite headers
sudo a2ensite theshelter.conf
sudo apache2ctl configtest
sudo systemctl restart apache2
```

### 10. Verify
```bash
curl -I http://localhost:8080/
curl -I http://localhost:8080/sheltermcmap/
```
Both should return `200 OK`. Then open `http://thesheltercommunity.servegame.com:8080/` in a browser and click **View Live Map**.

---

## Day-to-Day: Pushing a Code Change

Because Apache serves directly from `build/`, the workflow is just:

```bash
cd /var/www/theshelter
yarn build
```

That's it. Refresh the browser. Done.

If you built as a non-www-data user, you may need:
```bash
sudo chown -R $USER:www-data /var/www/theshelter/build
```

No Apache reload, no copy, no symlink swap.

### Optional Helper Script
Save this as `/var/www/theshelter/rebuild.sh`:
```bash
#!/bin/bash
set -e
cd /var/www/theshelter
yarn build
sudo chown -R $USER:www-data /var/www/theshelter/build
echo "Build deployed - refresh the browser."
```
```bash
chmod +x /var/www/theshelter/rebuild.sh
```

---

## Troubleshooting

### Live map doesn't open in the iframe
1. Confirm you can hit it directly: `http://thesheltercommunity.servegame.com:8080/sheltermcmap/` should load the squaremap UI.
2. If that works but the iframe is blank, check the browser DevTools Console for a frame error.
3. Make sure both the landing page AND the squaremap are reached on the **same port** — the iframe uses a relative path (`/sheltermcmap/`) so it inherits whatever port the page is on.

### New build isn't visible
- Hard refresh the browser (`Ctrl+Shift+R`). The Apache config already disables HTML caching, but the browser may still hold an in-memory copy.
- Confirm the build actually completed: `ls -la /var/www/theshelter/build/index.html` should have a fresh timestamp.
- Confirm Apache can read it: `sudo -u www-data cat /var/www/theshelter/build/index.html | head` should print HTML, not "Permission denied".

### Build fails
```bash
cd /var/www/theshelter
yarn cache clean
rm -rf node_modules
yarn install
yarn build
```

### Apache logs
```bash
sudo tail -f /var/log/apache2/theshelter-error.log
sudo tail -f /var/log/apache2/theshelter-access.log
```

### DNS / port check
```bash
nslookup thesheltercommunity.servegame.com
nc -zv thesheltercommunity.servegame.com 8080
```

### Router / ISP
- Confirm port 8080 is forwarded to your server's LAN IP.
- Test from a phone on cellular data (off your home Wi-Fi) to confirm the ISP isn't also blocking 8080.
