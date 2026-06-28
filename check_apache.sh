#!/bin/bash
# Run these commands on your server

echo "=== Checking Port 80 ==="
sudo netstat -tulpn | grep :80

echo ""
echo "=== Your Server's Internal IP ==="
hostname -I

echo ""
echo "=== Your Public IP ==="
curl -s ifconfig.me
echo ""

echo ""
echo "=== What your domain resolves to ==="
nslookup thesheltercommunity.servegame.com

echo ""
echo "=== Apache Virtual Hosts ==="
apache2ctl -S

echo ""
echo "=== Test local access ==="
curl -I http://localhost/
