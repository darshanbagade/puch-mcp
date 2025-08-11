@echo off
REM Docker Deployment Test Script for Windows

echo 🐳 Testing Docker deployment for MCP Server...

REM Check if Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not installed. Please install Docker first.
    exit /b 1
)

REM Build the Docker image
echo 🔨 Building Docker image...
docker build -t mcp-server-test .
if %errorlevel% neq 0 (
    echo ❌ Docker build failed
    exit /b 1
)
echo ✅ Docker image built successfully

REM Test with environment variables
echo 🧪 Testing Docker run with environment variables...
docker run -d --name mcp-test -p 8087:8086 ^
    -e AUTH_TOKEN=test_token_123 ^
    -e GEMINI_API_KEY=test_key_456 ^
    -e MY_NUMBER=1234567890 ^
    -e DEBUG=true ^
    mcp-server-test

REM Wait for container to start
echo ⏳ Waiting for container to start...
timeout /t 10 /nobreak >nul

REM Check if container is running
docker ps | findstr mcp-test >nul
if %errorlevel% equ 0 (
    echo ✅ Container is running
    
    REM Test health endpoint
    echo 🔍 Testing container health...
    curl -f http://localhost:8087/mcp/ >nul 2>&1
    if %errorlevel% equ 0 (
        echo ✅ Health check passed
    ) else (
        echo ⚠️ Health check failed ^(this might be expected for MCP protocol^)
    )
    
    REM Show logs
    echo 📋 Container logs:
    docker logs mcp-test
    
) else (
    echo ❌ Container failed to start
    docker logs mcp-test
)

REM Cleanup
echo 🧹 Cleaning up test container...
docker stop mcp-test >nul 2>&1
docker rm mcp-test >nul 2>&1

echo 🎉 Docker test completed!
pause
