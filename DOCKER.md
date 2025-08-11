# 🐳 Docker Deployment Guide

## Quick Start

### 1. Build and Run with Docker
```bash
# Build the image
docker build -t mcp-server .

# Run with environment variables
docker run -p 8086:8086 \
  -e AUTH_TOKEN=debugger0007 \
  -e GEMINI_API_KEY=your_gemini_api_key \
  -e MY_NUMBER=your_phone_number \
  -e DEBUG=false \
  mcp-server
```

### 2. Using Docker Compose (Recommended)

Create a `.env` file for docker-compose:
```bash
# Copy and edit environment file
cp .env.example .env
```

Then run:
```bash
# Start the service
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the service
docker-compose down
```

### 3. Environment Variables

**Required:**
- `AUTH_TOKEN`: Your authentication token
- `GEMINI_API_KEY`: Google Gemini API key
- `MY_NUMBER`: Your phone number with country code

**Optional:**
- `DEBUG`: Enable debug logging (default: false)
- `HOST`: Server host (default: 0.0.0.0)
- `PORT`: Server port (default: 8086)

### 4. Health Check

The container includes a health check endpoint:
```bash
# Check container health
docker ps

# Manual health check
curl http://localhost:8086/mcp/
```

### 5. Production Deployment

For production use:
```bash
# Build for production
docker build -t mcp-server:prod .

# Run with production settings
docker run -d \
  --name mcp-server-prod \
  --restart unless-stopped \
  -p 8086:8086 \
  -e AUTH_TOKEN=your_secure_token \
  -e GEMINI_API_KEY=your_api_key \
  -e MY_NUMBER=your_number \
  -e DEBUG=false \
  mcp-server:prod
```

### 6. Troubleshooting

**Container won't start:**
```bash
# Check logs
docker logs container_name

# Debug with interactive shell
docker run -it --entrypoint /bin/bash mcp-server
```

**Environment variables not working:**
- Verify .env file exists for docker-compose
- Check variable names match exactly
- Ensure no quotes around values in docker run commands

**Health check failing:**
- Verify port 8086 is accessible
- Check if application started successfully
- Review application logs for errors

### 7. Development with Docker

For development with auto-reload:
```bash
# Mount source code as volume
docker run -p 8086:8086 \
  -v $(pwd):/app \
  -e AUTH_TOKEN=debugger0007 \
  -e GEMINI_API_KEY=your_key \
  -e MY_NUMBER=your_number \
  -e DEBUG=true \
  mcp-server
```

### 8. Multi-platform Build

For deployment across different architectures:
```bash
# Build for multiple platforms
docker buildx build --platform linux/amd64,linux/arm64 -t mcp-server .
```
