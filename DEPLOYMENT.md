# 🚀 Product Price Finder MCP Server - Deployment Guide

## 🐳 Docker Deployment (Fixed!)

**Issue Resolved:** The Docker build was failing because it tried to copy `.env` file which we properly excluded from git for security.

### Quick Docker Start
```bash
# Build the image
docker build -t mcp-server .

# Run with environment variables (no .env file needed!)
docker run -p 8086:8086 \
  -e AUTH_TOKEN=debugger0007 \
  -e GEMINI_API_KEY=your_gemini_key \
  -e MY_NUMBER=your_phone_number \
  -e DEBUG=false \
  mcp-server
```

### Docker Compose (Recommended)
```bash
# Create .env file for docker-compose
cp .env.example .env
# Edit .env with your values

# Start with docker-compose
docker-compose up -d
```

### Test Docker Build
```bash
# Linux/Mac
./test-docker.sh

# Windows
test-docker.bat
```

## Quick Deployment Options

### 1. **Docker (Recommended)**
```bash
# Build and run locally
docker build -t mcp-server .
docker run -p 8086:8086 --env-file .env mcp-server

# Or use docker-compose
docker-compose up -d
```

### 2. **Railway (1-Click Deploy)**
1. Connect your GitHub repo to Railway
2. Set environment variables in Railway dashboard
3. Deploy automatically on push

### 3. **Render (Free Tier)**
1. Connect GitHub repo to Render
2. Use `render.yaml` configuration
3. Set environment variables in dashboard

### 4. **Heroku**
```bash
heroku create your-app-name
heroku config:set AUTH_TOKEN=debugger0007
heroku config:set GEMINI_API_KEY=your_key
heroku config:set MY_NUMBER=your_number
git push heroku main
```

### 5. **AWS EC2 / VPS**
```bash
# Upload files to server
scp -r . user@server:/opt/mcp-server/

# Run deployment script
chmod +x deploy.sh
sudo ./deploy.sh
```

### 6. **DigitalOcean App Platform**
1. Connect GitHub repo
2. Set build command: `pip install -r requirements.txt`
3. Set run command: `python main.py`
4. Configure environment variables

## 🔧 Environment Variables

Required for all deployments:
```env
AUTH_TOKEN=debugger0007
GEMINI_API_KEY=your_gemini_api_key
MY_NUMBER=your_phone_number
DEBUG=false
```

## 🌐 Post-Deployment

1. **Test Connection:**
   ```bash
   curl -X POST "https://your-domain.com/mcp/" \
     -H "Authorization: Bearer debugger0007" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json, text/event-stream" \
     -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
   ```

2. **Update WhatsApp Bot:**
   - Change MCP server URL to your deployed endpoint
   - Update authentication if needed

3. **Monitor Performance:**
   - Check server logs for errors
   - Monitor response times
   - Set up health checks

## 🔒 Security Considerations

- Change `AUTH_TOKEN` for production
- Use HTTPS in production
- Implement rate limiting
- Monitor API usage
- Regularly update dependencies

## 📊 Monitoring

- Health check endpoint: `/mcp/`
- Server logs for debugging
- Monitor Gemini API usage
- Track response times

## 🆘 Troubleshooting

- Check environment variables are set
- Verify Gemini API key is valid
- Ensure port 8086 is accessible
- Check firewall settings
- Review server logs for errors
