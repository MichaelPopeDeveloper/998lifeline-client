#!/bin/bash

# Deployment script for 988 Lifeline Client
# VPS: 213.218.240.101
# User: root

set -e

echo "======================================"
echo "988 Lifeline Client Deployment"
echo "======================================"
echo ""

VPS_IP="213.218.240.101"
VPS_USER="root"
APP_DIR="/var/www/988lifeline-client"
APP_NAME="988lifeline-client"

echo "Step 1: Creating application directory on VPS..."
ssh ${VPS_USER}@${VPS_IP} "mkdir -p ${APP_DIR}"

echo ""
echo "Step 2: Transferring files to VPS..."
rsync -avz --exclude='node_modules' \
           --exclude='.next' \
           --exclude='.git' \
           --exclude='README.md' \
           --exclude='.env.local' \
           --exclude='deploy.sh' \
           ./ ${VPS_USER}@${VPS_IP}:${APP_DIR}/

echo ""
echo "Step 3: Creating .env.local on VPS..."
if [ -z "$ANTHROPIC_API_KEY" ]; then
  read -p "Enter your Anthropic API Key: " ANTHROPIC_API_KEY
fi
ssh ${VPS_USER}@${VPS_IP} "cat > ${APP_DIR}/.env.local << EOF
ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY
EOF"

echo ""
echo "Step 4: Installing dependencies on VPS..."
ssh ${VPS_USER}@${VPS_IP} "cd ${APP_DIR} && npm install --production"

echo ""
echo "Step 5: Building application on VPS..."
ssh ${VPS_USER}@${VPS_IP} "cd ${APP_DIR} && npm run build"

echo ""
echo "Step 6: Installing PM2 (if not already installed)..."
ssh ${VPS_USER}@${VPS_IP} "command -v pm2 || npm install -g pm2"

echo ""
echo "Step 7: Stopping existing PM2 process (if running)..."
ssh ${VPS_USER}@${VPS_IP} "cd ${APP_DIR} && pm2 stop ${APP_NAME} || true"

echo ""
echo "Step 8: Starting application with PM2..."
ssh ${VPS_USER}@${VPS_IP} "cd ${APP_DIR} && pm2 start ecosystem.config.js"

echo ""
echo "Step 9: Saving PM2 configuration..."
ssh ${VPS_USER}@${VPS_IP} "pm2 save"

echo ""
echo "Step 10: Setting up PM2 to start on boot..."
ssh ${VPS_USER}@${VPS_IP} "pm2 startup systemd -u ${VPS_USER} --hp /root || true"

echo ""
echo "======================================"
echo "Deployment Complete!"
echo "======================================"
echo ""
echo "Your application should now be running on:"
echo "http://${VPS_IP}:3000"
echo ""
echo "To check status: ssh ${VPS_USER}@${VPS_IP} 'pm2 status'"
echo "To view logs: ssh ${VPS_USER}@${VPS_IP} 'pm2 logs ${APP_NAME}'"
echo ""
echo "Next step: Configure nginx to proxy to port 3000"
