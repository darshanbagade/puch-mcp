#!/bin/bash

# Product Price Finder MCP Server Deployment Script
# For Ubuntu/Debian servers

echo "🚀 Starting MCP Server deployment..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install Python 3.11 and pip
sudo apt install -y python3.11 python3.11-pip python3.11-venv git curl

# Create application directory
sudo mkdir -p /opt/mcp-server
cd /opt/mcp-server

# Create virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Create systemd service
sudo tee /etc/systemd/system/mcp-server.service > /dev/null <<EOF
[Unit]
Description=Product Price Finder MCP Server
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/opt/mcp-server
Environment=PATH=/opt/mcp-server/venv/bin
ExecStart=/opt/mcp-server/venv/bin/python main.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable mcp-server
sudo systemctl start mcp-server

# Install and configure nginx (optional)
sudo apt install -y nginx
sudo tee /etc/nginx/sites-available/mcp-server > /dev/null <<EOF
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:8086;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/mcp-server /etc/nginx/sites-enabled/
sudo systemctl restart nginx

echo "✅ MCP Server deployed successfully!"
echo "🔗 Server URL: http://your-server-ip:8086/mcp/"
echo "📊 Check status: sudo systemctl status mcp-server"
echo "📝 View logs: sudo journalctl -u mcp-server -f"
