# Squaremap Web Server Setup Guide for The Shelter

## Step 1: Check Current Web Server Status

Run these commands on your Minecraft server (via SSH):

```bash
# Check if nginx is installed and running
sudo systemctl status nginx

# If nginx not found, check for Apache
sudo systemctl status apache2
# or
sudo systemctl status httpd

# Check what's listening on port 80
sudo netstat -tulpn | grep :80

# Check what's listening on port 8080 (common alternative)
sudo netstat -tulpn | grep :8080
```

---

## Step 2: Firewall Check

```bash
# Check firewall status
sudo ufw status

# If firewall is active, allow HTTP/HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw reload

# For iptables (if ufw not installed)
sudo iptables -L -n | grep 80
```

---

## Step 3: Router Port Forwarding

You mentioned ports are open, but let's verify:

**Your router needs to forward:**
- External Port 80 → Internal IP (your server) Port 80
- External Port 443 → Internal IP (your server) Port 443

**To find your server's internal IP:**
```bash
ip addr show | grep inet
# or
hostname -I
```

---

## Step 4: Install/Configure nginx (Recommended)

### If nginx is NOT installed:
```bash
# Install nginx
sudo apt update
sudo apt install nginx -y

# Start and enable nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Check status
sudo systemctl status nginx
```

### Configure nginx for Squaremap:
```bash
# Create nginx config file
sudo nano /etc/nginx/sites-available/squaremap
```

**Paste this configuration:**
```nginx
server {
    listen 80;
    server_name thesheltercommunity.servegame.com;

    # Squaremap location
    location /sheltermcmap {
        alias /home/shelterowner/minecraft/paper/plugins/squaremap/web;
        index index.html;
        try_files $uri $uri/ =404;
        
        # Enable CORS for map tiles
        add_header Access-Control-Allow-Origin *;
        
        # Cache settings for map tiles
        location ~* \.(png|jpg|jpeg|gif|ico|svg)$ {
            expires 1h;
            add_header Cache-Control "public, immutable";
        }
    }

    # Main site (if you want landing page on root domain)
    location / {
        # You can proxy to your landing page app here
        # For now, return a simple message
        return 200 "The Shelter Community Server";
        add_header Content-Type text/plain;
    }
}
```

**Enable the site:**
```bash
# Create symlink to enable site
sudo ln -s /etc/nginx/sites-available/squaremap /etc/nginx/sites-enabled/

# Remove default site (optional)
sudo rm /etc/nginx/sites-enabled/default

# Test nginx configuration
sudo nginx -t

# If test passes, reload nginx
sudo systemctl reload nginx
```

---

## Step 5: Set Correct File Permissions

```bash
# Give nginx permission to read the files
sudo chmod -R 755 /home/shelterowner/minecraft/paper/plugins/squaremap/web

# If needed, change ownership
sudo chown -R www-data:www-data /home/shelterowner/minecraft/paper/plugins/squaremap/web
```

---

## Step 6: Test Locally First

```bash
# Test from the server itself
curl http://localhost/sheltermcmap

# Should return HTML content from index.html
```

---

## Step 7: Test Externally

From your browser (NOT on the server):
```
http://thesheltercommunity.servegame.com/sheltermcmap
```

---

## Troubleshooting

### If you can access localhost but not externally:

**1. Check NoIP DNS:**
```bash
# Check what IP your domain resolves to
nslookup thesheltercommunity.servegame.com

# Compare with your public IP
curl ifconfig.me
```

**2. Check if port 80 is reachable from outside:**
```bash
# From another computer/phone (not on your network):
telnet thesheltercommunity.servegame.com 80
# or
nc -zv thesheltercommunity.servegame.com 80
```

**3. Router Port Forwarding Settings Should Be:**
```
Service Name: HTTP
External Port: 80
Internal IP: [Your server's local IP, e.g., 192.168.1.100]
Internal Port: 80
Protocol: TCP
```

**4. ISP Blocking Port 80:**
Some ISPs block port 80. If so, use port 8080:

```nginx
# In nginx config, change to:
server {
    listen 8080;
    # ... rest of config
}
```

Then access via: `http://thesheltercommunity.servegame.com:8080/sheltermcmap`

And forward router port 8080 → server port 8080.

---

## Step 8: Check nginx Logs if Issues

```bash
# Error log
sudo tail -f /var/log/nginx/error.log

# Access log
sudo tail -f /var/log/nginx/access.log
```

---

## Quick Test Commands Summary

Run these in order to diagnose:

```bash
# 1. Is nginx running?
sudo systemctl status nginx

# 2. Is port 80 listening?
sudo netstat -tulpn | grep :80

# 3. Can you access locally?
curl http://localhost/sheltermcmap

# 4. What's your public IP?
curl ifconfig.me

# 5. What does your domain resolve to?
nslookup thesheltercommunity.servegame.com

# 6. Check firewall
sudo ufw status

# 7. Check nginx errors
sudo tail -20 /var/log/nginx/error.log
```

---

## After Setup: Update Landing Page URL if Needed

If you end up using a different port (like 8080), update the landing page:

Edit `/app/frontend/src/data/mock.js`:
```javascript
squaremapUrl: "http://thesheltercommunity.servegame.com:8080/sheltermcmap",
```

---

## Need Help?

Run the diagnostic commands above and share the output. I can help troubleshoot specific issues!
