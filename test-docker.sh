#!/bin/bash
# Docker Deployment Test Script

echo "🐳 Testing Docker deployment for MCP Server..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Build the Docker image
echo "🔨 Building Docker image..."
if docker build -t mcp-server-test .; then
    echo "✅ Docker image built successfully"
else
    echo "❌ Docker build failed"
    exit 1
fi

# Test with environment variables
echo "🧪 Testing Docker run with environment variables..."
docker run -d --name mcp-test -p 8087:8086 \
    -e AUTH_TOKEN=test_token_123 \
    -e GEMINI_API_KEY=test_key_456 \
    -e MY_NUMBER=1234567890 \
    -e DEBUG=true \
    mcp-server-test

# Wait for container to start
echo "⏳ Waiting for container to start..."
sleep 10

# Check if container is running
if docker ps | grep mcp-test > /dev/null; then
    echo "✅ Container is running"
    
    # Test health endpoint (if available)
    echo "🔍 Testing container health..."
    if curl -f http://localhost:8087/mcp/ &> /dev/null; then
        echo "✅ Health check passed"
    else
        echo "⚠️ Health check failed (this might be expected for MCP protocol)"
    fi
    
    # Show logs
    echo "📋 Container logs:"
    docker logs mcp-test
    
else
    echo "❌ Container failed to start"
    docker logs mcp-test
fi

# Cleanup
echo "🧹 Cleaning up test container..."
docker stop mcp-test 2>/dev/null || true
docker rm mcp-test 2>/dev/null || true

echo "🎉 Docker test completed!"
